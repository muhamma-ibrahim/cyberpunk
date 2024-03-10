#!/bin/bash
# Colored "Cyberpunk" letter
echo -e "${g}███╗   ███╗ █████╗ ███████╗███████╗${e}"
echo -e "${g}████╗ ████║██╔══██╗╚══███╔╝╚════██║${e}"
echo -e "${g}██╔████╔██║███████║  ███╔╝  ████╔╝${e}"
echo -e "${g}██║╚██╔╝██║██╔══██║ ███╔╝  ██╔══╝ ${e}"
echo -e "${g}██║ ╚═╝ ██║██║  ██║███████╗███████╗${e}"
echo -e "${g}╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝${e}"
echo -e "${r}             Hack the System!             ${e}"
echo -e "${r}             Code By Cyber Punk!            ${e}"

# selecting domain and targets
read -p "Whats Your Domain :" target
read -p "Name of Output Dirctory :" output
mkdir $output

echo "-------------------------------------------------------------------------" 
echo "-------------------------------------------------------------------------" 
#gathering subdomains
echo "using assetfinder :"
echo $target | assetfinder -subs-only | anew $output/assetfinder.txt

echo "-------------------------------------------------------------------------" 
echo "-------------------------------------------------------------------------" 
echo "using findomain :"
findomain -t $target -u $output/findomain.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Using Subfinder :"
subfinder -d $target -o $output/subfinder.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Using Subenum.sh :"
curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "domain=$target&submit=" https://seckrd.com/subdomain-finder.php | grep -oE "https?://[^'\"]+" | awk -F/ '{print $3}' > $output/subenum.txt ;

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Using crt.sh :"
curl -s "https://crt.sh/?q=%25.$target&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > "$output/crt.txt"

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Managing subdomains files into uniq file:"
cd $output
cat * | uniq | anew uniq.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding Valid subdomains :"
httpx -l uniq.txt -mc  200,403,301 -o httpx.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding Heartbleed Vulnerability:"
cat httpx.txt | while read line ; do echo "QUIT" | openssl s_client -connect $line:443 2>&1 | grep 'server extension "heartbeat" (id=15)' || echo $line: safe; done > heartbleed.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding subdomain takeover:"
takeover -l httpx.txt -o subtake.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Starting IP enumeration"
echo "making directory for IP:"
mkdir IP
cp httpx.txt IP
cd IP
httpx -l httpx.txt -ip  -o sb.txt
echo "seprating IPS:"
grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' sb.txt > validip.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Enumerating Nmap Scan:"
masscan -p1-65535 -iL validip.txt  -oL masscan.txt
awk '{ print $4 }' masscan.txt | sort | uniq > nmap.txt
nmap --script "discovery,vulners,ftp*,ssh*,http-vuln*,mysql-vuln*,imap-,pop3-" -Pn -iL nmap.txt -oX nout.xml
xsltproc nout.xml -o nout.html
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
cd .. && mkdir urls

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
cd urls
echo "Gathering urls using gau tool"
gau $target --subs  | anew gau.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "using waybackurls"
echo "$target" | waybackurls | anew waybackurls.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "using katana"
katana -u $target -jc  -o katana.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "managing urls"
cat * | uniq | anew uniqurl.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
mkdir cetagorized-urls
cp uniqurl.txt cetagorized-urls
cd cetagorized-urls
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "cetagorizing urls:"
cat uniqurl.txt | gf api-keys | anew api-keys.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf lfi | anew lfi.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf idor | anew idor.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf rce | anew rce.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf redirect | anew redirect.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf secrets | anew secrets.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf sqli | anew sqli.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf ssrf | anew ssrf.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf ssti | anew ssti.txt
echo "-------------------------------------------------------------------------"
cat uniqurl.txt | gf xss | anew xss.txt
echo "-------------------------------------------------------------------------"
