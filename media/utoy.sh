#!/bin/zsh
#################################################################
#### AUTHOR: toydotgame                                         #
#### CREATED ON: 2025-01-18                                     #
#### UToy: A collection of day-to-day useful Linux utilities. #
#### Runs best at 40 columns or more.                           #
#################################################################

# DEPENDENCIES:
# - zsh
# - pacman
# Additional by module can be installed with `utoy install`

########
# INIT #
########
if [ -f "$HOME/.zshrc" ]; then . ~/.zshrc; fi
setopt aliases
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
log_center() {
	PADDING=$((($VWIDTH-${#1})/2))
	for i in {1..$PADDING}; do printf " "; done
	echo "$2$1$COLOR_RESET"
}

# Update checking:
VERSION="a1.0.1"          # Local version is checked against the one at toydotgame.net/media/utoy.sh
LATEST="$(curl -sLm 5 https://toydotgame.net/media/utoy.sh | grep 'VERSION=' | sed -e 's/.*"\(.*\)".*/\1/')"
LAST_UPDATE_YEAR="2025"
if [ "$VERSION" != "$LATEST" ]; then
	log "${COLOR_WARN}UToy is not up to date! Latest: $LATEST, local: $VERSION.\nRun ${COLOR_RESET}utoy update$COLOR_WARN to update\n"
fi
# pacman needs array format, not just space delimited packages:
DEPENDENCIES=("coreutils" "discord" "ffmpeg" "firefox" "iproute2" "kwin" "openssh" "plasma-desktop" "procps-ng" "sshpass" "systemd" "vim" "wmctrl" "yt-dlp" "foo")

# FEATURE LIST TODO:
# * AUR installer
#     * follows dependents (if missing)
#     * recursive uninstaller
# * Post-pacman system update autorun
#     * Zero-interaction vencord-installer and recompile-kwin and hard-restart-plasma
# * help command listing for utoy
# * get internal/external ip(s), show interface for internal ips (enp3s0, wg0, lo, etc)
# * yt-dlp to mp4 or mp3, and list formats available too
# * live timedatectl current time viewer
#     * full output
#     * short output by default (pretty pls :3)
# * iccmcssh access
# * iccmcscp (decode some kind of shorthand to replace with `iccmc@192.168.1.100:`)
# * very quick google search open in firefox thx
#     * 
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
# * updater of local script (good luck lol)
# remember every module can be run also with `utoy <cmd> [args]`

module_test() { # Test Zsh Syntax
	TMPFILE="/tmp/utoy-$(date +%s%N).sh"
	echo "#!/bin/zsh\n# Blank syntax test file created by UToy $VERSION\n# CREATED ON: $(date +%Y-%m-%d)\n\n\n" >> "$TMPFILE"
	vim +5 -c "startinsert" "$TMPFILE"
	chmod +x "$TMPFILE"
	log "File saved. What would you like to do?"

	while true; do
		menu "Run" "Edit" "Save & quit" "Delete & quit"
		case "$MENU_SELECTION" in;
			"Run")
				log "Running script..."
				printf "$COLOR_OUT"; for i in {1..$VWIDTH}; do printf "#"; done; printf "$COLOR_RESET\n"
				eval "$TMPFILE"
				printf "$COLOR_OUT"; for i in {1..$VWIDTH}; do printf "#"; done; printf "$COLOR_RESET\n"
				log "Run complete. What would you like to do?" ;;
			"Edit")
				vim +5 "$TMPFILE"
				log "File saved. What would you like to do?" ;;
			"Save & quit")
				DEST="" # Must be declared for vared to work
				log "Where would you like to save to?"; vared DEST
				echo "\$DEST=\"$DEST\""
				if [ -z "$DEST" ]; then
					DEST="$(realpath .)"
				else
					DEST="${DEST/#\~/$HOME}" # Substitute `~` for $HOME value. From https://stackoverflow.com/a/27485157
				fi
				if grep -i "/" <<< "$DEST" && [ ! -d "${DEST%/*}" ]; then
					if ! mkdir -p "${DEST%/*}"; then
						err "Save failed! Directory does not exist and could not be created."
						log "\nWhat would you like to do?"
						continue # Break from case
					fi
				fi
				if ! mv -i "$TMPFILE" "$DEST"; then
					err "Save failed! Couldn't save file to this location."
					log "\nWhat would you like to do?"
					continue
				fi
				log "File saved."
				break ;;
			"Delete & quit")
				log "${COLOR_ERR}Are you sure? (Cannot be undone)"
				menu "Yes" "No"
				if [ $MENU_SELECTION = "Yes" ]; then
					rm -f "$TMPFILE"
					log "File deleted."
					break
				fi
				log "Deletion cancelled. What would you like to do?" ;;
		esac
	done
}

