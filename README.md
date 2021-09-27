# dotfiles
xfce workstation setup; a perpetual work in progress


```
git clone https://github.com/ttrreevvoorr/dotfiles.git
cd dotfiles
chmod +x xubuntu_post-install.sh
./xubuntu_post-install.sh
```

The xubuntu_post-install.sh will install some preferred base packages and remove some unwanted existing packages.

Most configuration files will live in `~/.config/{package}/`. The names of the configuration files in this repo have been changed for sake of easy understanding. For example, `i3.conf` in this repository is actually `~/.config/i3/config` on the machine.

---

## GUI Configurations

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
