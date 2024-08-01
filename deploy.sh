###
 # @Author: Nintendo
 # @Date: 2024-08-01 17:57:37
 # @LastEditors: Nintendo
 # @LastEditTime: 2024-08-01 18:01:18
 # @Description: 
### 
#!/usr/bin/env sh
# 抛出错误
set -e

push_addr = `git remote get-url --push origin`
commit_info = `git describe --all --always --long`
dist_path = docs/.vuepress/dist
push_branch = gh-pages

# 生成静态涨点
npm run docs:build 

cd $dist_path

git init
git add -A
git commit -m "deploy:$commit_info"
git push -f $push_addr HEAD:$push_branch

cd -
rm -rf $dist_path