# My bare metal and devbox config w/i3

My personal config for my box and devbox.

## Details 
I used to keep a script updated in a private repo but packages would change over time requiring something minor changed more freqently than I'd like. Rather than attempt to keep that script updated and have to deploy a new vm each time I wanted to test, I found it easier to keep a set of commands and scripts and change them incrementally as needed. This also helps me not to have to fumble around looking at several repos or sites when running into the same issue over and over each new install and just include those hotfixes here. There are still some ansible vault configs living in that private repo and I'll eventually move them over.

**Initial setup**

The inital setup can be done from here or the numbered scripts, after a desktop is available it's best to follow from the README.md locally or on the browser.

- Update the system and clone the git repo to ~/code

```
sudo xbps-install -uy xbps
sudo xbps-install -Suy
sudo xbps-install -Sy git
mkdir ~/code
cd ~/code
git clone https://github.com/mkonji008/void-dotfiles.git
cd void-dotfiles
```
Run the scripts in order, make them executable first with

``chmod +x *.sh``

1. ``sudo ./01-doas.sh``
   - Enter your username when prompted, this will install opendoas and configure it
   - If for some reason you make an error typing the username, do ``sudo rm -rf /etc/doas.conf`` and rerun 01-doas.sh
2. ``sudo ./02-basepkgs.sh``
   - This installs i3 and all my packages that are part of xbps. You can mmodify what packages get installed in **packages.txt** file
   - This removes **sudo** so run with **doas**
3. ``doas ./03-services.sh``
   - Installs services and lightdm should pop up.. just restart

### You should be able to jump into i3 now as normal and continue the setup below through the readme or github
 
- Install video drivers

   **AMD only right now**  (*I'll add others when I need them*)
```
doas xbps-install -Su linux-firmware-amd mesa-dri vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau
```

- Ryzen tools if needed 

```
doas xbps-install -S RyzenAdj ryzen-stabilizator
```

- Display
wip

- QEMU and Virt-Manager installation
wip


