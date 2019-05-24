@echo off
setlocal
pushd %~dp0

git config core.fsmonitor git-watchman/query-watchman
git status

git config core.autocrlf true
git config help.autocorrect 1
git config commit.template git-hooks-devs/gitmessage.txt
git config rebase.autoStash true
git config merge.conflictstyle diff3
git config push.recurseSubmodules "on-demand"
git config pull.rebase true
git config push.default current

git show-ref -s | git commit-graph write --stdin-commits
