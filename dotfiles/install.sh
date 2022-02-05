#!/usr/bin/env bash
# User colors, mas só se está conectado a um terminal e se ele aceitar cores
if command -v tput >/dev/null 2>&1; then 
  ncolors=$(tput colors) 
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then 
# RED="$(tput setaf 5)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  NORMAL="$(tput sgr0)" 
else
# RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
fi

# Verificar a distro Linux
# Red Hat (Fedora, RHEL)
# cat /etc/redhat-release
# Debian ou Ubuntu ou ElementaryOS
# cat /etc/issue

if [[ $(cat /etc/issue) == *"Debian"* ]]; then
  if ! type vim &> /dev/null || ! type dconf &> /dev/null || ! type nvim &> /dev/null; then
    su -c "xargs -a apt_packages.txt apt-get install -y"
  else
    printf "%s ~ vim e dconf-cli e nvim já estão instalados%s\n" "$YELLOW" "$NORMAL"
  fi

elif  [[ $(cat /etc/issue) == *"Ubuntu"* ]]; then 
  if ! type vim &> /dev/null || ! type dconf &> /dev/null || ! type nvim &> /dev/null; then
    sudo apt-get install -y $(< apt_packages.txt)
  else
    printf "%s ~ vim e dconf-cli e nvim já estão instalados%s\n" "$YELLOW" "$NORMAL"
  fi

elif [[ $(cat /etc/issue) == *"elementary"* ]]; then
  if ! type vim &> /dev/null || ! type nvim &> /dev/null; then
    sudo apt-get install -y $(< apt_packages.txt)
  else
    printf "%s ~ vim e dconf-cli e nvim já estão instalados%s\n" "$YELLOW" "$NORMAL"
  fi

  if [[ $(cat /etc/issue) == *"elementary OS"* ]] || [[ $(cat /etc/issue) == *"elementary OS Next"* ]]; then
  # Handmade gnome terminal Dracula Theme for old and Odin ElementaryOS distros
    gsettings set io.elementary.terminal.settings palette "#262626:#E356A7:#42E66C:#E4F34A:#9B6BDF:#E64747:#75D7EC:#EFA554:#7A7A7A:#FF79C6:#50FA7B:#F1FA8C:#BD93F9:#FF5555:#8BE9FD:#FFB86C"
    gsettings set io.elementary.terminal.settings foreground "#F8F8F2"
    gsettings set io.elementary.terminal.settings background "rgba(40, 42, 54, .95)"
    gsettings set io.elementary.terminal.settings cursor-color "#6E46A4"
    gsettings set io.elementary.terminal.settings follow-last-tab "true"

  else
  # Handmade Dracula Theme for ElementaryOS Hera
    gsettings set org.pantheon.terminal.settings palette "#262626:#E356A7:#42E66C:#E4F34A:#9B6BDF:#E64747:#75D7EC:#EFA554:#7A7A7A:#FF79C6:#5OFA7B:#F1FA8C:#BD93F9:#FF5555:#8BE9FD:#FFB86C"
    gsettings set org.pantheon.terminal.settings foreground "#F8F8F2"
    gsettings set org.pantheon.terminal.settings background "rgba(40, 42, 54, .95)"
    gsettings set org.pantheon.terminal.settings cursor-color "#6E46A4"
    gsettings set org.pantheon.terminal.settings follow-last-tab "true"
  fi

elif [[ $(cat /etc/redhat-release) == *"Fedora"* ]]; then
  if ! type vim &> /dev/null || ! type dconf &> /dev/null || ! type nvim &> /dev/null; then
    sudo dnf install -y $(< dnf_packages.txt)
  else
    printf "%s ~ vim e dconf-cli e nvim já estão instalados%s\n" "$YELLOW" "$NORMAL"
  fi

elif [[ $(cat /etc/redhat-release) == *"Red Hat Enterprise Linux"* ]]; then
  if ! type vim &> /dev/null || ! type dconf &> /dev/null || ! type nvim &> /dev/null; then
    su -c "xargs -a dnf_rhel_packages.txt dnf install -y && \
           curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
           chmod +x /usr/local/bin/nvim"
  else
    printf "%s ~ vim e dconf-cli e nvim já estão instalados%s\n" "$YELLOW" "$NORMAL"
  fi

fi

if [ -e $HOME/gnome-terminal ]; then
  printf "%s ~ Dracula Theme para Gnome Terminal já está instalado%s\n" "$YELLOW" "$NORMAL"
