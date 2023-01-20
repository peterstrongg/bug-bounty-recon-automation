import os
import sys
import subprocess


if __name__ == "__main__":
	domain_list = open(sys.argv[1], 'r')
	
	domains = []
	for d in domain_list.readlines():
		domains.append(d.strip())
	domain_list.close()
	
	# assetfinder and httprobe scan
	for domain in domains:	
		subprocess.call("assetfinder --subs-only %s | httprobe -prefer-https | anew assets" % domain, 	shell=True)
			
	subprocess.call("cat assets | fff -S -o script_output/fff_results")
		
			
