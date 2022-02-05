# Instalação do i3wm Debian 11

![i3-debian](../imgs/i3-debian.png)

## !!! Pré-requisito !!!

* Instalar Debian 11 (minimal)

## Configurações

```sh
# login on root or:
su -
apt install sudo
usermod -aG sudo van
sudo apt install -y build-essential curl git
systemctl reboot
```

```sh
git clone https://github.com/souovan/dotfiles-linux.git && \
cd ~/dotfiles-linux/.config/ && \
./install-i3-rofi-polybar.sh
```

### !!! LOGAR PARA CRIAR O ARQUIVO DE CONFIG DO I3WM !!!

```sh
cd ~/dotfiles-linux && \
xdg-user-dirs-update && \
cp -Rv .config/* ~/.config/ && \
cp -Rv .local/* ~/.local/ && \
mkdir -p ~/bin && \
cp -Rv bin/* ~/bin/ && \
cp -Rv .config/i3/wallpaper/* ~/Downloads && \
systemctl reboot
```

### Change rofi theme

```sh
rofi-theme-selector
# select theme dracula hit 
Enter
# hit 
Alt+a
```

### Instalar aplicativos e utilitários

```sh
cd ~/dotfiles-linux/.config && \
su -c "xargs -a i3wm_apps_utils.txt apt-get install -y"
systemctl reboot
```

***

# Para usar no Fedora i3

![i3-fedora](../imgs/i3-fedora.png)

* Instalar Fedora i3 spin

### !!! LOGAR PARA CRIAR O ARQUIVO DE CONFIG DO I3WM !!!

```sh
# Clonar este repositório e executar:
cd ~/dotfiles-linux/.config && \
sudo dnf install -y $(< i3wm_packages_fedora.txt) && \
systemctl reboot
```

```sh
cd ~/dotfiles-linux && \
xdg-user-dirs-update && \
cp -Rv .config/* ~/.config/ && \
cp -Rv .local/* ~/.local/ && \
mkdir -p ~/bin && \
cp -Rv bin/* ~/bin/ && \
cp -Rv .config/i3/wallpaper/* ~/Downloads && \
systemctl reboot
```

### Change rofi theme

```sh
rofi-theme-selector
# select theme dracula hit 
Enter
# hit 
Alt+a
```