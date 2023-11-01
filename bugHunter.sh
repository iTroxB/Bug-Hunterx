#!/bin/bash
# Author: iTrox

########################
##### COLOURS EDIT #####
########################

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

#####################
##### FUNCTIONS #####
#####################

# Bye Ctrl+C
function ctrl_c(){
    echo -e "\n\n ${redColour}[!] Exit...${endColour}\n"
    tput cnorm && exit 1
}
trap ctrl_c INT

# Banner
print_banner() {
    echo;
    echo -e "  ${yellow} ______  _     _  ______      _     _ _     _ __   _ _______ _______  ______        ______  _____  _______ __   _ ${end}"
    echo -e "  ${yellow} |_____] |     | |  ____  __  |_____| |     | | \  |    |    |______ |_____/       |______ |       |_____| | \  | ${end}"
    echo -e "  ${yellow} |_____] |_____| |_____|      |     | |_____| |  \_|    |    |______ |    \_       ______| |_____  |     | |  \_| ${end}\n"
    echo -e "                                                                                           ${turquoise}by iTrox${end}\n"
}

# Update system and db
update(){

	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		if [ -e /etc/arch-release ]; then
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating${end} ${blue}$(lsb_release -si) $(uname)${end} ${gray}repositories...${end}"
			pacman -Sy &>/dev/null
			sleep 2
			if [ "$(which git)" == "/usr/bin/git" ]; then
				echo -e "\n ${turquoise}[➤]${end} ${blue}git${end} ${gray}installed...${end}"
				sleep 2
			else
				echo -e "\n ${red}[✘]${end} ${blue}git${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}git${end} ${gray}...${end}"
				pacman -S git --noconfirm
				sleep 1
				echo -e "\n ${green}[✔]${end} ${blue}git${end} ${gray}has successfully installed on your system...${end}"
				sleep 2
			fi
		elif [ -e /etc/debian_version ]; then
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating${end} ${blue}$(lsb_release -si) $(uname)${end} ${gray}repositories...${end}"
			apt update &>/dev/null
			sleep 2
			if [ "$(which git)" == "/usr/bin/git" ]; then
				echo -e "\n ${turquoise}[➤]${end} ${blue}git${end} ${gray}installed...${end}"
				sleep 2
			else
				echo -e "\n ${red}[✘]${end} ${blue}git${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}git${end} ${gray}...${end}"${green}[✔]${end}
				apt install git -y
				sleep 1
				echo -e "\n ${green}[✔]${end} ${blue}git${end} ${gray}has successfully installed on your system...${end}"
				sleep 2
			fi
		else
			echo -e "\n ${red}[✘]${end} ${gray}Unsupported Linux distribution${end}"
			exit 1
			tput cnorm
		fi
	else
		echo -e "\n ${red}[!] This script is intended for Linux systems.${end}"
		exit 1
		tput cnorm
	fi

	echo -e "\n ${turquoise}[➤]${end} ${gray}Updating system database for file search...${end}"
	updatedb &>/dev/null
	sleep 2

	dir="SecLists"
	if [ -n "$(find /usr/share -type d -name "$dir" &>/dev/null)" ]; then
		echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}$dir${end} ${gray}directory exist in the path${end} ${blue}/usr/share/$dir{end}"
	else
		echo -e "\n ${red}[✘]${end} ${gray}The${end} ${blue}$dir${end} ${gray}directory doesn't exist...${end}"
		sleep f1
		echo -e "\n ${turquoise}[➤]${end} ${gray}Downloading${end} ${blue}SecLists${end} ${gray}repository from GitHub...${end}"
		git clone https://github.com/danielmiessler/SecLists.git
		sleep 1
		echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}bug_bounty${end} ${gray}directory has been created in the path${end} ${blue}$HOME/bug_bounty${end}"
		sleep 2
	fi
	
}

# Mkdir bug-bounty
bug_bounty(){

        directory="$HOME/bug_bounty"

	if [ -d "$directory" ]; then
		echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}bug_bounty${end} ${gray}directory exist in the path${end} ${blue}$HOME/bug_bounty${end}"
		sleep 2
	else
		echo -e "\n ${red}[✘]${end} ${gray}The${end} ${blue}bug_bounty${end} ${gray}directory doesn't exist...${end}"
		sleep 1
		mkdir "$HOME/bug_bounty"
		echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}bug_bounty${end} ${gray}directory has been created in the path${end} ${blue}$HOME/bug_bounty${end}"
		sleep 2
	fi

}

