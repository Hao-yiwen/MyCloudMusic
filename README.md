# 我的云音乐

[![Swift](https://img.shields.io/badge/Swift-5.0-F05138?logo=swift&logoColor=white)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0%2B-000000?logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-1.11.2-EE3322?logo=cocoapods&logoColor=white)](https://cocoapods.org)

用 Swift 写的 iOS 练习项目。界面文案是「我的云音乐」，启动后走闪屏、服务条款确认和引导页；引导页上的「立即体验」会向课程接口拉一页歌单并打印到控制台。播放器、登录表单和首页内容还没有做。

工程里的版权文案、接口域名（`ixuea.com`）和提交记录都指向一套云音乐课程示例。仓库目前停在启动流程和一次网络试调，适合对照源码看页面是怎么串起来的。

## 现在能看到什么

应用启动后由 `AppDelegate` 把根控制器设为闪屏，之后按本地是否同意过协议往下走：

```text
启动
  └─ SplashViewController（插画、Logo、「我的云音乐」、版权年份）
       ├─ 尚未同意协议 → 条款弹窗
       │     ├─ 「同意」→ 写入 UserDefaults，进入引导页
       │     └─ 「不同意并退出应用」→ exit(0)
       └─ 已经同意 → GuideController
             ├─ 「登录」→ 红色占位首页，并发送 EVENT_LOGIN_CLICK
             └─ 「立即体验」→ GET /v1/sheets?size=10，结果只 print，页面不切换
```

各页面的实际内容：

| 页面 | 源码 | 现状 |
| --- | --- | --- |
| 闪屏 | `MyCloudMusic/Component/Splash/Controller/SplashViewController.swift` | 展示 `SplashBanner`、应用名，以及 `Copyright @c {年份} Ixuea, All Rights Reserved`。`prepareNext()` 会立刻进入引导页，没有倒计时。 |
| 条款弹窗 | `TermServiceDialogController.swift` | 标题走本地化字符串。正文是一段关于视图生命周期的占位文字，不是正式协议。 |
| 引导页 | `GuideController.swift` | 两个按钮：「登录」「立即体验」。 |
| 首页 | `MainController.swift` | 包在 `UINavigationController` 里，背景设为红色，没有列表或播放控件。 |
| 登录页 | `LoginController.swift` | 类存在，背景为蓝色。当前没有任何地方把它压进导航栈。`toLogin()` 直接去首页，再发一条名为 `EVENT_LOGIN_CLICK` 的通知，工程里没有观察者。 |

接口定义在 `DefaultService`，基址是 `Config.ENDPOINT`：

| 用例 | 方法与路径 | 调用情况 |
| --- | --- | --- |
| `sheets(size:)` | `GET v1/sheets?size=` | 引导页「立即体验」会请求，并用 HandyJSON 解析 `SheetListResponse`，把 `status` 和第一条歌单的 `title` 打印出来。 |
| `ads(position:)` | `GET v1/ads?position=` | 只声明了，界面没有调用。 |
| `register(data:)` | `POST v1/users` | 只声明了。`task` 仍是 `requestPlain`，`User` 是空类，没有组请求体。 |

`Config.RESOURCE_ENDPOINT`（`http://course-music-dev.ixuea.com/`）写在配置里，当前 Swift 源码没有引用它。`Info.plist` 打开了 `NSAllowsArbitraryLoads`，因此可以使用上面的 HTTP 地址。

本地化表（`en` / `zh-Hans`）只有三条：找不到服务器、条款标题、登录按钮。闪屏上的应用名和按钮「立即体验」是代码里的中文硬编码。`CFBundleName` 中文为「我的云音乐」，英文为「CloudMusic」。

## 资源图

下面两张是资源目录里的插画，不是模拟器截图。本仓库没有界面运行截图。

启动页插画 `SplashBanner`（浅色 1x；深色和其他倍率的槽位是空的，Logo 也复用这张图）：

![启动页插画，白底竖排「长路漫漫」「唯剑相伴」](<MyCloudMusic/Assets.xcassets/SplashBanner.imageset/DALL·E 2023-10-22 20.45.45 - Illustration with a pure white background, prominently featuring two vertical lines of Chinese characters, '长路漫漫' on the left and '唯剑相伴' on the right,.png>)

App Icon（1024×1024，蓝底白色音符）：

![应用图标，蓝底白色音符](<MyCloudMusic/Assets.xcassets/AppIcon.appiconset/DALL·E 2023-10-22 16.27.19 - Illustration of a minimalistic music app icon, featuring a simple white musical note centered on a muted blue background.png>)

## 技术栈

应用 target：Swift 5.0，部署目标 iOS 13.0，`TARGETED_DEVICE_FAMILY = 1,2`（iPhone 与 iPad），版本号 1.0（`MARKETING_VERSION`），Bundle ID `com.yiwen.MyCloudMusic`。工程 `LastUpgradeCheck` 为 1500，对应 Xcode 15。签名方式是 Automatic，工程里记录的 Development Team 是 `84F8R9TAQN`。

`Podfile` 未固定平台版本（`platform :ios` 那一行是注释）。锁定版本来自已提交的 `Podfile.lock`（CocoaPods 1.11.2）：

| Pod | 锁定版本 | 在当前业务代码中的用途 |
| --- | --- | --- |
| TangramKit | 1.4.2 | 闪屏、引导页和基类里的相对/线性布局 |
| QMUIKit | 4.7.0 | 按钮和条款弹窗（`QMUIModalPresentationViewController`） |
| Moya/RxSwift | 15.0.0 | `DefaultService` 与引导页请求（传递依赖 Alamofire 5.8.0、RxSwift 6.6.0） |
| NSObject+Rx | 5.2.2 | 引导页用 `rx.disposeBag` 回收订阅 |
| HandyJSON | 5.0.2 | `Sheet`、`PageResponse`、`SheetListResponse` |
| DynamicColor | 5.0.1 | 主色 `#d6271c` |
| R.swift | 7.3.2 | 构建阶段生成仓库根目录的 `R.generated.swift` |
| SDWebImage | 5.18.3 | 已加入 Podfile，当前 `MyCloudMusic/` 下的 Swift 文件没有 import 或调用 |

主题色在 `SuperUIThemeExtension`：背景色浅色白、深色黑；主色浅色深色相同。

## 目录

```text
.
├── Podfile / Podfile.lock      CocoaPods 依赖；Pods/ 已提交
├── R.generated.swift           R.swift 构建脚本写出的资源访问代码，位于仓库根目录
├── MyCloudMusic.xcworkspace    请打开这个，而不是 .xcodeproj
├── MyCloudMusic.xcodeproj
├── MyCloudMusic/
│   ├── AppDelegate.swift       窗口与根控制器切换
│   ├── Assets.xcassets         图标、SplashBanner、AccentColor、TestColor
│   ├── Base.lproj/             空白启动 Storyboard
│   ├── en.lproj/ zh-Hans.lproj/
│   ├── Component/
│   │   ├── Splash/             闪屏与条款弹窗
│   │   ├── Guide/              引导页
│   │   ├── Login/              未接入的登录控制器
│   │   ├── Main/               红色占位首页
│   │   ├── Sheet/Model/        歌单模型
│   │   └── User/Model/         空的 User
│   ├── Controller/             BaseController 及布局基类（BaseTitleController 为空子类）
│   ├── Config/                 接口地址、颜色
│   ├── Model/                  分页与歌单列表响应
│   ├── Service/DefaultService.swift
│   ├── Util/                   间距字号、UserDefaults、请求参数、按钮工厂
│   └── Vender/SuperSwift/      取当前年份
├── MyCloudMusicTests/          Xcode 模板单元测试，没有断言
└── MyCloudMusicUITests/        启动应用的模板 UI 测试
```

控制器生命周期约定在 `BaseController`：`viewDidLoad` 依次调用 `initDatum()`、`initViews()`、`initListeners()`。`BaseLogicController` 用 TangramKit 搭安全区内的头、内容、底三块容器。

## 环境

- macOS，安装 Xcode 15 或能打开该工程的更新版本
- iOS 13 及以上的模拟器或真机（应用 target）
- CocoaPods。锁文件由 1.11.2 生成；`Pods/` 已入库
- 单元测试 target `MyCloudMusicTests` 的部署目标是 iOS 17.0，且只包含 iPhone

本仓库在 Linux 上不能编译。下面的 `curl` 在编写 README 的环境里执行过；`xcodebuild`、模拟器和真机运行没有执行。

## 安装与运行

依赖目录已经在仓库里。本机没有改过 `Podfile`、并且 `Pods/Manifest.lock` 与 `Podfile.lock` 一致时，可以直接打开 workspace。构建脚本会对比这两份锁文件，不一致就失败并提示执行 `pod install`。

```bash
git clone https://github.com/Hao-yiwen/MyCloudMusic.git
cd MyCloudMusic

# 仅在缺少 Pods、或改过 Podfile 之后需要
pod install

open MyCloudMusic.xcworkspace
```

在 Xcode 中：

1. 选中 **MyCloudMusic** target。仓库没有提交共享的 `.xcscheme`，第一次打开时由 Xcode 自动创建 scheme。
2. 打开 **Signing & Capabilities**。若本机没有 Team `84F8R9TAQN`，改成自己的开发团队。模拟器运行同样可能要求先选好 Team。
3. 选一台 iOS 13+ 模拟器，或已信任该签名的真机，然后 Run。

命令行编译（需要本机已有对应 scheme 和模拟器）：

```bash
xcodebuild \
  -workspace MyCloudMusic.xcworkspace \
  -scheme MyCloudMusic \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  build
```

构建时 Run Script 会执行：

```bash
"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"
```

因此必须从 **workspace** 构建，`R.generated.swift` 会被写到仓库根目录。

运行后的预期：

1. 第一次出现条款弹窗。点「同意」后进入引导页；该选择保存在 `UserDefaults` 键 `TERMS_SERVICE`。删除 App 可再次看到弹窗。
2. 「登录」进入红色首页。
3. 「立即体验」留在引导页。在 Xcode 控制台查看请求结果：解析成功时打印状态码和第一条歌单标题，失败时打印 `network error`。

接口基址写在 `MyCloudMusic/Config/Config.swift`：

```text
http://my-cloud-music-api-sp3-dev.ixuea.com/
```

编写本文时，在当前环境执行下面的请求得到了 **HTTP 200** 和 JSON（`data.total`、`data.data[]`，字段含 `id`、`title`、`icon`）：

```bash
curl -sS "http://my-cloud-music-api-sp3-dev.ixuea.com/v1/sheets?size=1"
```

这是课程环境的开发服务器，可用性不由本仓库保证。响应里可以没有 `status` 字段，模型里的 `status` 会保持默认值 `0`。

## 测试

`MyCloudMusicTests` 与 `MyCloudMusicUITests` 仍是 Xcode 新建工程时的模板：`testExample` 没有断言，UI 测试只负责 `launch()`。在 Xcode 里对 **MyCloudMusic** scheme 执行 Test 即可跑它们。单元测试 target 要求 iOS 17。

## 备注

- 请打开 `MyCloudMusic.xcworkspace`。直接打开 `MyCloudMusic.xcodeproj` 链不上 CocoaPods。
- `Pods/`、用户状态 `xcuserdata` 和根目录 `R.generated.swift` 都在版本库里。
- 深色模式只区分了背景色。`SplashBanner` 的深色图位是空的。
- 主色在按钮上用的是 `UIColor.colorPrimary`，描边按钮标题用的是 `UIColor.primaryColor`，两者目前都是 `#d6271c`。
