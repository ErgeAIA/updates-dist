---
title: Project Progress
type: project-progress
project: updates-dist
updated: 2026-09-16
description: >
  项目开发进度实时记录：阶段、分支、代码状态、最近进展。每次会话更新。
  AI 在本文件新增进展或修改当前状态后，必须同步更新 frontmatter 的 updated 字段为当日日期（YYYY-MM-DD）。
---

# Project Progress

> 记录当前任务状态、分支和最近进展。每次会话更新。
> 新进展插在「当前状态」之后、旧「最后更新」之前。

---

## 当前状态

- **当前分支**：main
- **阶段**：<当前阶段>
- **代码**：本仓为清单仓，已发布 aivault 更新清单 v0.2.4（GitHub / Gitee 双份）、ergemd 更新清单 v0.4.4、aivault/builtin 内置资产清单 20260827（7 类型 + index.json）
- **工具链**：<已建立的工具链；未建立时写明无哪些>
- **最后更新**：2026-09-16 根治 aivault/aivault 冗余路径 + 发版版本号工作流
  - **根因**：AIVault `.github/workflows/release.yml` 在 `DIST=updates-dist/aivault` 下又 `mkdir -p "$DIST/aivault/builtin"`，产物落到 `aivault/aivault/builtin`（v0.2.0 / v0.2.4 两次由 CI 带回）
  - **修复（AIVault）**：路径改为 `$DIST/builtin`；提交前 `rm -rf $DIST/aivault` + 存在性断言；新增 `scripts/sync-dist-readme.mjs` 随发版同步 README 版本与下载链接
  - **机制（本仓）**：删除当前 `aivault/aivault/`；AGENTS.md 增加禁止冗余路径约定与「发版版本号同步工作流」；新增 `scripts/verify-dist-layout.sh`（冗余路径 / README 与 updates.json 同版本 / Gitee 清单同版本）
  - **校验**：`bash scripts/verify-dist-layout.sh` 通过（无冗余、README=v0.2.4=双清单）
- **最后更新**：2026-09-16 README 版本同步到 v0.2.4
  - 快进本地 main 到 origin/main（纳入 release v0.2.4 的 633b206 / c20cb61）
  - README.md：最新版本与三平台下载链接由 v0.2.3 同步为 v0.2.4，链接以 release aivault-v0.2.4 资产名为准（API 已核对三资产均存在）
  - 观察：release 提交再次带入冗余路径 aivault/aivault/builtin/（与 aivault/builtin/ 对照待核）；本轮未删，待确认
- **最后更新**：2026-09-16 README 版本同步到 v0.2.3
  - 快进本地 main 到 origin/main（纳入 release v0.2.3 的两个提交）
  - README.md：最新版本与三平台下载链接由 v0.1.5 同步为 v0.2.3，链接以 release aivault-v0.2.3 资产名为准
  - AGENTS.md Conventions 新增「README 版本与 release 同步」一行，已留痕 agents-changelog.md
  - 删除工具目录 .codegraph/（159973 字节，含 codegraph.db）
  - 删除冗余副本 aivault/aivault/builtin/（7 个文件；与 aivault/builtin/ 内容逐字一致，原文件仍在 git 历史中）
  - AGENTS.md Conventions 新增「内置资产清单只有 aivault/builtin/ 一处有效」一行，已留痕 agents-changelog.md
  - 建立 AGENTS.md（半程合成，8 条既有约定保全）
  - 建立 docs/.ai/ 五份过程文档与 experience/、docs/handoff/ 空目录
  - 执行 codegraph init，结果为无源码可索引
- **下一步**：README 改动提交并推送 origin 与 gitee；确认是否清理 aivault/aivault/builtin/
- **本阶段禁止**：<本阶段明确不做的事，逗号分隔>
