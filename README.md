# My Home Manager & NixOS configurations

[![CI Home](https://github.com/hnaderi/configs/workflows/Home/badge.svg)](https://github.com/hnaderi/configs/actions)
[![CI System](https://github.com/hnaderi/configs/workflows/NixOS/badge.svg)](https://github.com/hnaderi/configs/actions)

## NixOS system

```
nixos-rebuild switch --flake github:hnaderi/configs#behemoth
```

## Home Manager

```
nix build github:hnaderi/configs#homeConfigurations.hnaderi.activationPackage
result/activate
```
