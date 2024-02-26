#!/bin/bash
# Author: iTrox

######################################################
#################### COLOURS EDIT ####################
######################################################
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


###################################################
#################### FUNCTIONS ####################
###################################################

# Bye Ctrl+C
function ctrl_c(){
    echo -e "\n\n ${redColour}[!] Exit...${endColour}\n"
    tput cnorm && exit 1
}
trap ctrl_c INT

# Banner
print_banner() {
    echo;
    echo -e "  ${yellow}  ____              _    _             _               _____ ${end}"
	echo -e "  ${yellow} |  _ \\            | |  | |           | |             / ____| ${end}"
	echo -e "  ${yellow} | |_) |_   _  __ _| |__| |_   _ _ __ | |_ ___ _ __  | (___   ___ __ _ _ __ ${end}"
	echo -e "  ${yellow} |  _ <| | | |/ _\` |  __  | | | | '_ \\| __/ _ \\ '__|  \___ \\ / __/ _\` | '_ \ ${end}"
	echo -e "  ${yellow} | |_) | |_| | (_| | |  | | |_| | | | | ||  __/ |     ____) | (_| (_| | | | | ${end}"
	echo -e "  ${yellow} |____/ \\__,_|\\__, |_|  |_|\\__,_|_| |_|\\__\\___|_|    |_____/ \\___\\__,_|_| |_| ${end}"
	echo -e "  ${yellow}               __/ | ${end}"
	echo -e "  ${yellow}              |___/ ${end}\n\n"
	echo -e "  ${turquoise}Footprinting and fingerprinting tool for Bug Bounty Hunty${end}\n"
    echo -e "                                                                                           ${turquoise}by iTrox${end}\n"
}

