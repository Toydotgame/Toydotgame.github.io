#!/bin/zsh
#################################################################
#### AUTHOR: toydotgame                                         #
#### CREATED ON: 2025-01-18                                     #
#### Toybox: A collection of day-to-day useful Linux utilities. # # TODO: Turns out there's already a project called toybox that happens
#### Runs best at 60 columns or more.                           # # to also be a set of Linux utils :sob:. need a better name
#################################################################

# REQUIREMENTS:
# - zsh
# OPTIONAL DEPENDENCIES: (Requirements are case-by-case for each submodule, not the whole program)
# - pacman
# - wmctrl
# - yt-dlp
# - ffmpeg
# - ip
# - systemd
# - vim
# - ssh
# - sshpass
# - firefox
# - kwin_x11
# - plasma-desktop
# - discord
# - scp

########
# INIT #
########
if [ -f "$HOME/.zshrc" ]; then . ~/.zshrc; fi
setopt aliases
VERSION="a1.0.1"        # Local version is checked against the one at toydotgame.net/media/toybox.sh
LAST_UPDATE_YEAR="2025"
SOURCE="$(realpath $0)" # Location of this script
VWIDTH="$(tput cols)"   # Viewport width
COLOR_OUT="\033[0;36m"  # output
COLOR_WARN="\033[1;33m" # warnings
COLOR_ERR="\033[1;31m"  # errors
COLOR_LOGO="\033[1;35m" # warnings
COLOR_RESET="\033[0m"   # reset colour/highlight text
alias echo="echo -e"
log() { echo "$COLOR_OUT$1$COLOR_RESET" }
warn() { echo "$COLOR_WARN$1$COLOR_RESET" }
err() { echo "$COLOR_ERR$1$COLOR_RESET" >&2 }
center() {
	PADDING=$((($VWIDTH-${#1})/2))
	for i in {1..$PADDING}; do printf " "; done
	echo "$2$1$COLOR_RESET"
}

################
# COLOUR CODES #
################


# FEATURE LIST TODO:
# * AUR installer
#     * follows dependents (if missing)
#     * recursive uninstaller
# * Post-pacman system update autorun
#     * Zero-interaction vencord-installer and recompile-kwin and hard-restart-plasma
# * help command listing for toybox
# * get internal/external ip(s), show interface for internal ips (enp3s0, wg0, lo, etc)
# * yt-dlp to mp4 or mp3, and list formats available too
# * arrow key navigable interface
# * error logging to stderr
# * coloured text
# * live timedatectl current time viewer
#     * full output
#     * short output by default (pretty pls :3)
# * cool main menu when run with no options
# * quick vim to a tmp file with preinstalled shebang that when u :wq it it runs it
#     * asks if u want to save or edit after first run, choosing to edit repeats the :wq, run, prompt save/edit cycle again
# * iccmcssh access
# * iccmcscp (decode some kind of shorthand to replace with `iccmc@192.168.1.100:`)
# * very quick google search open in firefox thx
#     * firefox https://google.com/search\?q=hi & disown && wmctrl -a firefox
# * shortcut to toydotgame.net/utils
# * possible to make shift + enter exit the program once command is done?
#     * by default exits to main menu
# * nicer git clone with auto cd and nicer progress text/when done say what branch ur on
# * good calculator
# * compress/decompressor
# * which package provides <command>?
# * `find` interface
#     * find all with extension or find all containing filename
#     * case insensitive
#     * dump stderr to /dev/null
#     * say no files found if 0 lines output
# * search (case insensitive) and taskkill for running tasks
# * status:
#     * cpu usage
#     * toybox ver
#     * mem usage
#     * kernel ver
#     * submodule info: version info for listed requirements (use pacman and dump stderr if not installed)
# * update checker (against toydotgame.net) and updater of local script (good luck lol)
# every feature can be accessed directly thru `toybox <command>` and every command can also just run hands-free with
# args passed straight to it thru `toybox <command> [args]`

install() {
	if alias toybox >/dev/null 2>&1; then
		err "Toybox is already installed!"
		return
	fi

	if [ -f "$HOME/.zsh-aliases" ]; then
		printf "${COLOR_OUT}Installing Toybox to ~/.zsh-aliases... "
		echo "alias toybox=\"$SOURCE\"" >> "$HOME/.zsh-aliases"
		log "Done!\nYou will need to refresh your aliases with: $COLOR_RESET. ~/.zsh-aliases"
	elif [ -f "$HOME/.zshrc" ]; then
		printf "${COLOR_OUT}Installing Toybox to ~/.zshrc... "
		echo "alias toybox=\"$SOURCE\"" >> "$HOME/.zshrc"
		log "Done!\nYou will need to refresh your aliases with: $COLOR_RESET. ~/.zshrc"
	else
		err "Couldn't find .zshrc or aliases file! You'll have to add the following line to your terminal config:"
		echo "alias toybox=\"$SOURCE\"" >&2
		err "and reload with: $COLOR_RESET. ~/.zshrc"
	fi
}

print_options() {
	echo "Options are: $@"
	# TODO:
	# Print args seperated by newlines
	# Get length of args[]
	# Index = 0, down +1, up -1, normalise so it stays in args[].length bounds
	while true; do
		read -sk1 INPUT
		if [ "$INPUT" = $'\n' ]; then
			echo "Return"
			return
		elif [ "$INPUT" = $'\e' ]; then
			read -sk2 INPUT
			case "$INPUT" in
				"[A") echo "Up" ;;
				"[B") echo "Down" ;;
			esac
		fi
	done
}

main() {
	if [ "$VWIDTH" -ge 54 ]; then
		center "████████╗ ██████╗ ██╗   ██╗██████╗  ██████╗ ██╗  ██╗" "$COLOR_LOGO"
		center "╚══██╔══╝██╔═══██╗╚██╗ ██╔╝██╔══██╗██╔═══██╗╚██╗██╔╝" "$COLOR_LOGO"
		center "   ██║   ██║   ██║ ╚████╔╝ ██████╔╝██║   ██║ ╚███╔╝ " "$COLOR_LOGO"
		center "   ██║   ██║   ██║  ╚██╔╝  ██╔══██╗██║   ██║ ██╔██╗ " "$COLOR_LOGO"
		center "   ██║   ╚██████╔╝   ██║   ██████╔╝╚██████╔╝██╔╝ ██╗" "$COLOR_LOGO"
		center "   ╚═╝    ╚═════╝    ╚═╝   ╚═════╝  ╚═════╝ ╚═╝  ╚═╝" "$COLOR_LOGO"
	else
		center "TOYBOX" "$COLOR_LOGO"
	fi
	center "$VERSION, (ↄ) toydotgame 2025–$LAST_UPDATE_YEAR" "$COLOR_LOGO"
	echo
	center "MAIN MENU"
	log "Please choose from an option below:"
	print_options "Option 1" "Two" "Foobar"
}

case "$1" in
	"") main ;;
	"install") install ;;
	*) err "Command not found!" ;;
esac
