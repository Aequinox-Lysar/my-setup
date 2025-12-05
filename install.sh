#!/bin/bash
# Function to check if a package is installed
is_installed() {
	dpkg -l "$1" | grep -qw '^ii' &> /dev/null && return 0 || return 1
}

# Function to install packages if not already installed
install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
    	to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    for pkg in "${to_install[@]}"; do
    	printf "\e[93mInstalliere %s...\e[0m\n" "$pkg"
    	sudo apt-get install -yy "$pkg" 2>/dev/null || printf "\e[32m%s not installed, skipping...\e[0m\n" "$pkg"
    done
  fi
}

# Clone configs and scripts repositories to ~/Downloads
clone_repos() {
	local dl_dir repo repos repo_url
	repo_url="https://github.com/RickRomig"
	repos=(configs scripts)
	dl_dir="$HOME/Downloads"
	printf "\e[93mCloning configs and scripts...\e[0m\n"
	for repo in "${repos[@]}"; do
		if [[ -d "$dl_dir/$repo" ]]; then
			echo "$repo repository already exists."
		else
			git clone "$repo_url/$repo.git" "$dl_dir/$repo"
		fi
	done
}