# Update system and db
system_prep(){
	if [[ $(echo $OSTYPE) == "linux-gnu" ]]; then
		if [ -e /etc/arch-release ]; then
			echo -e "\n ${turquoise}[➤]${end} ${gray}Under development for Arch Linux environment...${end}"
		
		elif [ -e /etc/debian_version ]; then
			
			# System update and upgrade
			cd /root
			dist_name=$(cat /etc/os-release | head -n 2 | tail -n 1 | awk '{print $1}' | cut -d '=' -f 2 | cut -c 2-)
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating${end} ${blue}"$dist_name" $(uname)${end} ${gray}repositories...${end} \n"
			apt update
			echo -e "\n ${green}[✔]${end} ${gray}Updating${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Upgrading${end} ${blue}"$dist_name" $(uname)${end} ${gray}system...${end} \n"
			apt upgrade -y
			echo -e "\n ${green}[✔]${end} ${gray}Upgrading${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Dist-upgrading${end} ${blue}"$dist_name" $(uname)${end} ${gray}..${end} \n"
			apt dist-upgrade -y
			echo -e "\n ${green}[✔]${end} ${gray}Dist-upgrade${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1
			echo -e "\n ${turquoise}[➤]${end} ${gray}Updating system database for file search...${end}"
			updatedb &>/dev/null
			echo -e "\n ${green}[✔]${end} ${gray}Updatedb${end} ${blue}"$dist_name" $(uname)${end} ${gray}ok...${end} \n"
			sleep 1

			# Install BugBounty tools
			
			# go
			if [ "$(which go)" == "/usr/bin/go" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}go${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}go${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}go${end}${gray}...${end}"
				apt install golang-go -y
				echo -e "\n ${green}[✔]${end} ${blue}go${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# whois
			if [ "$(which whois)" == "/usr/bin/whois" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}whois${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}whois${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}whois${end}${gray}...${end}"
				apt install whois -y
				echo -e "\n ${green}[✔]${end} ${blue}whois${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# zaproxy
			if [ "$(which zaproxy)" == "/usr/bin/zaproxy" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}zaproxy${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}zaproxy${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}zaproxy${end}${gray}...${end}"
				apt install zaproxy -y
				echo -e "\n ${green}[✔]${end} ${blue}zaproxy${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# mapcidr
			if [ "$(which mapcidr)" == "/usr/bin/mapcidr" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}mapcidr${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}mapcidr${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}mapcidr${end}${gray}...${end}"
				rm -rf /usr/bin/mapcidr
				go install github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
				ln -s $HOME/go/bin/mapcidr /usr/bin/mapcidr
				echo -e "\n ${green}[✔]${end} ${blue}mapcidr${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# dnsx
			if [ "$(which dnsx)" == "/usr/bin/dnsx" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}dnsx${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}dnsx${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}dnsx${end}${gray}...${end}"
				apt install dnsx -y
				echo -e "\n ${green}[✔]${end} ${blue}dnsx${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# massdns
			if [ "$(which massdns)" == "/usr/bin/massdns" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}massdns${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}massdns${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}massdns${end}${gray}...${end}"
				apt install massdns -y
				echo -e "\n ${green}[✔]${end} ${blue}massdns${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# cero
			if [ "$(which cero)" == "/usr/bin/cero" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}cero${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}cero${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}cero${end}${gray}...${end}"
				rm -rf /usr/bin/cero
				go install github.com/glebarez/cero@latest
				ln -s $HOME/go/bin/cero /usr/bin/cero
				echo -e "\n ${green}[✔]${end} ${blue}cero${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# katana
			if [ "$(which katana)" == "/usr/bin/katana" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}katana${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}katana${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}katana${end}${gray}...${end}"
				rm -rf /usr/bin/katana
				go install github.com/projectdiscovery/katana/cmd/katana@latest
				ln -s $HOME/go/bin/katana /usr/bin/katana
				echo -e "\n ${green}[✔]${end} ${blue}katana${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# unfurl
			if [ "$(which unfurl)" == "/usr/bin/unfurl" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}unfurl${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}unfurl${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}unfurl${end}${gray}...${end}"
				rm -rf /usr/bin/unfurl
				go install github.com/tomnomnom/unfurl@latest
				ln -s $HOME/go/bin/unfurl /usr/bin/unfurl
				echo -e "\n ${green}[✔]${end} ${blue}unfurl${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# gau
			if [ "$(which gau)" == "/usr/bin/gau" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gau${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gau${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gau${end}${gray}...${end}"
				rm -rf /usr/bin/gau
				go install github.com/lc/gau/v2/cmd/gau@latest
				ln -s $HOME/go/bin/gau /usr/bin/gau
				echo -e "\n ${green}[✔]${end} ${blue}gau${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# gowitness
			if [ "$(which gowitness)" == "/usr/bin/gowitness" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gowitness${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gowitness${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gowitness${end}${gray}...${end}"
				rm -rf /usr/bin/gowitness
				go install github.com/sensepost/gowitness@latest
				ln -s $HOME/go/bin/gowitness /usr/bin/gowitness
				echo -e "\n ${green}[✔]${end} ${blue}gowitness${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# gobuster
			if [ "$(which gobuster)" == "/usr/bin/gobuster" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}gobuster${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}gobuster${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}gobuster${end}${gray}...${end}"
				apt install gobuster -y
				echo -e "\n ${green}[✔]${end} ${blue}gobuster${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# analyticsrelationships
			if [ "$(which analyticsrelationships)" == "/usr/bin/analyticsrelationships" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}analyticsrelationships${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}analyticsrelationships${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}analyticsrelationships${end}${gray}...${end}"
				git clone https://github.com/Josue87/AnalyticsRelationships.git /tmp/analytics
				pip3 install -r /tmp/analytics/Python/requirements.txt
				mv /tmp/analytics/Python/analyticsrelationships.py /usr/bin/analyticsrelationships
				chmod +x /usr/bin/analyticsrelationships
				sed -i '1s/^/#!\/usr\/bin\/env python\n/' /usr/bin/analyticsrelationships
				rm -fr /tmp/analytics
				echo -e "\n ${green}[✔]${end} ${blue}analyticsrelationships${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# nuclei
			if [ "$(which nuclei)" == "/usr/bin/nuclei" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}nuclei${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}nuclei${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}nuclei${end}${gray}...${end}"
				apt install nuclei
				echo -e "\n ${green}[✔]${end} ${blue}nuclei${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# nuclei-templates
			find_nucleitemp=$(find / -type d -iname "nuclei-templates" -print -quit 2>/dev/null)
			if [ -n "$find_nucleitemp" ] && [ "$find_nucleitemp" == "/opt/nuclei-templates" ]; then
				echo -e "\n ${green}[✔]${end} ${blue}nuclei-templates${end} ${gray}installed...${end}"
				sleep 1
			else
				echo -e "\n ${red}[✘]${end} ${blue}nuclei-templates${end} ${gray}is not installed on your system...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Installing${end} ${blue}nuclei-templates${end}${gray}...${end}"
				git clone https://github.com/projectdiscovery/nuclei-templates.git /opt/nuclei-templates
				echo -e "\n ${green}[✔]${end} ${blue}nuclei-templates${end} ${gray}has successfully installed on your system...${end} \n"
				sleep 1
			fi
			# SecLists
			find_seclists=$(find /usr/share/wordlists -type d -iname "seclists" -print -quit 2>/dev/null)
			if [ -n "$find_seclists" ] && [ "$find_seclists" == "/usr/share/wordlists/SecLists" ]; then
				echo -e "\n ${green}[✔]${end} ${gray}The${end} ${blue}SecLists${end} ${gray}directory exist in the path${end} ${blue}/usr/share/wordlists/${end}"
			else
				echo -e "\n ${red}[✘]${end} ${gray}The${end} ${blue}SecLists${end} ${gray}directory doesn't exist...${end}"
				sleep 1
				echo -e "\n ${turquoise}[➤]${end} ${gray}Downloading${end} ${blue}SecLists${end} ${gray}repository from GitHub...${end}"
				git clone https://github.com/danielmiessler/SecLists.git /usr/share/wordlists/SecLists
				echo -e "\n ${green}[✔]${end} ${blue}SecLists${end} ${gray}directory has been created...${end}"
				sleep 1
			fi
		else
			echo -e "\n ${red}[✘]${end} ${gray}Unsupported Linux distribution${end}"
			exit 1
			tput cnorm
		fi
	else
		echo -e "\n ${red}[!] This script runs only on Linux systems...${end}"
		exit 1
		tput cnorm
	fi
}


# Main function
main_function(){
        if [ "$(id -u)" == "0" ]; then
            system_prep
        else
	        echo -e "\n ${red}[!] Please, connect as root user${end}\n"
			tput cnorm
        fi
}

######################
##### RUN SCRIPT #####
######################

print_banner
main_function
