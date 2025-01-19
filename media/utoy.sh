#!/bin/zsh
#################################################################
#### AUTHOR: toydotgame                                         #
#### CREATED ON: 2025-01-18                                     #
#### UToy: A collection of day-to-day useful Linux utilities. #
#### Runs best at 40 columns or more.                           #
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
VERSION="a1.0.1"          # Local version is checked against the one at toydotgame.net/media/utoy.sh
LAST_UPDATE_YEAR="2025"
SOURCE="$(realpath $0)"   # Script location
VWIDTH="$(tput cols)"
OPTIONS=("${@:2}")        # Later fetched by functions as if they were a command and these were $@
MENU_SELECTION=""

# Colour codes:
COLOR_OUT="\e[0;36m"      # Output
COLOR_WARN="\e[1;33m"     # Warnings
COLOR_ERR="\e[1;31m"      # Errors
COLOR_LOGO="\e[1;35m"     # Warnings
COLOR_SELECT="\e[30;107m" # Selected text
COLOR_RESET="\e[0m"       # Reset colour/highlight text

# Logging:
alias echo="echo -e"
log() { echo "$COLOR_OUT$1$COLOR_RESET" }
warn() { echo "$COLOR_WARN$1$COLOR_RESET" }
err() { echo "$COLOR_ERR$1$COLOR_RESET" >&2 }
center() {
	PADDING=$((($VWIDTH-${#1})/2))
	for i in {1..$PADDING}; do printf " "; done
	echo "$2$1$COLOR_RESET"
}

# FEATURE LIST TODO:
# * AUR installer
#     * follows dependents (if missing)
#     * recursive uninstaller
# * Post-pacman system update autorun
#     * Zero-interaction vencord-installer and recompile-kwin and hard-restart-plasma
# * help command listing for utoy
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
#     * utoy ver
#     * mem usage
#     * kernel ver
#     * submodule info: version info for listed requirements (use pacman and dump stderr if not installed)
# * update checker (against toydotgame.net) and updater of local script (good luck lol)
# every feature can be accessed directly thru `utoy <command>` and every command can also just run hands-free with
# args passed straight to it thru `utoy <command> [args]`

install() {
	if alias utoy >/dev/null 2>&1; then
		err "UToy is already installed!"
		return
	fi

	if [ -f "$HOME/.zsh-aliases" ]; then
		printf "${COLOR_OUT}Installing UToy to ~/.zsh-aliases... "
		echo "alias utoy=\"$SOURCE\"" >> "$HOME/.zsh-aliases"
		log "Done!\nYou will need to refresh your aliases with: $COLOR_RESET. ~/.zsh-aliases"
	elif [ -f "$HOME/.zshrc" ]; then
		printf "${COLOR_OUT}Installing UToy to ~/.zshrc... "
		echo "alias utoy=\"$SOURCE\"" >> "$HOME/.zshrc"
		log "Done!\nYou will need to refresh your aliases with: $COLOR_RESET. ~/.zshrc"
	else
		err "Couldn't find .zshrc or aliases file! You'll have to add the following line to your terminal config:"
		echo "alias utoy=\"$SOURCE\"" >&2
		err "and reload with: $COLOR_RESET. ~/.zshrc"
	fi
}

menu() {
	OPTIONS_COUNT="${#@[@]}"
	SELECTED_INDEX=1
	if [ $OPTIONS_COUNT -le 0 ]; then
		err "No arguments supplied to menu!"
		return
	fi
	print_menu() {
		for i in {1..$OPTIONS_COUNT}; do
			if [ $i = $SELECTED_INDEX ]; then
				echo "$COLOR_OUT> $COLOR_SELECT${@[$i]}$COLOR_RESET"
			else
				echo "  ${@[$i]}"
			fi
		done
	}
	print_menu "$@"

	while true; do
		read -sk1 INPUT
		if [ "$INPUT" = $'\e' ]; then
			read -sk2 INPUT
			case "$INPUT" in
				"[A") # Up arrow:
					if [ $SELECTED_INDEX -gt 1 ]; then
						((SELECTED_INDEX--))
						printf "\e[${OPTIONS_COUNT}A\e[K"
						print_menu "$@"
					fi ;;
				"[B") # Down arrow:
					if [ $SELECTED_INDEX -lt $OPTIONS_COUNT ]; then
						((SELECTED_INDEX++))
						printf "\e[${OPTIONS_COUNT}A\e[K"
						print_menu "$@"
					fi ;;
			esac
		elif [ "$INPUT" = $'\n' ]; then
			MENU_SELECTION="${@[$SELECTED_INDEX]}"
			return
		fi
	done
}

main() {
	if [ "$VWIDTH" -ge 54 ]; then
		center "██╗   ██╗████████╗ ██████╗ ██╗   ██╗" "$COLOR_LOGO"
		center "██║   ██║╚══██╔══╝██╔═══██╗╚██╗ ██╔╝" "$COLOR_LOGO"
		center "██║   ██║   ██║   ██║   ██║ ╚████╔╝ " "$COLOR_LOGO"
		center "██║   ██║   ██║   ██║   ██║  ╚██╔╝  " "$COLOR_LOGO"
		center "╚██████╔╝   ██║   ╚██████╔╝   ██║   " "$COLOR_LOGO"
		center " ╚═════╝    ╚═╝    ╚═════╝    ╚═╝   " "$COLOR_LOGO"
	else
		center "UTOY" "$COLOR_LOGO"
	fi
	center "A collection of utilities for Zsh."
	center "$VERSION, (ↄ) toydotgame 2025–$LAST_UPDATE_YEAR" "$COLOR_LOGO"
	echo
	center "MAIN MENU"
	log "Please choose from an option below:"
	menu "Hardcoded" "Options" "are freaking awesome!!!" "Meow" "foo bar" # TODO: Replace $OPTIONS with hardcoded main menu items
	echo "Menu selection was: \"$MENU_SELECTION\""
#	case "$MENU_SELECTION" in;
#		"1") echo "\`menu\` returned 1" ;;
#		"2") echo "\`menu\` returned 1" ;;
#		"3") echo "\`menu\` returned 1" ;;
#		*) err "\`menu\` returned something else" ;;
#	esac
}

case "$1" in
	"") ;&
	"main") main ;;
	"install") install ;;
	*) err "Command not found!" ;;
esac