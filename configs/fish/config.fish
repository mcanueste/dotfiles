# Disable greeting
set -gx fish_greeting ""

# Use vi keybindings
fish_vi_key_bindings

# Vim mode prompt
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold ec7171
      echo 'N '
    case insert
      set_color --bold 53bf97
      echo 'I '
    case replace_one
      set_color --bold fafafa
      echo 'R '
    case visual
      set_color --bold fdcc60
      echo 'V '
    case '*'
      set_color --bold red
      echo '? '
  end
  set_color normal
end

# Hydro prompt colors
set -x hydro_color_pwd cbccc6
set -x hydro_color_git ffd165
set -x hydro_color_error $fish_color_error
set -x hydro_color_prompt 53bf97
set -x hydro_color_duration $fish_color_normal

# Defaults
set -x EDITOR "nvim"
set -x TERMINAL "alacritty"
set -x BROWSER "firefox"
set -x GPG_TTY "( tty )"  # Path to current interactive shell for GPG
set -x LANG "en_US.UTF-8" # lang formatting
set -x LC_ALL "en_US.UTF-8" # byte-wise sorting and force lang on apps
set -x LESSHISTFILE "-"

# User
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_DESKTOP_DIR "$HOME/Desktop"
set -x XDG_DOWNLOAD_DIR "$HOME/Downloads"
set -x XDG_TEMPLATES_DIR "$HOME/Templates"
set -x XDG_PUBLICSHARE_DIR "$HOME/Public"
set -x XDG_DOCUMENTS_DIR "$HOME/Documents"
set -x XDG_MUSIC_DIR "$HOME/Music"
set -x XDG_PICTURES_DIR "$HOME/Pictures"
set -x XDG_VIDEOS_DIR "$HOME/Videos"

# App specific
set -x IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -x ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -x JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
set -x STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/config.toml"
set -x SSB_HOME "$XDG_DATA_HOME/zoom"
set -x QT_QPA_PLATFORMTHEME "gtk2"
set -x MOZ_USE_XINPUT2 "1"

# Paths
function __add_to_fish_path
    contains $argv $fish_user_paths; or set -Ua fish_user_paths $argv
end
__add_to_fish_path $HOME/.local/bin/
__add_to_fish_path $HOME/.config/nvm/ # TODO switch to asdf
__add_to_fish_path $XDG_DATA_HOME/cargo/bin/ # TODO switch to asdf
__add_to_fish_path $XDG_DATA_HOME/cargo/env # TODO switch to asdf

# FZF Configs
set fzf_fd_opts --hidden --exclude=.git

if test -f ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
else if test -f /opt/asdf-vm/asdf.fish
    source /opt/asdf-vm/asdf.fish
end


