#!/bin/bash

set -o errexit -o nounset

dir=`dirname $0`

# 生成文档
cd $dir
npm run docs

cd docs

echo "GitHub Pages directory: `pwd`"

git config user.name "Travis CI"
git config user.email "ismar@slomic.no"

if [[ ! -d ./.git ]]; then
  git init
  git remote add origin git@github.com:ismarslomic/nodejs-microservice-poc.git
  git checkout -b gh-pages
else
  git checkout gh-pages -q
fi

git add . -A
git commit -m "Publish to GitHub Pages"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages
