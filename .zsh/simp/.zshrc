if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
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

# Path alias
setopt cdable_vars
setopt extendedglob
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
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
export snip=$HOME/3-KNWL/34-Notes/Salt-Box/.obsidian/snippets
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
rmd() { Rscript -e "rmarkdown::render('$1')"; }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

LFCD="/etc/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

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

plugins=(
	brew
	fzf
	git
	python
	sudo
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

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

#eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.zsh/simp/.p10k.zsh.
[[ ! -f ~/.zsh/simp/.p10k.zsh ]] || source ~/.zsh/simp/.p10k.zsh
