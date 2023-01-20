import sys

f = open(sys.argv[1], 'r')
urls = f.readlines()
url_dict = {}

for url in urls:
	url_dict[url.strip().split()[1]] = url.strip().split()[2]
	
f.close()
	
for key, value in url_dict.items():
	fname = "output/assets_by_status/" + url_dict[key]
	f = open(fname, 'a')
	f.write(key + "\n")
	
f.close()
	
