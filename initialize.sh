#! /bin/sh


cd `dirname $0`

for f in .??*
do
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  if [ ! -L ${HOME}/${f} ]; then
    echo -e "\e[31mPlease run deploy.sh!\e[m"
    exit 1
  fi
done


# oh-my-zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc


# dein
rm -rf ~/.vim/dein
mkdir ~/.vim/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm ./installer.sh


# pyenv
PYENV_PATH=`cat << 'EOS'

# Load pyenv automatically by adding
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOS
`
rm -rf ~/.pyenv
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
echo "$PYENV_PATH" >> ~/.zshrc


echo -e "\e[32mInitialize dotfiles complete!\e[m"
