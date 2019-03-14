# Terminal Commands Cheatsheet
___

**pacman -Sh**  - show help
**pacman -S** - install package
**pacman -Ss emacs** - search for packages (emacs is an example here)
**pacman -Sg xorg** - show packages of group xorg

**pacman -R** - remove package 
**pacman -Syyuu** upgrade all packages on system
**pacman -Ql** list files installed by screen package
**pacman -Si vim** show extensive info about package
**pacman -Sc** clean package cache

**pacman -Ss keyword** - find available packages
**pacman -Qs pkgname** - find available local packages

**pacman -Rsc <pkg>** - uninstall a package
**pacman -Syu <pkg>** install and update package list

### Query
**pacman -Qe** - list explicitly-installed packages
**pacman -Ql <pkg>** - what files does this package have?
**pacman -Qii <pkg>** - list info on package

### Orphans/other
**pacman -Qdt** - list unneeded packages
**pacman -Rns $(pacman -Qdrq) - uninstall unneeded packages.
