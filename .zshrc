# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###
export LANG=ja_JP.UTF-8

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# 失敗したコマンドは履歴に保持しない
zshaddhistory() {
    [[ "$?" == 0 ]]
}

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zhistory

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_all_dups

# スペース始まりのコマンドは記録しない
setopt hist_ignore_space

# 余分なスペース排除
setopt hist_reduce_blanks

# fzf --------------------------------------
export FZF_DEFAULT_OPTS="
--multi --border=rounded --height 85% --layout=reverse
--marker ▏ --pointer ▌ --prompt ▌
--info=inline --header=\"fzf version: $(fzf --version)\" --header-first
"
export FZF_CTRL_T_COMMAND='
  rg --files --no-ignore --hidden --follow \
  --glob "!{.git,.cache,Library,Downloads,Movies,.DS_Store,.zsh_sessions, Music, Applications (Parallels) , .pyenv}/**"
'
export FZF_CTRL_T_OPTS="
--preview 'bat --style=numbers --color=always {}'
--preview-window=down,50%,wrap
--bind '?:toggle-preview'
"
export FZF_ALT_C_COMMAND='fd --hidden --type d'
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --color=always {} | head -200'"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# fzf end -----------------------------------

# yazi yで起動、qでcd
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# zoxide
eval "$(zoxide init zsh)"

alias l="eza -a"
alias lt="eza --tree"
alias ll="eza -l"
alias cd="z"
alias cat="bat -p"
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"

