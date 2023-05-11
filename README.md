# flutter_uniapp

基于uniapp 小程序sdk 3.7.11版本集成

### 安装依赖：

```yaml

 # 添加依赖
  flutter_uniapp: 
    git:
      url: https://github.com/JDongKhan/flutter_uniapp.git
      ref: main

```

## Android 
### 拷贝资源

app项目需要拷贝assets下的所有资源（如果不需要本地部署，则不需要拷贝apps下的资源）

### app项目配置

app项目的build.gradle需要配置
```groovy


android: {
  defaultConfig {
    applicationId "com.flutter.uniapp.flutter_uniapp_example"
    minSdkVersion 21
    multiDexEnabled true
    manifestPlaceholders['apk.applicationId'] = applicationId
    ndk {
        //选择要添加的对应 cpu 类型的 .so 库。
        abiFilters 'x86','armeabi-v7a',"arm64-v8a" //不支持armeabi
    }
  }
  aaptOptions {
      additionalParameters '--auto-add-overlay'
      ignoreAssetsPattern "!.svn:!.git:.*:!CVS:!thumbs.db:!picasa.ini:!*.scc:*~"
  }  
}

依赖
implementation fileTree(include: ['*.aar'], dir:  project(':flutter_uniapp').file('libs'))
    
```



## iOS

注：liblibWeex.a文件由于太大导致上传不了，所以使用时还需要自行去官方sdk下拷贝一个liblibWeex.a文件到ios/Core/Libs即可

拷贝官方SDK Core/Resources下的所有资源文件到flutter中iOS项目中即可


```
__uniappes6.js
PandoraApi.bundle
uni-jsframework-vue3.js
uni-jsframework.js
unincomponents.ttf
weex-polyfill.js
weexUniJs.js

```

如果需要加载项目的wgt，可以将demo中的wgt也拷贝到host工程中


### 方法说明

#### 导入头文件

```dart

import 'package:flutter_uniapp/flutter_uniapp.dart';

```

#### 初始化

```dart

 FlutterUniapp.initSDK();

```

#### 唤起UniApp

```dart

FlutterUniapp.openMini()

```