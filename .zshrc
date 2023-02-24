# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path alias
setopt cdable_vars
setopt extendedglob
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export ARCHFLAGS="-arch x86_64"
#export LC_CTYPE=C
#export LANG=C
#export w=$HOME/Workbench
export t=$HOME/0-TMP/temp
export o=$HOME/OneDrive1/$(ls $HOME/OneDrive1/)
export m=$HOME/0-MI
export k=$HOME/3-KNWL
export dl=$HOME/Downloads
#export s=$HOME/Workbench/School
export 0=$HOME/0-TMP
export salt=$HOME/3-KNWL/34-Notes/Salt-Box
#export snip=$HOME/3-KNWL/34-Notes/Salt-Box/.obsidian/snippets
if [ -d ~/.texmf ] ; then
    export TEXMFHOME=~/.texmf
fi
export GOPATH=~/.go
export GOROOT="$(brew --prefix golang)/libexec"

# Default editor
export EDITOR=nvim
export VISUAL="$EDITOR"

# pre-oh-my-zsh
# aliases
alias temp="cd ~/0-TMP/temp"
alias lse=ls_extended
alias weather="curl http://wttr.in/"
alias figletc="figlet -c -w \$(tput cols)"
alias hello="say -v Fred hi\!"
alias c=clear
alias re="clear && neofetch"
alias cat="bat --theme ansi"
alias sed=gsed
alias e=$EDITOR
alias lc='colorls -A --sd'
alias p=pbcopy
alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias nv=nvim
alias v=nvim
alias lazy='XDG_CONFIG_HOME="$HOME/.lazy" XDG_DATA_HOME="$HOME/.local/share/lazynvim" XDG_CACHE_HOME="$HOME/.cache/lazynvim" nvim'
alias lv=lazy
alias lsf="ls | fzf"
alias pgu="echo \"![](\$(picgo upload | tail -n +6))\" | pbcopy"
#alias snip="/Applications/Snipaste.app/Contents/MacOS/Snipaste snip"
alias R="R --no-save"
alias panmd="pandoc -f markdown+tex_math_single_backslash --pdf-engine=xelatex --citeproc -o output.pdf"
alias xdg-open="open"
alias q=exit

# Functions
mvf() { mv "$@" && goto "$_"; }
cpf() { mv "$@" && goto "$_"; }
goto() { [ -d "$1" ]  && cd "$1" || cd "$(dirname "$1")"; }
diff () {
    /usr/bin/diff -u $1 $2 | diff-so-fancy
}
diffr () {
    /usr/bin/diff -rq $1 $2 | diff-so-fancy
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

LFCD="/etc/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# PATH
export PATH="\
/opt/homebrew/bin:\
/opt/homebrew/sbin:\
/Users/ce/.local/bin:\
/Applications/MATLAB_R2021b.app/bin:\
/Applications/MATLAB_R2021b.app/bin/maci64:\
/opt/homebrew/anaconda3/bin:\
${GOPATH}/bin:${GOROOT}/bin:\
$PATH"  

# autosuggestions
bindkey '^P' autosuggest-accept

# icons-in-terminal
source ~/.local/share/icons-in-terminal/icons_bash.sh
source $(dirname $(gem which colorls))/tab_complete.sh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=(
	# "robbyrussell"
	# "agnoster"
	# "bureau"
	# "candy"
	# "duellj"
	# "jonathan"
	powerlevel10k/powerlevel10k
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	aliases
	alias-finder
	#bbedit
	brew
	emoji
	fzf
	git
	#node
	#npm
	pip
	python
	# ssh-agent
	sudo
	vscode
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
    #copyfile
    dirhistory
    history
    macos
)

source $ZSH/oh-my-zsh.sh

# Compilation flags
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# functions

#snow() {
#	ruby -e 'C=`stty size`.scan(/\d+/)[1].to_i;S=["2743".to_i(16)].pack("U*");a={};puts "\033[2J";loop{a[rand(C)]=0;a.each{|x,o|;a[x]+=1;print "\033[#{o};#{x}H \033[#{a[x]};#{x}H#{S} \033[0;0H"};$stdout.flush;sleep 0.1}'
#}

# rga-fzf
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

eval $(thefuck --alias)


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