# process
process(){

	if [ -d "$directory/$1" ]; then
		echo -e "\n ${green}[✔]${end} ${gray}The $1 directory exist...${end}"
		sleep 2a
	else
		echo -e "\n ${red}[✘]${end} ${gray}The $1 directory doesn't exist...${end}"
		sleep 1
		mkdir "$directory/$1"
		echo -e "\n ${green}[✔]${end} ${gray}The $1 directory has been created in the path${end} ${blue}$directory/$1${end}"
		sleep 2
	fi

	logsDir=$directory/$1/$(date +"%Y_%m_%d-%H_%M")
	mkdir "$logsDir"
	echo -e "\n ${green}[✔]${end} ${gray}A directory has been created with the current date and time in the path${end} ${blue}$directory/$1/${end}"
	sleep 1
	
	# Shuffledns
	echo -e "\n ${turquoise}[➤]${end} ${gray}Running${end} ${blue}shuffledns${end}${gray}...${end}"	
	shuffledns -d $1 -w /usr/bin/SecLists/Discovery/DNS/subdomains-top1million-110000.txt -r /home/itrox/recopilacion/lists/resolvers.txt > $logsbase/shuffledns_out.txt
	cat $logsbase/shuffledns_out.txt | unfurl --unique domains > $logsbase/shuffledns_ok.txt
	mv $logsbase/shuffledns_ok.txt $logsbase/shuffledns.txt												# ?????????????
	rm $logbase/shuffledns_out.txt
	sleep 1

	# FINDOMAIN
	findomain -t $1 > $logsbase/findomain_out.txt
	cat $logsbase/findomain_out.txt | unfurl --unique domains > $logsbase/findomain_ok.txt
	mv $logsbase/findomain_ok.txt $logsbase/findomain.txt												# ?????????????
	rm $logbase/findomain_out.txt
	sleep 1

	# CERO
	cero -d $1 > $logsbase/cero.txt

	# KATANA
	echo $1 | katana -silent -jc -o $logsbase/katana_out.txt -kf robotstxt,sitemapxml,securitytxt
	cat $logsbase/katana_out.txt | unfurl --unique domains > $logsbase/katana_ok.txt
	mv $logsbase/katana_ok.txt $logsbase/katana.txt
	rm $logbase/katana_out.txt
	sleep 1

	# CTFR
	ctfr -d $1 > $logsbase/ctfr_out.txt
	cat $logsbase/ctfr_out.txt | unfurl --unique domains | sed 's/^\*\.\(.*\)/\1/g' > $logsbase/ctfr_ok.txt
	mv $logsbase/ctfr_ok.txt $logsbase/ctfr.txt
	rm $logbase/ctfr_out.txt

	# GAU
	gau --threads 50 $1 --o $logsbase/gau_out.txt
	cat $logsbase/gau_out.txt | unfurl --unique domains > $logsbase/gau_ok.txt
	mv $logsbase/gau_ok.txt $logsbase/gau.txt
	rm $logbase/gau_out.txt
	sleep 1

	# ONE FILE
	cat $logsbase/shuffledns.txt $logsbase/findomain.txt  $logsbase/cero.txt $logsbase/katana.txt $logsbase/ctfr.txt $logsbase/gau.txt > $logsbase/subdominios.txt
}

# Main function
main_function(){
        if [ "$(id  -u)" == "0" ]; then
                bug_bounty
        	process "$1"
        else
	        echo -e "\n ${red}[!] Please, connect as root user${end}\n"
        fi
}

######################
##### RUN SCRIPT #####
######################

tput civis
#print_banner

if [ $1 ]; then
	main_function "$1"
	tput cnorm
else
	echo -e " ${red}[!] Error: Invalid format. Try again.${end}"
	echo -e "\n ${yellow}[*]${end} ${gray}Use: bugHunter <domain or subdomain without http(s)://>${end}"
	echo -e " ${yellow}[*]${end} ${gray}Example:${end} ${blue}bugHunter domain.com${end} ${gray}or${end} ${blue}bugHunter sub.domain.com${end}\n"
	tput cnorm
	exit 1
fi
