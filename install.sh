#!/bin/bash 
#
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Function to print big letters
print_big_letters() {
    text="$1"
    color="$2"

    echo -e "${color}"
    figlet -f slant "${text}"
    echo -e "${RESET}"
}

# Usage example
print_big_letters "CyberPunker" "${CYAN}"

echo -e "${BLUE}${bold}---------------Code by ETA---------------${RESET}"

# Colored "Cyberpunk" letter
echo -e "${BLUE}${bold}*****          Hack the System!      ******       ${e}"
echo -e "${BLUE}${bold}*****         cyberPunker     *****         ${RESET}" 
#
echo "installing GF patterns"
 mkdir ~/.gf
	 git clone https://github.com/1ndianl33t/Gf-Patterns
	 cd Gf-Patterns
	 mv * ~/.gf
	 cd ..

GOlang() {
	printf "                                \r"
	sys=$(uname -m)
	#LATEST=$(curl -s 'https://go.dev/VERSION?m=text') # https://golang.org/dl/$LATEST.linux-amd64.tar.gz
	[ $sys == "x86_64" ] && wget https://go.dev/dl/go1.17.13.linux-amd64.tar.gz -O golang.tar.gz &>/dev/null || wget https://golang.org/dl/go1.17.13.linux-386.tar.gz -O golang.tar.gz &>/dev/null
	sudo tar -C /usr/local -xzf golang.tar.gz
	export GOROOT=/usr/local/go
	export GOPATH=$HOME/go
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
	echo "[!] Add The Following Lines To Your ~/.${SHELL##*/}rc file:"
 	echo 'export GOROOT=/usr/local/go'
  	echo 'export GOPATH=$HOME/go'
   	echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin'
	
	printf "[+] Golang Installed !.\n"
}

Findomain() {
	printf "                                \r"
	wget https://github.com/Findomain/Findomain/releases/download/8.2.1/findomain-linux.zip &>/dev/null
	unzip findomain-linux.zip
 	rm findomain-linux.zip
	chmod +x findomain
	./findomain -h &>/dev/null && { sudo mv findomain /usr/local/bin/; printf "[+] Findomain Installed !.\n"; } || printf "[!] Install Findomain manually: https://github.com/Findomain/Findomain/blob/master/docs/INSTALLATION.md\n"
}

Subfinder() {
	printf "                                \r"
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest &>/dev/null
	printf "[+] Subfinder Installed !.\n"
}

Amass() {
	printf "                                \r"
	go install -v github.com/owasp-amass/amass/v4/...@master &>/dev/null
	printf "[+] Amass Installed !.\n"
}

Assetfinder() {
	printf "                                \r"
	go install github.com/tomnomnom/assetfinder@latest &>/dev/null
	printf "[+] Assetfinder Installed !.\n"
}

Httpx() {
	printf "                                \r"
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest  &>/dev/null
	printf "[+] Httpx Installed !.\n"
}

Parallel() {
	printf "                                \r"
	sudo apt-get install parallel -y
	printf "[+] Parallel Installed !.\n"
}

Anew() {
	printf "                                \r"
	go install -v github.com/tomnomnom/anew@latest &>/dev/null
	printf "[+] Anew Installed !.\n"
}

Dnsx() {
	printf "                                \r"
	go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest &>/dev/null
	printf "[+] Dnsx Installed !.\n"
}

Git-xargs() {
	printf "                                \r"
	go install github.com/gruntwork-io/git-xargs@latest &>/dev/null
	printf "[+] Git-xargs Installed !.\n"
}

Cariddi() {
	printf "                                \r"
	go install -v github.com/edoardottt/cariddi/cmd/cariddi@latest &>/dev/null
	printf "[+] Cariddi Installed !.\n"
}

gf() {
	printf "                                  \r"
	 go install -v github.com/tomnomnom/gf@latest &>/dev/null
	 printf "[+] gf installed !.\n"
}

gau() {
	printf "                                  \r"
	 go install github.com/lc/gau/v2/cmd/gau@latest &>/dev/null
	 printf "[+] gau installed !.\n"
}

qsreplace() {
	printf "                                  \r"
	 go install github.com/tomnomnom/qsreplace@latest &>/dev/null
	 printf "[+] qsreplace installed !.\n"
}

