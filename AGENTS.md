# AGENTS.md

<!-- mode: 半程合成 -->

## Permissions

IMPORTANT: 本仓是 AI Vault 与 ErgeMD 的更新分发仓，只存清单，不存安装包
YOU MUST 会话开始先读 docs/.ai/ 三件套与 docs/handoff/ 最新一份
YOU MUST 先复述现状与待确认项，再动手
YOU MUST 改码前先读 README.md 与 docs/.ai/decision-log.md
YOU MUST 每次会话更新 docs/.ai/project-progress.md
YOU MUST 改 AGENTS.md 前先读、改后追加 docs/.ai/agents-changelog.md
YOU MUST 改某领域代码前先读 docs/.ai/experience/<领域>/（存在时）
YOU MUST 每次只推进一个阶段，完成即停，等用户验证
禁止自行宣称已修复，修复结果须由用户验证
禁止整文件重写既有文件，只做最小精确补丁
禁止把安装包提交进仓库，安装包只走 Releases
禁止不记录就改动 AGENTS.md 的约定

## Toolchain

| 工具 | 精确版本 | 锁定位置 |
| ---- | -------- | -------- |
| Tauri updater 清单（AI Vault） | v0.2.5 | aivault/updates.json |
| Tauri updater 清单（AI Vault Gitee 镜像） | v0.2.5 | aivault/updates-gitee.json |
| Tauri updater 清单（ErgeMD） | v0.4.4 | ergemd/updates.json |
| 内置资产清单（per-type 日期版） | 20260827 | aivault/builtin/index.json |

## Commands

| 场景 | 命令原文 | 来源 |
| ---- | -------- | ---- |
| 安装 / 构建 / 测试 | 无（纯清单仓，无构建与测试命令） | 仓库根无依赖清单与锁定文件 |

## Conventions

| 观察到的现象 | 要求 Agent 的行为 |
| ------------ | ----------------- |
| 会话文档体系固定 | 进度写 docs/.ai/project-progress.md；决策写 docs/.ai/decision-log.md；两者只追加不删历史 |
| bug 追加 docs/.ai/debug-log.md | 格式 BUG-NNN；只追加不删历史 |
| 交接写 docs/handoff | 命名 handoff-YYYY-MM-DD-*.md |
| 交接文档同日多份 | 按文件名里的日期取最新（兼容 `YYYY-MM-DD` 与 `YYYYMMDD` 两种写法）；同日多份再取 frontmatter `updated` 最新者，仍不可判则列出问用户 |
| 改 docs/.ai 或 handoff 须同步 updated | 改完立刻把 frontmatter updated 改为当日 |
| 改 AGENTS.md 须留一行变更记录 | 在 docs/.ai/agents-changelog.md 追加「旧值 → 处置 → 去处」，无记录视为静默丢失 |
| 经验库按领域分目录 | 可复用经验落 docs/.ai/experience/<领域>/；正文可改写、历史靠 changelog.md，与 docs/.ai 其余三份的「只追加」不同 |
| Tauri updater 清单 | 只改 aivault/updates.json、aivault/updates-gitee.json、ergemd/updates.json 的 version / notes / pub_date / platforms 字段 |
| Gitee 镜像清单 | 与 GitHub 清单同版本发布，改一处必须同步另一处 |
| 内置资产清单为 per-type 日期版 | 改 aivault/builtin/<类型>.json 的 version 后，同步 aivault/builtin/index.json |
| 内置资产清单只有 aivault/builtin/ 一处有效 | 只改 aivault/builtin/<类型>.json 与 index.json；出现 aivault/aivault/ 嵌套副本时视为冗余，先核对内容一致再删 |
| 安装包不入仓 | 提交前确认无安装包；安装包只挂 Releases |
| README 版本与 release 同步 | 改 aivault/updates.json 或 aivault/updates-gitee.json 的 version 时，同步改 README.md 的「最新版本」与下载链接；tag 与安装包文件名以本次 release 的 tag 和资产名为准；CI 发版已内置 `scripts/sync-dist-readme.mjs` 自动改 README |
| 禁止 aivault/aivault 冗余路径 | 内置资产只允许落在 `aivault/builtin/`；出现 `aivault/aivault/` 视为发版脚本误路径，提交前删除；本地/发版后跑 `scripts/verify-dist-layout.sh` |
| 提交信息带前缀 | release: / ergemd: / builtin: / docs: / chore: / init: |

## References

见 README.md
见 docs/.ai/agents-changelog.md
见 docs/.ai/decision-log.md
见 docs/.ai/debug-log.md
见 docs/.ai/experience/
见 docs/.ai/project-progress.md
见 docs/handoff/
见 scripts/verify-dist-layout.sh

## 发版版本号同步工作流（AI Vault）

发版 tag `v*` 由 AIVault CI 自动完成清单与 README；人工只做核对与 Toolchain 登记。

| 步骤 | 谁做 | 产物 |
| ---- | ---- | ---- |
| 1. 打 tag 推送 | 人工（AIVault 仓） | tag `vX.Y.Z` |
| 2. 写 updates.json / updates-gitee.json | CI | `aivault/updates*.json` version + 签名 + 下载 URL |
| 3. 同步 README 最新版本与三平台链接 | CI（`sync-dist-readme.mjs`） | `README.md` |
| 4. 清理/阻断 `aivault/aivault` | CI（release.yml 内 rm + 断言） | 仅保留 `aivault/builtin/` |
| 5. 推 GitHub + Gitee main | CI | 双源清单一致 |
| 6. 布局校验 | 人工或 CI 后置 | `bash scripts/verify-dist-layout.sh` |
| 7. AGENTS.md Toolchain 版本登记 | 人工 | Toolchain 表改为 vX.Y.Z + agents-changelog 留痕 |

手动补发/改清单时：先改 `updates*.json`，再跑 `node ../AIVault/scripts/sync-dist-readme.mjs README.md <ver>`（或等价替换），最后 `verify-dist-layout.sh`。

## Self-Maintenance

1. 改变规则的 PR 须同步改本文件，否则视为规则漂移
2. 规则写入错误发生处最近作用域，monorepo 进对应子包
3. 命令更名、重构后，提交前核对本文件并更新过期示例
4. 随发布或固定周期清除失效条目
5. 本文件修改走 PR/Review，与代码同等纪律
