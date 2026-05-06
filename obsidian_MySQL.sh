#!/bin/bash
obsidian_path="D:\Study Resource\MySQL学习笔记"
echo "切换到笔记目录"
cd "$obsidian_path"

echo "添加到暂存区"
git add .

echo "提交更改"
git commit -m "自动备份 $(date '+%Y-%m-%d %H:%M:%S')"

echo "推送代码"
git push

echo "备份完成咯"