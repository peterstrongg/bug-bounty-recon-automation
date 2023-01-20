#!/usr/bin/bash

rm -r output/* || mkdir output
mkdir output/assets_by_status

# Find subdomains given a list of wildcard domains
for url in $(cat $1)
do	
	echo -e "\n[+] Finding subdomains for $url"
	assetfinder --subs-only $url | httprobe -prefer-https | anew output/assets
done

# fff scan
echo -e "\n[+] Beginning fff scan on discovered assets"
cat output/assets | fff -S -d 5 -o output/fff_results | anew output/fff_raw

# Creates files to sort assets by http status code
python python_scripts/get_urls_by_status.py output/fff_raw

# html-tool title scan
echo -e "\n[+] Scanning title tags from each subdomain"
find . -type f -name *.body | html-tool tags title | anew output/title-tags

echo -e "\n"
for url in $(cat output/assets)
do
	echo -e "[+] Wayback search on $url"
	waybackurls $url  | anew output/.temp &
done
wait

# Removes any potential blank lines from wayback output for easier parsing
awk 'NF > 0' output/.temp | anew output/wayback_output
rm output/.temp

#comb output/assets ~/wordlists/configfiles.txt | fff -s 200 -d 1 -o output/configfiles

# strips http/https from output/assets and creates a new file named output/assets_stripped
# python python_scripts/http_strip.py

#find . -path */output/ddpwn -exec grep -Hnri "HTTP Status: 403" {} +


#dotdotpwn -m http -h peterstrong.dev > script_output/dotdotpwn

#for url in $(cat assets)
#do
#	ffuf -w ../../tools/wordlists/raft-large-directories.txt -u $url/FUZZ -recursion
#done


