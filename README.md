# 股票条件监听 Flutter 客户端

基于 Flutter 开发的股票条件监听 Android 应用，支持自选股管理、信号查询、条件触发提醒等功能。

---

## 项目结构

```
lib/
├── main.dart                  # 应用入口
├── bootstrap/                 # 应用启动初始化
├── core/                      # 核心基础设施（网络、存储、常量、异常）
├── data/                      # 数据层（API 请求、数据模型、Repository 实现）
├── domain/                    # 领域层（业务逻辑接口）
├── presentation/              # UI 层（页面、状态管理、路由）
│   ├── pages/                 # 各功能页面
│   ├── routes/                # 路由配置
│   ├── state/                 # Riverpod 状态管理
│   └── view_models/           # 页面 ViewModel
└── shared/                    # 公共组件和工具
```

---

## 环境准备

```bash
# 检查 Flutter 环境是否正常
flutter doctor

# 安装所有依赖包
flutter pub get
```

---

## 调试运行（Debug）

### 在浏览器中运行（无需手机，最快上手）

```bash
# 在 Chrome 中运行，端口 8080
flutter run -d chrome --web-port 8080
```

> **模拟手机尺寸技巧：** 浏览器打开后按 `F12` → 点击 📱 手机图标 → 顶部下拉选择设备型号（如 Pixel 7、iPhone 14），即可看到真实手机比例的界面效果。

### 在 Windows 桌面运行（启动最快）

```bash
flutter run -d windows
```

### 在 Android 模拟器中运行（最接近真机效果）

```bash
# 查看已有模拟器列表
flutter emulators

# 启动指定模拟器（需先在 Android Studio 中创建）
flutter emulators --launch Pixel_7_API_34

# 查看已连接设备
flutter devices

# 运行到模拟器
flutter run -d emulator-5554
```

### 在真实 Android 手机运行

```bash
# 前提：手机开启「USB 调试」（设置 → 开发者选项 → USB调试）
# 用数据线连接电脑后执行：

flutter devices          # 确认手机已被识别
flutter run              # 自动部署到已连接的手机
```

---

## 调试快捷键（终端中使用）

运行 `flutter run` 后，在终端输入以下按键：

| 按键 | 功能说明 |
|------|----------|
| `r` | **热重载（Hot Reload）** — 修改代码后立即刷新界面，不丢失当前状态，最常用 |
| `R` | **热重启（Hot Restart）** — 完整重启 App，状态会重置，比热重载更彻底 |
| `p` | 显示/隐藏 UI 网格辅助线（帮助检查布局对齐） |
| `i` | 显示/隐藏 Widget Inspector（检查每个控件的位置和属性） |
| `q` | 退出并终止 App |

---

## Flutter DevTools 可视化调试工具

运行 App 后终端会打印一个 DevTools 地址，复制到浏览器打开：

```
http://127.0.0.1:端口号/xxxxx=/devtools/
```

DevTools 提供以下功能：

- **Widget Inspector** — 可视化查看 UI 组件树，点击界面元素高亮对应代码
- **性能面板（Performance）** — 检测掉帧、卡顿问题
- **网络请求（Network）** — 查看所有 HTTP 请求和响应内容
- **日志（Logging）** — 查看 print 输出和错误日志

---

## 代码生成（JSON 序列化）

本项目使用 `json_serializable` 自动生成数据模型的 JSON 解析代码，修改 Model 后需要执行：

```bash
# 一次性生成
dart run build_runner build --delete-conflicting-outputs

# 监听模式（文件保存时自动重新生成，开发时推荐）
dart run build_runner watch --delete-conflicting-outputs
```

---

## 打包构建（Build）

### 打包 Android APK（直接安装包）

```bash
# Debug 版本（用于测试，体积较大，无需签名）
flutter build apk --debug

# Release 版本（用于发布，需要配置签名）
flutter build apk --release

# 输出路径：build/app/outputs/flutter-apk/app-release.apk
```

### 打包 Android App Bundle（上传 Google Play 用）

```bash
flutter build appbundle --release

# 输出路径：build/app/outputs/bundle/release/app-release.aab
```

### 打包 Web 版本

```bash
flutter build web

# 输出路径：build/web/（可直接部署到任意静态服务器）
```

### 打包 Windows 桌面版

```bash
flutter build windows

# 输出路径：build/windows/x64/runner/Release/
```

---

## Release 签名配置（发布前必做）

打包正式 APK 前需要配置签名，否则无法上传应用市场：

```bash
# 第1步：生成签名文件（只需做一次）
keytool -genkey -v -keystore android/app/upload-keystore.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias upload

# 第2步：在 android/key.properties 文件中填写签名信息
# （参考 android/key.properties.example 示例文件）

# 第3步：打包
flutter build apk --release
```

---

## 常见问题

**Q: 运行时提示 "This application is not configured to build on the web"**

```bash
# 执行以下命令添加 web 支持
flutter create .
```

**Q: 依赖包更新后编译报错**

```bash
flutter clean
flutter pub get
flutter run
```

**Q: 模型文件修改后 JSON 解析出错**

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 相关资源

- [Flutter 官方文档](https://docs.flutter.dev/)
- [Riverpod 状态管理文档](https://riverpod.dev/)
- [Dio HTTP 客户端文档](https://pub.dev/packages/dio)
- [Flutter DevTools 使用指南](https://docs.flutter.dev/tools/devtools/overview)
