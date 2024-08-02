###
 # @Author: Nintendo
 # @Date: 2024-08-01 17:57:37
 # @LastEditors: Nintendo
 # @LastEditTime: 2024-08-01 21:17:29
 # @Description: 
### 
#!/usr/bin/env sh
# 抛出错误
# 如果脚本中出现任何命令执行失败（即命令的退出状态非零），则立即退出脚本的执行。
set -e
# 获取远程仓库的push地址，并将结果赋值给变量
push_addr = `git remote get-url --push origin`
# 获取当前提交的详细信息，包括提交的哈希值、提交距离最近标签的次数等，并将结果赋值给变量commit_info
commit_info = `git describe --all --always --long`
# 设置变量dist_path为docs/.vuepress/dist，用于指定构建文件的输出路径
dist_path = docs/.vuepress/dist
# 设置变量push_branch为gh-pages，用于指定推送构建文件到远程仓库的分支
push_branch = gh-pages

# 生成静态涨点
npm run docs:build 

cd $dist_path
# 初始化一个新的Git仓库
git init
# 将所有文件添加到Git仓库
git add -A
# 提交所有更改，提交信息
git commit -m "deploy:$commit_info"
# 强制推送提交到指定的远程分支
git push -f $push_addr HEAD:$push_branch

cd -
rm -rf $dist_path