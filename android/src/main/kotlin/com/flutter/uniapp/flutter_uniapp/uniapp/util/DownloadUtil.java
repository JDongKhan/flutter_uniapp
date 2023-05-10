package com.flutter.uniapp.flutter_uniapp.uniapp.util;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * @author jd
 */
public class DownloadUtil {

    private static DownloadUtil downloadUtil;
    private final OkHttpClient okHttpClient;
    private Context context;
    public static String TAG = "UniApp";

    public static DownloadUtil get() {
        if (downloadUtil == null) {
            downloadUtil = new DownloadUtil();
        }
        return downloadUtil;
    }

    private DownloadUtil() {
        okHttpClient = new OkHttpClient();
    }

    /**
     * @param url 下载连接
     * @param saveDir 储存下载文件的SDCard目录
     * @param listener 下载监听
     */
    public void download(Context context, final String url, final String saveDir, final String fileName, final OnDownloadListener listener) {
        this.context= context;
        // 需要token的时候可以这样做
        // SharedPreferences sp=MyApp.getAppContext().getSharedPreferences("loginInfo", MODE_PRIVATE);
        // Request request = new Request.Builder().header("token",sp.getString("token" , "")).url(url).build();

        Request request = new Request.Builder().url(url).build();
        // 储存下载文件的目录
        File file = new File(saveDir, getNameFromUrl(fileName));
        if (isExistDir(saveDir) && file.exists()){
            listener.onDownloadSuccess(file);
            return;
        }
        okHttpClient.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.w(TAG,"下载失败："+e.getMessage());
                e.printStackTrace();
                // 下载失败
                listener.onDownloadFailed();
            }
            @Override
            public void onResponse(Call call, Response response) throws IOException {
                InputStream is = null;
                byte[] buf = new byte[2048];
                int len = 0;
                FileOutputStream fos = null;
                Log.w(TAG,"存储下载目录："+saveDir);
                try {
                    is = response.body().byteStream();
                    long total = response.body().contentLength();
                    File file = new File(saveDir, getNameFromUrl(fileName));
                    Log.w(TAG,"最终路径："+file);
                    fos = new FileOutputStream(file);
                    long sum = 0;
                    while ((len = is.read(buf)) != -1) {
                        fos.write(buf, 0, len);
                        sum += len;
                        int progress = (int) (sum * 1.0f / total * 100);
                        // 下载中
                        listener.onDownloading(progress);
                    }
                    fos.flush();
                    // 下载完成
                    listener.onDownloadSuccess(file);
                } catch (Exception e) {
                    listener.onDownloadFailed();
                } finally {
                    try {
                        if (is != null) {
                            is.close();
                        }
                    } catch (IOException e) {
                    }
                    try {
                        if (fos != null) {
                            fos.close();
                        }
                    } catch (IOException e) {
                    }
                }
            }
        });
    }

    /**
     * @param saveDir
     * @return
     * @throws IOException
     * 判断下载目录是否存在
     */
    private boolean isExistDir(String saveDir) {
        // 下载位置
        File downloadFile = new File(saveDir);
        if (downloadFile.exists()) {
           return true;
        }
        downloadFile.mkdirs();
        Log.w(TAG,"下载目录："+saveDir);
        return true;
    }

    /**
     * @param url
     * @return
     * 传入文件名
     */
    @NonNull
    public String getNameFromUrl(String url) {
        return url;
    }

    public interface OnDownloadListener {
        /**
         * 下载成功
         */
        void onDownloadSuccess(File file);

        /**
         * @param progress
         * 下载进度
         */
        void onDownloading(int progress);

        /**
         * 下载失败
         */
        void onDownloadFailed();
    }
}