# ClipboardSyncClient

剪切板数据快速同步工具。因为国内iCloud环境问题，剪切板多平台同步就是个玄学，所以开发了此工具。此工具不通过iCloud，而是通过自建服务器中转分发剪切板数据。

## 你可能还需要...

服务端：https://github.com/cernard/ClipboardSyncServer.git

# 工作流程

1. 向服务器注册
2. 监听服务端广播的其他设备的剪切板新数据
3. 向服务端发送剪切板新数据

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