module_post_update() { # Fix Vencord and KWin Post-Update
	case "${OPTIONS[1]}" in;
		"discord") ;& "vencord") MENU_SELECTION="Vencord" ;;
		"kwin") MENU_SELECTION="KWin Window Decorations" ;;
		"both") MENU_SELECTION="Both" ;;
		*) MENU_SELECTION="" ;; # Reset menu selection because we kinda bodgily use it to parse cmdline inputs into this module
	esac
	if [ -z "$MENU_SELECTION" ]; then
		log "What would you like to patch?"
		menu "Vencord" "KWin Window Decorations" "Both"
	fi

	if [ "$MENU_SELECTION" = "Vencord" ] || [ "$MENU_SELECTION" = "Both" ]; then
		sudo rm -f /opt/discord/discord.desktop /opt/discord/discord.png
		sudo ln -s ~/pkgs/discord.desktop /opt/discord/discord.desktop
		sudo ln -s ~/pkgs/discord.png /opt/discord/discord.png
		sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
	fi

	if [ "$MENU_SELECTION" = "KWin Window Decorations" ] || [ "$MENU_SELECTION" = "Both" ]; then
		#########################################################################
		#### AUTHOR: toydotgame                                                 #
		#### CREATED ON: 2025-01-17                                             #
		#### Formerly recompile-kwin.sh                                         #
		#### Quick script to recompile KWin Aero effects after a system upgrade #
		#########################################################################
		
		SAVE_PWD="$PWD" # Restore working dir once script is done
		AEROTHEMEPLASMA_DIR="$HOME/pkgs/aerothemeplasma/"
		cd "$AEROTHEMEPLASMA_DIR"

		# Re-compile KWin effects:
		cd "kwin/decoration/"
		for i in *; do
			cd "$i"
			./install.sh
			cd ..
		done

		cd "kwin/effects_cpp/"
		for i in *; do
			cd "$i"
			./install.sh
			cd ..
		done

		kwin_x11 --replace >/dev/null 2>&1 & disown
		plasmashell --replace >/dev/null 2>&1 & disown
		cd "$SAVE_PWD"
	fi
}

module_status() { # Computer Status & Version Info
	print_title
	log_center "STATUS"
	log "\tUToy Version:$COLOR_RESET $VERSION (Latest: $LATEST)"
	log "\tCPU Utilisation:$COLOR_RESET $(vmstat | awk 'END{id=$(NF-3); print 100-id"%"}')"
	log "\tVRAM Use:$COLOR_RESET $(free -h | awk 'FNR==2{print $3"B / "$2"B"}')"
	DF_OUTPUT="$(df -hT .)"
	log "\tWorking FS Info:$COLOR_RESET $(echo $DF_OUTPUT | awk 'FNR==1')"
	log "\t                $COLOR_RESET $(echo $DF_OUTPUT | awk 'FNR==2')"
	echo
	log_center "VERSIONS"
	log "\tKernel:$COLOR_RESET $(uname -r)"
	PACMAN_OUTPUT="$(pacman -Q $DEPENDENCIES --color=always 2>&1)"
	log "\tPacman:$COLOR_RESET $(echo $PACMAN_OUTPUT | awk 'FNR==1')"
	          log "$COLOR_RESET$(echo $PACMAN_OUTPUT | awk 'FNR>=2{print "\t       ", $0}')"
}

module_search() { # Search Google
	SEARCH_QUERY=""
	if [ -z $(echo "$OPTIONS") ]; then
		log "Where do you want to go today?"; vared SEARCH_QUERY # Microsoft: Making it easier
	fi
	SEARCH_QUERY="$OPTIONS"
	firefox "https://google.com/search?q=$SEARCH_QUERY" & disown && \
	wmctrl -a firefox
}

###################
# CORE COMPONENTS #
###################
install() {
	if ! pacman -Q $DEPENDENCIES >/dev/null 2>&1; then
		err "Missing dependencies! Installing now..."
		sudo pacman -S $DEPENDENCIES --needed --noconfirm
	fi

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
			echo
			return
		fi
	done
}

print_title() {
	if [ "$VWIDTH" -ge 54 ]; then
		log_center "██╗   ██╗████████╗ ██████╗ ██╗   ██╗" "$COLOR_LOGO"
		log_center "██║   ██║╚══██╔══╝██╔═══██╗╚██╗ ██╔╝" "$COLOR_LOGO"
		log_center "██║   ██║   ██║   ██║   ██║ ╚████╔╝ " "$COLOR_LOGO"
		log_center "██║   ██║   ██║   ██║   ██║  ╚██╔╝  " "$COLOR_LOGO"
		log_center "╚██████╔╝   ██║   ╚██████╔╝   ██║   " "$COLOR_LOGO"
		log_center " ╚═════╝    ╚═╝    ╚═════╝    ╚═╝   " "$COLOR_LOGO"
	else
		log_center "UTOY" "$COLOR_LOGO"
	fi
	log_center "A collection of utilities for Zsh."
	log_center "$VERSION, (ↄ) toydotgame 2025–$LAST_UPDATE_YEAR" "$COLOR_LOGO"
	echo
}

main() {
	print_title
	log_center "MAIN MENU"
	log "Please choose from an option below:"
	menu \
		"Test Zsh Syntax" \
		"Fix Vencord and KWin Post-Update" \
		"Computer Status & Version Info" \
		"Search Google"
	load_module "$MENU_SELECTION"
}

load_module() { # Main menu function that takes either cmdline shortcut or menu() output
	case "$1" in
		"") ;& "main") main ;;
		"install") install ;;
		"test") ;& "Test Zsh Syntax") module_test ;;
		"postupdate") ;& "Fix Vencord and KWin Post-Update") module_post_update ;;
		"status") ;& "Computer Status & Version Info") module_status ;;
		"search") ;& "Search Google") module_search ;;
		*) err "Command \"$1\" not found! Run ${COLOR_RESET}utoy help$COLOR_ERR for help." ;;
	esac
}

load_module "$1"
