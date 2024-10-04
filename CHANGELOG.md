<a name="unreleased"></a>
## [Unreleased]

### Feat
- 添加changelog


<a name="v0.1"></a>
## v0.1 - 2024-10-04
### Feat
- Add config_init_test.dart file
-  实现userInfo和auth的provider，全局状态共享用户信息和jwt信息 fix: 修复了每次打开Settings页面用户信息都要闪一次的问题 - 使用provider共享状态变量巧妙地解决了这个问题 feat: 向build.gradle添加flutter mirror
- 添加登录和注册页面的相关逻辑
- 添加相关api请求函数，用sharedPreferences实现了用户信息的存储逻辑
- 添加 config.yaml 文件，包含 API URL
- 添加登录和注册也买你，修改用户信息页面
- 添加主题管理器，添加各种主题，项目结构修改
- 实现将主题两种模式存储到isar中，并把初始化isar的函数抽离出来
- 添加Google Fonts，添加privacy页面和about页面

### Fix
- 修复弹出的盒子颜色不正确的问题

### Reconstructed
- 使用flutter重构todoapp,本地存储功能完成


[Unreleased]: https://github.com/meowrain/SimpleTodoV2/compare/v0.1...HEAD
