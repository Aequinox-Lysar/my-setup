#!/usr/bin/env bash
###############################################################################
# Script Name  : nerdfonts.sh
# Description  : Installs Nerd Fonts to new i3WM installation.
# Dependencies : wget
# Arguments    : None
# Author       : Copyright © 2025, Daniel Kurth
# License      : GNU General Public License, version 2.0
# License URL  : https://github.com/RickRomig/i3wm-debian/blob/main/LICENSE

# shellcheck disable=SC2317 # Don't warn about unreachable commands in this function
# ShellCheck may incorrectly believe that code is unreachable if it's invoked by variable name or in a trap.
cleanup() {
	[[ -d "$tmp_dir" ]] && rm -rf "$tmp_dir"
}

install_NerdFonts() {
  local font fonts
  local -r font_repo="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0"
  local -r font_dir="$1"
  [[ -d "$font_dir" ]] || sudo mkdir -p "$font_dir"
  fonts=( "FiraCode" "Go-Mono" "Hack" "Inconsolata" "Iosevka" "JetBrainsMono" "MartianMono" "RobotoMono" "SourceCodePro" )
  for font in "${fonts[@]}"; do
    printf "\e[03mInstalling %s ...\e[0m\n" "$font"
    wget -q -P "$tmp_dir" "$font_repo/$font.tar.xz"
    mkdir -p "$font_dir/$font/"
    tar -xvf "$tmp_dir/${font}.tar.xz" -C "$font_dir/$font/"
  done
  printf "Nerd fonts installed.\n"
}

install_SymbolNerdFonts() {
  local -r font_dir="$1"
  local -r symbols_archive="NerdFontsSymbolsOnly.tar.xz"
  cp -v ~/Downloads/configs/local/"$symbols_archive" "$font_dir/"
  tar xvf "$font_dir/$symbols_archive" -C "$font_dir/${symbols_archive%%.*}"
  rm -v "$font_dir/$symbols_archive"
}

main() {
  local script version font_dir
  font_dir=/usr/share/fonts/truetype
	script="${0##*/}"
  version="1.5.25311"
  tmp_dir=$(mktemp -d) || { printf "\e[91mERROR:\e[0m: Failed to create temporary directory." >&2; exit 1; }
  trap cleanup EXIT
  install_NerdFonts "$font_dir"
  install_SymbolNerdFonts "$font_dir"
  fc-cache
	echo "-----------------"
	echo "$script $version"
  printf "Run \e[93mconfigs.sh\e[0m to setup configuration files and complete the installation.\n"
  exit
}

main "$@"
