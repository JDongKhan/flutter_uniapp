# flutter_uniapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

1、app项目需要拷贝lib下的所有jar和aar
2、app项目需要拷贝assets下的所有资源（如果不需要本地部署，则不需要拷贝apps下的资源）
3、app项目的build需要配置
```groovy
  //此处配置必须添加 否则无法正确运行  
    aaptOptions {  
        additionalParameters '--auto-add-overlay'  
        //noCompress 'foo', 'bar'  
        ignoreAssetsPattern "!.svn:!.git:.*:!CVS:!thumbs.db:!picasa.ini:!*.scc:*~"  
    }
    
```