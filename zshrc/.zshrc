# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="duellj-git"

plugins=(
    git
    archlinux
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias n='nvim'
alias rsrc='source ~/.zshrc'
alias y="yazi"
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

function yy() {
    tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    yazi "$@" --cwd-file="$tmp"
    if [ -f "$tmp" ]; then
        cwd="$(cat "$tmp")"
        [ -n "$cwd" ] && cd "$cwd"
    fi
    rm -f "$tmp"
}

function so() {
    local MAC="18:9C:2C:3E:34:72"
    
    bluetoothctl power on
    sleep 1
    
    # Try connecting first
    bluetoothctl connect "$MAC"
    sleep 3
    
    # Check if actually connected
    if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
        echo "✓ Connected to earbuds"
    else
        echo "Connection failed, trying forget & reconnect..."
        bluetoothctl remove "$MAC"
        sleep 2
        bluetoothctl scan on &
        SCAN_PID=$!
        sleep 8
        kill $SCAN_PID 2>/dev/null
        bluetoothctl scan off
        bluetoothctl trust "$MAC"
        bluetoothctl connect "$MAC"
        sleep 3
        if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
            echo "✓ Connected after re-pairing"
        else
            echo "✗ Failed. Make sure earbuds are in pairing mode."
        fi
    fi
}
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kali-style prompt with git branch
autoload -Uz vcs_info
precmd() { vcs_info; printf '\033[2 q' }
zstyle ':vcs_info:git:*' formats ' (%F{yellow}%b%F{cyan})'
setopt PROMPT_SUBST
PROMPT='%F{cyan}┌──(%F{green}%n%F{cyan}㉿%F{green}%m%F{cyan})-[%F{white}%~%F{cyan}]${vcs_info_msg_0_}
%F{cyan}└─%F{green}$%f '
  

printf '\033[2 q'
export PATH="$HOME/.cargo/bin:$PATH"




# ccache for C/C++
export CC="ccache gcc"
export CXX="ccache g++"
export PATH="/usr/lib/ccache/bin:$PATH"

# sccache for Rust
export RUSTC_WRAPPER=sccache

# MAKEFLAGS
export MAKEFLAGS="-j8"

# bun completions
[ -s "/home/amine/.bun/_bun" ] && source "/home/amine/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:/home/amine/.npm-global/bin"






# ── Gruvbox Dark palette ──────────────────────────────────────────
GRV_RED="\e[38;2;204;36;29m"        # hard red   #cc241d
GRV_GREEN="\e[38;2;152;151;26m"     # olive green #98971a
GRV_YELLOW="\e[38;2;215;153;33m"    # yellow      #d79921
GRV_BLUE="\e[38;2;69;133;136m"      # aqua/teal   #458588
GRV_PURPLE="\e[38;2;177;98;134m"    # purple      #b16286
GRV_ORANGE="\e[38;2;214;93;14m"     # orange      #d65d0e
GRV_FG="\e[38;2;235;219;178m"       # fg1         #ebdbb2
RST="\e[0m"

# ── command_not_found_handler (replaces the broken alias approach) ─
command_not_found_handler() {
  echo -e "${GRV_RED}✗ not found: $1${RST}" >&2
  return 127
}

# ── color alias: prints a palette swatch ─────────────────────────
alias color='
  echo -e "${GRV_GREEN}● valid command${RST}";
  echo -e "${GRV_RED}● invalid command${RST}";
  echo -e "${GRV_YELLOW}● alias${RST}";
  echo -e "${GRV_BLUE}● path / directory${RST}";
  echo -e "${GRV_ORANGE}● builtin${RST}";
  echo -e "${GRV_PURPLE}● function${RST}"
'

# ── ZSH_HIGHLIGHT_STYLES (Gruvbox Dark) ──────────────────────────
ZSH_HIGHLIGHT_STYLES[command]='fg=#98971a,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#d65d0e,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#b16286,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#d79921,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#458588,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#cc241d,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#d79921'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#d65d0e'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#a89984'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#665c54,italic'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#d79921'
export LS_COLORS="di=38;2;69;133;136:ln=38;2;177;98;134:so=38;2;215;153;33:pi=38;2;214;93;14:ex=38;2;152;151;26:bd=38;2;215;153;33;1:cd=38;2;214;93;14;1:su=38;2;204;36;29;1:sg=38;2;214;93;14;1:tw=38;2;69;133;136;1:ow=38;2;69;133;136:*.tar=38;2;204;36;29:*.zip=38;2;204;36;29:*.gz=38;2;204;36;29:*.7z=38;2;204;36;29:*.mp3=38;2;215;153;33:*.mp4=38;2;215;153;33:*.mkv=38;2;215;153;33:*.png=38;2;177;98;134:*.jpg=38;2;177;98;134:*.pdf=38;2;214;93;14:*.md=38;2;235;219;178:*.txt=38;2;235;219;178:*.json=38;2;152;151;26:*.xml=38;2;152;151;26:*.conf=38;2;152;151;26:*.zsh=38;2;152;151;26:*.sh=38;2;152;151;26"

# Created by `pipx` on 2026-06-06 20:00:40
export PATH="$PATH:/home/amine/.local/bin"
export SDL_JOYSTICK_DEADZONE=0.1



#nodejs
eval "$(fnm env --use-on-cd)"
export PATH="$HOME/.cargo/bin:$PATH"
