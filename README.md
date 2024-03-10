This is a bash script designed to perform various tasks related to subdomain enumeration, vulnerability scanning, and information gathering on a target domain. Here's a summary of the script's main tasks:

Collect subdomains using various tools such as assetfinder, findomain, subfinder, crt.sh, and subenum.sh.
Remove duplicate subdomains and find valid ones using httpx.
Check for Heartbleed vulnerability and subdomain takeover.
Look for Header-Based-SQL-Injection and gather URLs using gau tool and waybackurls.
Use katana to crawl JavaScript files and categorize URLs based on their content.
Perform Local File Inclusion (LFI) and Open Redirect vulnerability checks.
Enumerate IP addresses associated with the target domain and perform a comprehensive Nmap scan to identify open ports and potential vulnerabilities.
Note: This script is intended for authorized penetration testing and bug bounty purposes only. It should not be used for unauthorized activities or to target systems without proper authorization. Always ensure that you have explicit permission from the system owner before conducting any security testing activities.

# cyberpunk
##Installation
sudo git clone https://github.com/muhamma-ibrahim/cyberpunk.git
cd cyberpunk
chmod +777 install.sh
sudo ./install.sh
chmod +777 cyberpunk.sh
##Run 
sudo ./cyberpunk.sh
