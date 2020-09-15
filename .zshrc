# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.zsh/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.zsh/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PATH=$HOME/.local/bin:$HOME/.cargo/bin/:$HOME/.cargo/bin:/usr/local/bin/:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi


plugins=(zsh-autsuggestions, zsh-syntax-highlighting )
autoload -U compinit && compinit
# Set the default editor
export EDITOR=vim
export VISUAL=vim


# Edit this .bashrc file
alias ezrc='vim ~/.zshrc'

# Show help for this .bashrc file
alias hlp='less ~/.bashrc_help'

alias tidy="sudo pacman -Rns $(pacman -Qtdq)"
alias optimise="sudo pacman-optimize"
# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias ls='exa --icons -la --group-directories-first --all' # add colors and file type extensions

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# SHA1
alias sha1='openssl sha1'


# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Create and go to the directory
mkdirg ()
{
	mkdir -p $1
	cd $1
}

#Automatically do an ls after each cd
 cd ()
 {
 	if [ -n "$1" ]; then
 		builtin cd "$@" && ls
 	else
 		builtin cd ~ && ls
 	fi
 }

# Show the current version of the operating system
ver ()
{
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		if [ -s /etc/redhat-release ]; then
			cat /etc/redhat-release && uname -a
		else
			cat /etc/issue && uname -a
		fi
	elif [ $dtype == "suse" ]; then
		cat /etc/SuSE-release
	elif [ $dtype == "debian" ]; then
		lsb_release -a
		# sudo cat /etc/issue && sudo cat /etc/issue.net && sudo cat /etc/lsb_release && sudo cat /etc/os-release # Linux Mint option 2
	elif [ $dtype == "gentoo" ]; then
		cat /etc/gentoo-release
	elif [ $dtype == "mandriva" ]; then
		cat /etc/mandriva-release
	elif [ $dtype == "slackware" ]; then
		cat /etc/slackware-version
	else
		if [ -s /etc/issue ]; then
			cat /etc/issue
		else
			echo "Error: Unknown distribution"
			exit 1
		fi
	fi
}

# Automatically install the needed support files for this .bashrc file
install_bashrc_support ()
{
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		sudo yum install multitail tree joe
	elif [ $dtype == "suse" ]; then
		sudo zypper install multitail
		sudo zypper install tree
		sudo zypper install joe
	elif [ $dtype == "debian" ]; then
		sudo apt-get install multitail tree joe
	elif [ $dtype == "gentoo" ]; then
		sudo emerge multitail
		sudo emerge tree
		sudo emerge joe
	elif [ $dtype == "mandriva" ]; then
		sudo urpmi multitail
		sudo urpmi tree
		sudo urpmi joe
	elif [ $dtype == "slackware" ]; then
		echo "No install support for Slackware"
	else
		echo "Unknown distribution"
	fi
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#DB9065,underline"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# CUSTOM SETTINGS FROM THE INTERNERT 
# URL: https://callstack.com/blog/supercharge-your-terminal-with-zsh/?__cf_chl_captcha_tk__=cc712acced30f7511603e70867b0ab9e86c60f8d-1590687615-0-AXAcDLlqp8eD3eu6R-RH7Rf7xwvNhYTB7Wdy1T7tl1q51uMfP94c_l1bj2ZaEO6-FNqUH5zhigQLkTWSudLGtEMHD5gce7FoyjWAFnXsM-T_slAYagc44JxvlbGzYBaLrAdH4ifME6803maZboYck-2ICtsrHrqvkx31nEGztflpAyOxUwoHUpgl9j7Y6qfR9-D6sO_vygn8shXM1U-v-vwO9S7CH4x-wl835vpS873mZYhwg9Tk5CWknggPsHtexdhhsT_hJqCI9PPusOHqQrdUogSa1NW1vN_1iW_me_APGWWKAp43Zi9fJHmGq9L7eTR5wNspnkon2xazz7m9nLg4cdtq9nJ-1D4rpfg3vo6Hiv43-R3OFkkO9H-LNRoC53oeLCY7UZobcvnh1XMOcYeGqDs3Ur7GkEWoM2QAL9tfw4PiBpZlGIxuNX19h90K0M-nML_cLuQD5dyda3KUkzhKFze_q8RVaZuXnEcy2IE8rQ6NqfmsVvpecYNb_XVbnLZZDJKG2JYAtcwyh_wF451ddHSHoparz6C0BaMvsjFYu8EFm6dfhRdh3IvkHf6JwA
# Enable autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist
### RANDOM COLOR SCRIPT ###
/opt/shell-color-scripts/colorscript.sh random
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
