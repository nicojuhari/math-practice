#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

git add dist -f
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git main

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:nicojuhari/math-practice.git main:gh-pages

rm -rf dist

cd -