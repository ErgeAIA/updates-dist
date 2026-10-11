---
title: Decision Log
type: decision-log
project: updates-dist
updated: 2026-10-11
priority: higher-than-prd
description: >
  开发过程决策日志，优先级高于 PRD；冲突时以本文件最新条目为准并回写 PRD/ADR。
  只追加，不删除或改写历史。AI 在本文件新增或修改任何条目后，必须同步更新 frontmatter 的 updated 字段为当日日期（YYYY-MM-DD）。
---

# Decision Log

> 偏离 PRD 或做出重要技术选择时在此追加记录。只追加，不删除或改写历史。
> **优先级高于 PRD**：冲突时以本文件最新决策为准，并回写 PRD/ADR。
> 格式：`## DEC-NNN: 标题`，新条目置顶，NNN 三位递增。
> 字段：`- **日期**：` / `- **背景**：` / `- **决策**：` / `- **验证**：`

---

## DEC-001: macOS 分发补 .dmg（首次安装包），与 .app.tar.gz（自动更新包）双文件并存

- **日期**：2026-10-11
- **背景**：外部用户通过 PR #1（37chengshan）反馈 macOS 只有 `.app.tar.gz`、没有 `.dmg`，新用户不知道怎么用（`.tar.gz` 不是给人双击安装的格式）。本仓是更新清单/分发橱窗仓，README 的下载表是用户看到的第一个入口。
- **决策**：
  1. **双文件各司其职，不做取舍**：`.app.tar.gz` 给「程序」——Tauri updater 在 macOS 只认这个格式（下载解压替换 `/Applications`），**必须保留**；`.dmg` 给「人」——双击挂载拖进 Applications，首次安装用它。README 的 macOS 两行改为「首次安装 / 自动更新包」双链接，并在表下写明用途区别（PR 的痛点一半是"文件被误当安装包"，光加文件不解释等于没解决）。
  2. **`.dmg` 不进 updater 清单**：`aivault/updates.json` 与 `aivault/updates-gitee.json` 零改动（发版 CI 的两份清单生成器按 `.exe` / `.app.tar.gz` 后缀过滤，dmg 不会污染自动更新链）。
  3. **GitHub 与 Gitee 双渠道都挂 dmg**：实测现有安装包只有 9/10/7 MB，dmg 同量级，远低于 Gitee 单文件 100 MB / 单仓 1 GB 配额；国内渠道不再依赖网盘（夸克网盘分发渠道已于 2026-09-21 取消，分发以两仓 Releases 为准）。
  4. **README 下载表仍手写，版本 token 交给 CI**：`scripts/sync-dist-readme.mjs`（主仓）只正则替换「最新版本行 / shields 徽章 / `releases/download/aivault-vX.Y.Z/` 路径 / `AI-Vault_X.Y.Z_` 文件名前缀」四处，不生成行也不校验行集 → 新增 dmg 行沿用同一命名即自动跟随发版换版本，**脚本无需修改**。
  5. **放行指引写进 README**：未启用 Apple 代码签名（免费软件策略），右键 → 打开；右键仍被拦则到 系统设置 → 隐私与安全性 点「仍要打开」。签名与公证（$99/年 + CI secrets）是"开箱即用"的真正解，另立决策，不在本期。
- **验证**：dmg 由主仓发版 CI 产出并上传（`.github/workflows/release.yml` 五处 glob/复制点已改，见主仓 DEC-243），**首次真实产物 = 下一个发版 tag**；届时按本仓 `scripts/verify-dist-layout.sh` 复核布局，并人工核对 README 三平台链接与资产名一致（AGENTS.md「发版流程」第 3/6 步）。当前 README 的 dmg 链接在 v0.3.2 发布前为 404，已在表下显式标注「`.dmg` 自 v0.3.2 起随每次发版一同提供」。
