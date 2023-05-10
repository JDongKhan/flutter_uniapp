package com.flutter.uniapp.flutter_uniapp.uniapp;

import android.content.Context;
import android.os.Handler;
import android.util.Log;
import android.widget.Toast;

import com.alibaba.fastjson.JSONObject;
import com.flutter.uniapp.flutter_uniapp.uniapp.util.DownloadUtil;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IDCUniMPOnCapsuleCloseButtontCallBack;
import io.dcloud.feature.sdk.Interface.IDCUniMPOnCapsuleMenuButtontCallBack;
import io.dcloud.feature.sdk.Interface.IDCUniMPPreInitCallback;
import io.dcloud.feature.sdk.Interface.IMenuButtonClickCallBack;
import io.dcloud.feature.sdk.Interface.IUniMP;
import io.dcloud.feature.sdk.MenuActionSheetItem;
import io.dcloud.feature.unimp.config.IUniMPReleaseCallBack;
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration;
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration;

/**
 * @author jd
 */
public class UniAppSDK {


    public static void initSDK(Context context){
//        try {
//            WXSDKEngine.registerModule("TestModule", TestModule.class);
//            WXSDKEngine.registerComponent("myText", TestText.class);
//        } catch (WXException e) {
//            e.printStackTrace();
//        }
        //初始化 uni小程序SDK ----start----------
        MenuActionSheetItem item = new MenuActionSheetItem("关于", "gy");

        MenuActionSheetItem item1 = new MenuActionSheetItem("获取当前页面url", "hqdqym");
        MenuActionSheetItem item2 = new MenuActionSheetItem("跳转到宿主原生测试页面", "gotoTestPage");
        List<MenuActionSheetItem> sheetItems = new ArrayList<>();
        sheetItems.add(item);
        sheetItems.add(item1);
        sheetItems.add(item2);
        Log.i(DownloadUtil.TAG,"onCreate----");
        DCSDKInitConfig config = new DCSDKInitConfig.Builder()
                .setCapsule(true)
                .setMenuDefFontSize("16px")
                .setMenuDefFontColor("#ff00ff")
                .setMenuDefFontWeight("normal")
                .setMenuActionSheetItems(sheetItems)
                .setEnableBackground(true)//开启后台运行
                .setUniMPFromRecents(false)
                .build();
        DCUniMPSDK.getInstance().initialize(context, config, new IDCUniMPPreInitCallback() {
            @Override
            public void onInitFinished(boolean b) {
                Log.d(DownloadUtil.TAG,"onInitFinished----"+b);
            }
        });
        //初始化 uni小程序SDK ----end----------


        //用来测试sdkDemo 胶囊×的点击事件，是否生效；lxl增加的
        DCUniMPSDK.getInstance().setCapsuleCloseButtonClickCallBack(new IDCUniMPOnCapsuleCloseButtontCallBack() {
            @Override
            public void closeButtonClicked(String appid) {
                Toast.makeText(context, "点击×号了", Toast.LENGTH_SHORT).show();
                if(mUniMPCaches.containsKey(appid)) {
                    IUniMP mIUniMP = mUniMPCaches.get(appid);
                    if (mIUniMP != null && mIUniMP.isRuning()){
                        mIUniMP.closeUniMP();
                        mUniMPCaches.remove(appid) ;
                    }
                }
            }
        });
        //处理点击菜单事件
        DCUniMPSDK.getInstance().setDefMenuButtonClickCallBack(new IMenuButtonClickCallBack() {
            @Override
            public void onClick(String s, String s1) {
                Toast.makeText(context, "点击"+s1+"了", Toast.LENGTH_SHORT).show();
            }
        });

    }

    /** unimp小程序实例缓存**/
    public static   HashMap<String, IUniMP> mUniMPCaches = new HashMap<>();


    public static void openMini(Context context, String path) {
        try {
            IUniMP uniMP = DCUniMPSDK.getInstance().openUniMP(context,"__UNI__F743940");
            mUniMPCaches.put(uniMP.getAppid(), uniMP);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void openRemoteMini(Context context, String wgtUrl, String path) {
        //TODO 需要申请 android.permission.WRITE_EXTERNAL_STORAGE 权限
        //
        final String wgtName;
        if (wgtUrl == null || wgtUrl.isEmpty()) {
            wgtUrl = "https://native-res.dcloud.net.cn/unimp-sdk/__UNI__7AEA00D.wgt";
        }
        wgtName = wgtUrl.substring(wgtUrl.lastIndexOf('/')+1);
        JSONObject arguments = new JSONObject();
        arguments.put("a","1");

        String downFilePath = context.getExternalCacheDir().getPath();

        Handler uiHandler = new Handler();
        DownloadUtil.get().download(context, wgtUrl, downFilePath, wgtName, new DownloadUtil.OnDownloadListener() {

            @Override
            public void onDownloadSuccess(File file) {
                UniMPReleaseConfiguration uniMPReleaseConfiguration = new UniMPReleaseConfiguration();
                uniMPReleaseConfiguration.wgtPath = file.getPath();
                uniMPReleaseConfiguration.password = "789456123";
                uiHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        DCUniMPSDK.getInstance().releaseWgtToRunPath("__UNI__7AEA00D", uniMPReleaseConfiguration, new IUniMPReleaseCallBack() {
                            @Override
                            public void onCallBack(int code, Object pArgs) {
                                if(code ==1) {
                                    //释放wgt完成
                                    try {
                                        UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
                                        uniMPOpenConfiguration.splashClass = MySplashView.class;
                                        uniMPOpenConfiguration.extraData.put("darkmode", "auto");
                                        DCUniMPSDK.getInstance().openUniMP(context, "__UNI__7AEA00D",uniMPOpenConfiguration);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                } else{
                                    //释放wgt失败
                                }
                            }
                        });
                    }
                });


            }

            @Override
            public void onDownloading(int progress) {

            }

            @Override
            public void onDownloadFailed() {
                Log.e("unimp", "downFilePath  ===  onDownloadFailed");
            }
        });
    }
}
