# Flake install

BEWARE: Applying this flake during install will wipe the disk completely

In the live session:
```
git clone https://github.com/rodrigofuente/infra.git
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --yes-wipe-all-disks --mode destroy,format,mount hosts/disk-config<-encrypted>.nix
sudo nixos-install --flake .#<MACHINE_NAME>
reboot
```

Clone the repo in ~/sandbox, then make /etc/nixos/flake.nix a symlink to ~/sandbox/infra/flake.nix

To update the packages channel:
```
task flake-update
```
