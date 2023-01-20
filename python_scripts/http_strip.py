with open('output/assets', 'r') as f:
	stripped_domains = []
	for d in f.readlines():
		url = d.strip()
		if url[:7] == 'http://':
			stripped_domains.append(url[7:])
		elif url[:8] == 'https://':
			stripped_domains.append(url[8:])
	
	open('output/assets_stripped', 'w').close()
	f = open('output/assets_stripped', 'w')	
	for d in stripped_domains:
		f.write(d + '\n')
