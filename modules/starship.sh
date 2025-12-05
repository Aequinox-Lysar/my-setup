#!/bin/bash
echo -e "Starship wird installiert......\n"
curl -sS https://starship.rs/install.sh | sh
echo -e ".bashrc bekommt das Startkommando hinzugefügt....\n"
cat <<EOF >>~/.bashrc
# Starship starter
eval "$(starship init bash)"
EOF
echo -e "Deine Configdatei wird angelegt.....\n"
cat configs/starship.toml > ~/.config/starship.toml
echo -e "Starship wurde erfolgreich installiert.\n"
