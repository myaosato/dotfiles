#!/bin/sh
# ログインシェルで呼ばれる方

## env
[ -f "$HOME/.dotfiles/files/env.sh" ] && . "$HOME/.dotfiles/files/env.sh"

## bash
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

## bin
[ -d "$HOME/bin" ] && PATH="$PATH:$HOME/bin"
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"

## roswell - https://github.com/roswell/roswell
[ -d "$HOME/.roswell/bin" ] && PATH="$PATH:$HOME/.roswell/bin"
