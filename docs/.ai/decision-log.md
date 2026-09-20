---
title: Decision Log
type: decision-log
project: updates-dist
updated: 2026-09-20
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

## DEC-001: 优化 macOS 安装指引并反馈缺少标准 .dmg 安装包

- **日期**：2026-09-20
- **背景**：当前分发仓与源项目 Releases 中，macOS 平台仅提供 Tauri updater 专用的 `.app.tar.gz` 压缩归档，普通用户常因缺少 `.dmg` 引导而误以为缺少 Mac 安装包，且解压后易遭 Gatekeeper 误报损坏拦截。
- **决策**：在 README.md 补充 `.app.tar.gz` 解压至 `/Applications` 的明确安装步骤与 `xattr -cr` 绕过拦截命令；并在 Pull Request 中向上游建议在 CI 发版中增加标准 `.dmg` 产物分发。
- **验证**：执行 `bash scripts/verify-dist-layout.sh` 通过；本地应用解包与 `xattr -cr` 验证通过。