else
  cd $HOME
  git clone https://github.com/dracula/gnome-terminal &> /dev/null
  cd gnome-terminal
  ./install.sh
  cd $HOME/dotfiles-linux
  printf "%s + Dracula Theme para Gnome Terminal Instalado com sucesso!%s\n" "$BLUE" "$NORMAL"
fi

if [ -e $HOME/.vim/pack/themes/opt/dracula ]; then
  printf "%s ~ Dracula Theme para VIM já está instalado%s\n" "$YELLOW" "$NORMAL"
else
  mkdir -p ~/.vim/pack/themes/opt
  cd ~/.vim/pack/themes/opt
  git clone https://github.com/dracula/vim.git dracula &> /dev/null
  cd $HOME/dotfiles-linux
  printf "%s + Dracula Theme para VIM instalado com sucesso!%s\n" "$BLUE" "$NORMAL"
fi

# Instala Fonts para Powerline
if [ -e $HOME/fonts ]; then
  printf "%s ~ O Pacote de Fontes Nerd já está instalado%s\n" "$YELLOW" "$NORMAL"
else
  cd $HOME
  git clone https://github.com/powerline/fonts.git fonts &> /dev/null
  cd fonts
  ./install.sh
  cd $HOME/dotfiles-linux
  printf "%s + Pacote de Fontes Nerd instalado com sucesso!%s\n" "$BLUE" "$NORMAL"
fi

if [[ $(cat /etc/issue) == *"elementary"* ]]; then
# Handmade Dracula Theme for Olds ElementaryOS Console
  gsettings set io.elementary.terminal.settings font "Fira Mono for Powerline Regular"
elif [[ $(cat /etc/issue) == *"elementary OS Hera"* ]]; then
# Handmade Dracula Theme for ElementaryOS Hera
  gsettings set org.pantheon.terminal.settings font "Fira Mono for Powerline Regular"
fi

# Instala Font Droid Sans Mono Nerd to Linux fonts directory
# used to show icons on vim/nvim
font_dir="$HOME/.local/share/fonts"
cp "Droid Sans Mono Nerd Font Complete.otf" "$font_dir/"

# Configura a fonte do terminal para Droid Sans Mono for Powerline Regular para Ubuntu e Debian
if [[ $(cat /etc/issue) == *"Ubuntu"* ]] || [[ $(cat /etc/issue) == *"Debian"* ]]; then
  GNOME_TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')

  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'Droid Sans Mono for Powerline Regular 12'
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
fi

# Copia os arquivos de configuração do VIM Vundle
if [ -e $HOME/.vim/bundle/Vundle.vim ]; then
  printf "%s ~ O VIM Vundle já está instalado%s\n" "$YELLOW" "$NORMAL"
else
  cd $HOME
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null
  cd -
  printf "%s + VIM Vundle instalado com sucesso!%s\n" "$BLUE" "$NORMAL"
fi

if [ -e $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc.old
  cp ./.bashrc $HOME/
else
  cp ./.bashrc $HOME/
  printf "%s + .bashrc substituido, original renomeado para .bashrc.old%s\n" "$BLUE" "$NORMAL"
fi

if [ -e $HOME/.vimrc ]; then
  mv $HOME/.vimrc $HOME/.vimrc.old
  cp ./.vimrc $HOME/
else
  cp ./.vimrc $HOME/
  printf "%s + .vimrc substituido, original renomeado para .vimrc.old%s\n" "$BLUE" "$NORMAL"
fi

if [ -e $HOME/.config/nvim/init.vim ]; then
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.old
  cp ./.config/nvim/init.vim $HOME/.config/nvim/
else
  mkdir -p $HOME/.config/nvim/
  cp ./.config/nvim/init.vim $HOME/.config/nvim/
  printf "%s + init.vim substituído, original renomeado para init.vim.old%s\n" "$BLUE" "$NORMAL"
fi

if [ -e $HOME/bin ]; then
  mv $HOME/bin $HOME/bin.old
  cp -r ./bin $HOME/
else
  cp -r ./bin $HOME/
  printf "%s + /bin substituido, original renomeado para /bin.old%s\n" "$BLUE" "$NORMAL"
fi

printf "%s ################################################%s\n" "$GREEN" "$NORMAL"
printf "%s # Instalação dos Dotfiles-linux finalizada !!! #%s\n" "$GREEN" "$NORMAL"
printf "%s ################################################%s\n" "$GREEN" "$NORMAL"
exec bash; source $HOME/.bashrc
