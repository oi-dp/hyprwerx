# This file is for adding custom paths to the PATH variable and other related environment variables.


# PATH
fish_add_path $HOME/.spicetify $HOME/.local/bin


# ENVIRONMENT

# bat, for syntax highlighting in the terminal
set -gx BAT_CONFIG_DIR $HOME/.config/bat
set -gx BAT_CONFIG_PATH $HOME/.config/bat/config

# custom functions
set -p fish_function_path $HOME/.config/fish/functions/hypr_utils
set -p fish_function_path $HOME/.config/fish/functions/dailies

# xdg-desktop-portal-termfilechooser
set -gx TERMCMD 'footclient'

# pure, for async git status in prompt
set -g async_prompt_functions _pure_prompt_git

# Set the default editor to neovim
set -gx EDITOR nvim

# Nvidia environment for Hyprland
set -gx LIBVA_DRIVER_NAME nvidia
set -gx XDG_SESSION_TYPE wayland
set -gx GBM_BACKEND nvidia-drm
set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
set -gx NVD_BACKEND direct
set -gx MOZ_DISABLE_RDD_SANDBOX 1
