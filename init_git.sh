#!/bin/bash
echo "configuring git..."
ln -s $PWD/.gitconfig $HOME/.gitconfig

echo "Please enter a name (optional):"
read GIT_CONFIG_NAME

if [[ -n "$GIT_CONFIG_NAME" ]]; then
	git config --global user.name "$GIT_CONFIG_NAME"
else
	EXISTING=`git config user.name`
	echo "skipping update to user.name, keeping: $EXISTING"
fi

echo "Please enter email (optional):"
read GIT_CONFIG_EMAIL
if [[ -n "$GIT_CONFIG_EMAIL" ]]; then
	git config --global user.email $GIT_CONFIG_EMAIL
else
	EXISTING=`git config user.email`
	echo "skipping update to user.email, keeping: $EXISTING"
fi

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.mm "merge master"
git config --global alias.pom "pull origin master"

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr, %cd) %C(bold blue)<%an> %Creset' --abbrev-commit"