katana() {
	printf "                                  \r"
	 go install github.com/projectdiscovery/katana/cmd/katana@latest &>/dev/null
	 printf "[+] katana installed !.\n"
}

waybackurl() {
	printf "                                  \r"
	 go install github.com/tomnomnom/waybackurls@latest &>/dev/null
	 printf "[+] waybackurl installed !.\n"
}

subjs() {
	printf "                                  \r"
	 go install github.com/lc/subjs@latest &>/dev/null
	 printf "[+] subjs installed !.\n"
}


massscan(){
	sudo apt-get --assume-yes install git make gcc
git clone https://github.com/robertdavidgraham/masscan
cd masscan
make
make install
make -j
}

subzy() {
	printf"                                  \r"
	 go install -v github.com/LukaSikic/subzy@latest  &>/dev/null
	 printf "[+] subzy installed !.\n"
}

xargs() {
	printf"                                  \r"
	 go install github.com/gruntwork-io/git-xargs@latest &>/dev/null
	 printf "[+] xargs installed !.\n"
}

hash go 2>/dev/null && printf "[!] Golang is already installed.\n" || { printf "[+] Installing GOlang!" && GOlang; } 


hash findomain 2>/dev/null && printf "[!] Findomain is already installed.\n" || { printf "[+] Installing Findomain!" && Findomain; }
hash subfinder 2>/dev/null && printf "[!] subfinder is already installed.\n" || { printf "[+] Installing subfinder!" && Subfinder; }
hash amass 2>/dev/null && printf "[!] Amass is already installed.\n" || { printf "[+] Installing Amass!" && Amass; }
hash assetfinder 2>/dev/null && printf "[!] Assetfinder is already installed.\n" || { printf "[+] Installing Assetfinder!" && Assetfinder; }
hash httpx 2>/dev/null && printf "[!] Httpx is already installed.\n" || { printf "[+] Installing Httpx!" && Httpx; }
hash parallel 2>/dev/null && printf "[!] Parallel is already installed.\n" || { printf "[+] Installing Parallel!" && Parallel; }
hash anew 2>/dev/null && printf "[!] Anew is already installed.\n" || { printf "[+] Installing Anew!" && Anew; }
hash gf 2>/dev/null && printf "[!] gf is already installed.\n" || { printf "[+] Installing gf!" && gf; }
hash masscan 2>/dev/null && printf "[!] masscan is already installed.\n" || { printf "[+] Installing masscan!" && masscan; }
hash xargs 2>/dev/null && printf "[!] xargs is already installed.\n" || { printf "[+] Installing margs!" && margs; }
hash subzy 2>/dev/null && printf "[!] subzy is already installed.\n" || { printf "[+] Installing subzy!" && subzy; }
hash subjs 2>/dev/null && printf "[!] subjs is already installed.\n" || { printf "[+] Installing subjs!" && subjs; }
hash waybackurl 2>/dev/null && printf "[!] waybackurl is already installed.\n" || { printf "[+] Installing waybackurl!" && waybackurl; }
hash gau 2>/dev/null && printf "[!] gau is already installed.\n" || { printf "[+] Installing gau!" && gau; }
hash qsereplace 2>/dev/null && printf "[!] qsreplace is already installed.\n" || { printf "[+] Installing qsereplace!" && qsreplace; }
hash dnsx 2>/dev/null && printf "[!] dnsx is already installed.\n" || { printf "[+] Installing dnsx!" && dnsx; }
hash git-xargs 2>/dev/null && printf "[!] git-xargs is already installed.\n" || { printf "[+] Installing git-xargs!" && git-xargs; }
hash cariddi 2>/dev/null && printf "[!] cariddi is already installed.\n" || { printf "[+] Installing cariddi!" && cariddi; }
 

list=(
	go
	findomain
	subfinder
	amass
	assetfinder
	httpx
	parallel
 	anew
 	gf
 	massscan
 	xargs
 	subzy
 	subjs
 	waybackurl
 	gau
 	qsreplace
 	cariddi
        git-xargs
	dnsx
	)

r="\e[31m"
g="\e[32m"
e="\e[0m"

for prg in ${list[@]}
do
        hash $prg 2>/dev/null && printf "[$prg]$g Done$e\n" || printf "[$prg]$r Something Went Wrong! Try Again Manually.$e\n"
done
