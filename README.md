# flutter_uniapp

### 安装依赖：

```yaml

 # 添加依赖
  flutter_uniapp: 
    git:
      url: https://github.com/JDongKhan/flutter_uniapp.git
      ref: main

```

### 拷贝资源

app项目需要拷贝assets下的所有资源（如果不需要本地部署，则不需要拷贝apps下的资源）

### app项目配置

app项目的build.gradle需要配置
```groovy


def mfph = [
      //包名
      "apk.applicationId" : "替换成自己应用 ID",
]
android: {
  defaultConfig {
    minSdkVersion 21
    multiDexEnabled true
    manifestPlaceholders = mfph
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
 
    
```


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