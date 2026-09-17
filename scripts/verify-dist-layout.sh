#!/usr/bin/env bash
# 校验 updates-dist 布局：禁止 aivault/aivault 冗余树；README 版本须与 updates.json 一致。
# 用法：在 updates-dist 仓库根执行 bash scripts/verify-dist-layout.sh
set -euo pipefail
cd "$(dirname "$0")/.."

fail=0

json_version() {
  # 从清单顶层 "version": "x.y.z" 提取（首行附近；不依赖 node）
  sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$1" | head -1
}

if [ -e aivault/aivault ]; then
  echo "FAIL: 存在冗余路径 aivault/aivault/（应删除；发版 CI 勿再生成）"
  find aivault/aivault -type f | sed 's/^/  /'
  fail=1
else
  echo "OK: 无 aivault/aivault 冗余路径"
fi

if [ ! -f aivault/builtin/index.json ]; then
  echo "FAIL: 缺少 aivault/builtin/index.json"
  fail=1
else
  echo "OK: aivault/builtin/index.json 存在"
fi

MANIFEST_VER=$(json_version aivault/updates.json)
README_VER=$(grep -oE '\*\*最新版本\*\*：v[0-9.]+' README.md | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
if [ -z "$MANIFEST_VER" ] || [ -z "$README_VER" ]; then
  echo "FAIL: 无法解析版本（manifest='$MANIFEST_VER' readme='$README_VER'）"
  fail=1
elif [ "$MANIFEST_VER" != "$README_VER" ]; then
  echo "FAIL: README 版本 ($README_VER) ≠ updates.json 版本 ($MANIFEST_VER)"
  fail=1
else
  echo "OK: README 与 updates.json 均为 v$MANIFEST_VER"
fi

GITEE_VER=$(json_version aivault/updates-gitee.json)
if [ -z "$GITEE_VER" ]; then
  echo "FAIL: 无法解析 updates-gitee.json 版本"
  fail=1
elif [ "$MANIFEST_VER" != "$GITEE_VER" ]; then
  echo "FAIL: updates-gitee.json 版本 ($GITEE_VER) ≠ updates.json ($MANIFEST_VER)"
  fail=1
else
  echo "OK: Gitee 清单同版本 v$MANIFEST_VER"
fi

if [ "$fail" -eq 0 ]; then
  echo "布局校验通过"
fi
exit $fail
