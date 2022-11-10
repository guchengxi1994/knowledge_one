# knowledge_one

这是一个练手项目，主要使用 flutter + rust （+ gRPC）

![image](./images/intro.png)

flutter 版本是3.3.7，但是更推荐3.0.5（如果降低版本的话，要相应修改[pubspec.yaml](./pubspec.yaml)）。因为3.3.*的有些版本有bug，比如[#110957](https://github.com/flutter/flutter/issues/110957)(我自己测试是因为添加了decoration 的border属性),还有vscode上debug程序的时候使用`left ctrl`查看代码会有问题。

## changelogs

* 0.0.1 [details](./changelogs/0_0_1.md)