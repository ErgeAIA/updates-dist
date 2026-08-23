# updates-dist

> AI Vault 系列应用的**更新分发仓库**——软件自动更新清单、内置资产清单与安装包统一从这里发布，客户端（Tauri updater）启动时静默检查，发现新版本一键下载安装。

**目录结构**：

```
updates-dist/
├── aivault/
│   ├── updates.json          # AI Vault 软件更新清单（Tauri updater manifest）
│   └── builtin-assets.json   # AI Vault 内置资产清单（MCP / 提示词 / 模型 / 平台 / 供应商 / 技能仓库 / 规则）
└── <future-project>/         # 后续项目各占一个目录，endpoints 指向各自的 updates.json
```

**工作原理**：每个项目在 `tauri.conf.json` 的 `plugins.updater.endpoints` 中指向本仓库对应目录的 `updates.json`；安装包发布在本仓库的 GitHub Releases（tag 带项目前缀，如 `aivault-v0.1.1`，多项目共仓不冲突）。GitHub + Gitee 双源镜像，国内用户可用 Gitee 地址访问清单。

---

## AI Vault

> 本地优先、Agent-centric 的 AI 创作者工作台：统一管理 Skill / Prompt / MCP / ComfyUI 工作流 / 模型 / 在线平台 / API 供应商，并向各 Agent 的 skills 目录分发。**AI Vault 是 updates-dist 服务的第一个项目。**

![GitHub 下载量](https://img.shields.io/github/downloads/ErgeAIA/updates-dist/total)

**最新版本**：v0.1.1

| 平台 | 安装包 |
|------|--------|
| Windows x64 | [AI-Vault_0.1.1_x64-setup.exe](https://github.com/ErgeAIA/updates-dist/releases/download/aivault-v0.1.1/AI-Vault_0.1.1_x64-setup.exe) |
| macOS Apple Silicon | [AI-Vault_0.1.1_aarch64.app.tar.gz](https://github.com/ErgeAIA/updates-dist/releases/download/aivault-v0.1.1/AI-Vault_0.1.1_aarch64.app.tar.gz) |
| macOS Intel | [AI-Vault_0.1.1_x86_64.app.tar.gz](https://github.com/ErgeAIA/updates-dist/releases/download/aivault-v0.1.1/AI-Vault_0.1.1_x86_64.app.tar.gz) |

> **macOS 平台说明**：未启用 Apple 代码签名（免费软件策略），首次打开请 **右键 → 打开** 绕过 Gatekeeper。

**软件自动更新**：客户端启动时静默检查本仓库 `aivault/updates.json`，发现新版本后侧边栏显示更新徽章，点击「更新到 vX.Y.Z」一键下载安装并重启，无需手动访问本页。

## 作者信息

<table>
<tr>
<td align="center" valign="middle" width="220">
<img src="https://github.com/ErgeAIA.png" width="100" style="border-radius: 50%"><br>
<b>宝藏二哥AIA / ErgeAIA</b><br>
<sub>生命不息，折腾不止</sub>
</td>
<td valign="middle" style="padding-left: 18px;">

**关于我**：独立开发者 / 全栈工程师 / ComfyUI 爱好者 / Vibe Coding 实践者<br>
**技术栈**：Tauri · Rust · React · Python · Claude · ZCode · Workbuddy<br>
**理念**：三无分享 — 无门槛、无套路、无保留

**链接**：
📺 [B 站](https://space.bilibili.com/67221461) · [知乎](https://www.zhihu.com/people/meli55a/posts) · 微信公众号(ErgeAIA)<br>
🐙 [GitHub](https://github.com/ErgeAIA) · [Gitee](https://gitee.com/ErgeAIA)<br>
📦 精选项目：[ErgeMD](https://github.com/ErgeAIA/ErgeMD) · [ErgeHash](https://github.com/ErgeAIA/ErgeHash) · [catapult-cn](https://github.com/ErgeAIA/catapult-cn)

</td>
</tr>
</table>

---

<div align="center">

如果这些工具帮到了你，欢迎点个 ⭐ 鼓励一下！

<sub>用 ❤️ 和 Tauri 制作</sub>

</div>
