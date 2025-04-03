#!/usr/bin/env bash
# This script is used to prepare the environment for the blog
# It will install the required packages and set up the directory structure
# It will also clone the required repositories and set up the symlinks
# It will also set up the git remote for the blog repository
# It will also set up the git remote for the theme repository
# It will also set up the git remote for the static files
# It will also set up the git remote for the custom additions

rm -rf abhi1010.github.io
rm -rf themes/hugo-theme-m10c
mkdir -p themes
git config --get remote.origin.url

git clone git@github.com:abhi1010/abhi1010.github.io.git
cd themes
git clone git@github.com:abhi1010/hugo-theme-m10c.git


cd ../
if [[ -f static ]]; then echo 'link exists already'; else ln -s themes/hugo-theme-m10c/static; fi


