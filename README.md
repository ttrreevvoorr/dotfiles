<p align="center">
    <img width="800" src="https://i.imgur.com/VZaq66x.jpg" alt="debian neofetch">
</p>

> [!NOTE]  
> TODO: Provide Arch installation steps also/instead. No longer use Debian on personal machines.

# Debian 11, XFCE, i3, Polybar

I wrote this script to streamline the process of reinstalling my OS. There are many dotfiles here, and you may feel free to leverage those. Unless you plan on installing a new OS, you do not need to read the following.

- When prompted during install, select Debiand desktop environment, XFCE, and standard system utilities.
- On initial boot, likely an error regarding lightdm, so enter tty (ctrl+alt+f2)
- Install nvidia drivers if applicable, add `contrib non-free` to `deb` and `deb-src` entries in `/etc/apt/sources.list`
- `sudo apt update && sudo apt upgrade`
- Get driver dependencies `sudo apt -y install linux-headers-$(uname -r) build-essential libglvnd-dev pkg-config`
- `sudo apt install -y nvidia-detect && nvidia-detect`
- Will likely tell you default `nvidia-driver` is fine. I can't tell if this is true or not.
- If you disagree, install your preferred driver via `sudo apt install nvidia-tesla-4XX-driver` or similar
- blacklist noveau by doing something like `echo 'blacklist nouveau \n options nouveau modeset=0' > /etc/modprobe.d/blacklist-nouveau.conf` (double check this file to make sure that piped right)
- `systemctl reboot`
- `sudo update-initramfs -u` and see if missing firmware, so download what is missing.
- Example, if some of `rtl_nic` are missing then wget them from: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/ into this director: `/lib/firmware/rtl_nic/`
- After installing the missing firmware, run `sudo update-initramfs -u` again

## Installing packages

```
cd ~/Downloads && wget https://raw.githubusercontent.com/ttrreevvoorr/dotfiles/main/debian_post-install.sh
chmod +x debian_post-install.sh && ./debian_post-install.sh
```
The above installation script will try to utilize a theme and icon set that may not be available on Debian. If they are not availble in this version of XFCE or whatever, go ahead and download themyourself, install the files, and run the xconf-query in debian_post-install.sh again.

```
Greybird-dark
https://debian.pkgs.org/11/debian-main-arm64/greybird-gtk-theme_3.22.14-1_all.deb.html
```
```
Adwaita
https://debian.pkgs.org/10/debian-main-arm64/adwaita-icon-theme_3.30.1-1_all.deb.html
```


Starting moving files into appropriate locations:
```
git clone https://github.com/ttrreevvoorr/dotfiles.git
cd dotfiles
```

---

## XFCE GUI Configurations

### Session and Startup

#### Current Session
For xfwm4, click 'Immediately' and change it to the  'Never' option.
For xfdesktop, click 'Immediately' and change it to the 'Never' option


#### Keyboard Shortcuts
| Command                     | Shortcut       |
| --------------------------- | -------------- |
| xfce4-screenshooter -f      | Print          |
| xfce4-screenshooter -r      | Shift+Print    |
| xfce4-screenshooter -w      | Alt+Print      |

#### Application Autostart
Add i3 to the list of startup applications.
```
Name: i3
Description: Tiling Window Manager
Command: i3
```

Remove the existing desktop manager
```
sudo apt purge xfwm4
sudo apt purge xfdesktop
```

Restart the machine, or `sudo reboot`
