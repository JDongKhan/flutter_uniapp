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

app项目的build需要配置
```groovy
  //此处配置必须添加 否则无法正确运行  
    aaptOptions {  
        additionalParameters '--auto-add-overlay'  
        //noCompress 'foo', 'bar'  
        ignoreAssetsPattern "!.svn:!.git:.*:!CVS:!thumbs.db:!picasa.ini:!*.scc:*~"  
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