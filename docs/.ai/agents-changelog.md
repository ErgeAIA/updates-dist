---
title: AGENTS.md Changelog
type: agents-changelog
project: updates-dist
updated: 2026-09-16
description: >
  AGENTS.md 的变更记录，AGENTS.md 每改动一次就追加一行，不随日常开发更新。
  只追加，不删除或改写历史。AI 在本文件新增或修改任何条目后，必须同步更新 frontmatter 的 updated 字段为当日日期（YYYY-MM-DD）。
---

# AGENTS.md Changelog

> **AGENTS.md 每改动一次，必须在此追加一行**；无对应记录即视为静默丢失。
> 模式：半程合成
> 来源文件：无既有 AGENTS.md / CLAUDE.md；约定来源为 README.md、清单文件原文与 git 提交记录
> 格式：一行一条 `<旧值> → keep|update|drop|merge → <新值/去处/原因>`
> 全新初始化无旧约定可处置时，写一行 `<无旧约定> → 全新初始化 → 直建当前 AGENTS.md`

---

## 2026-09-16 初始化 · 既有约定四态处置（8 条）

- 清单落点 aivault/updates.json（GitHub）+ aivault/updates-gitee.json（Gitee）→ keep → 写入 AGENTS.md Toolchain 与 Conventions
- 安装包不入仓、只走 Releases → keep → 写入 AGENTS.md Permissions 与 Conventions（依据提交 6aee157、a833244、2bd2a46）
- 内置资产 per-type 日期版 + aivault/builtin/index.json 版本登记 → keep → 写入 AGENTS.md Toolchain 与 Conventions（依据提交 96a12b9、6dbdd66）
- Gitee 镜像与 GitHub 清单同版本发布 → keep → 写入 AGENTS.md Conventions（依据提交 a476634、cc5f5ef、220361d、143cdb8、3aead7c、51541e7、9320a0b）
- 提交信息前缀 release: / ergemd: / builtin: / docs: / chore: / init: → keep → 写入 AGENTS.md Conventions
- README 承载产品介绍、下载链接与封面图（images/aivault-cover.png）→ keep → 保留原地，AGENTS.md 仅加 References 指针
- 双远端 origin（GitHub）+ gitee → keep → 未写入 AGENTS.md（可推断事实，依生成规范 §6 写入闸删除）
- 日期版版本号写法（如 20260827）→ keep → 写入 AGENTS.md Toolchain

## 2026-09-16 README 版本同步约定

- 新增约定「README 版本与 release 同步」→ add → AGENTS.md Conventions（来源：用户 2026-09-16 要求；本轮 README 由 v0.1.5 滞后修正为 v0.2.3）

## 2026-09-16 内置资产清单唯一路径约定

- 新增约定「内置资产清单只有 aivault/builtin/ 一处有效」→ add → AGENTS.md Conventions（来源：用户 2026-09-16 要求保留一份；冗余副本 aivault/aivault/builtin/ 已删除）

## 2026-09-16 Toolchain 版本登记对齐 v0.2.4

- Toolchain「Tauri updater 清单（AI Vault）v0.2.2」→ update → v0.2.4（与 aivault/updates.json 实际内容对齐）
- Toolchain「Tauri updater 清单（AI Vault Gitee 镜像）v0.2.2」→ update → v0.2.4（与 aivault/updates-gitee.json 实际内容对齐）

## 2026-09-16 禁止冗余路径 + 发版版本号工作流

- 新增约定「禁止 aivault/aivault 冗余路径」→ add → AGENTS.md Conventions + scripts/verify-dist-layout.sh（根因：AIVault release.yml 曾写 `$DIST/aivault/builtin`，v0.2.0/v0.2.4 两次复发）
- 新增章节「发版版本号同步工作流（AI Vault）」→ add → AGENTS.md（CI 写清单与 README，人工核对 + Toolchain 登记）
- README 同步能力 → update → 发版 CI 调用 AIVault `scripts/sync-dist-readme.mjs` 自动改 README
