
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
echo -e "DBUG: 1" && pwd && ls

git config --get remote.origin.url

echo -e "DBUG: 2" && pwd && ls

git clone git@github.com:abhi1010/abhi1010.github.io.git
echo -e "DBUG: 3" && pwd && ls

cd themes
echo -e "DBUG: 4" && pwd && ls
git clone git@github.com:abhi1010/hugo-theme-m10c.git
echo -e "DBUG: 5" && pwd && ls

cd ../
echo -e "DBUG: 6" && pwd && ls
if [[ -f static ]]; then echo 'link exists already'; else ln -s themes/hugo-theme-m10c/static; fi

echo -e "DBUG: 7" && pwd && ls

