from flask import Flask, redirect, render_template, send_file
import time
import datetime
import os

app = Flask(__name__)

dict,feedbackRecords,suggestions,connectionRecords = {},{},{},{}
retSSID,retMAC,maxNum,feedbackCounter = "","",0,0
hotspotInfo = []

hotspotWeight,connectionWeight,strengthWeight = 3.50,0.80,1.20

@app.route('/')
def index():
	return render_template('index.html')

# Algorithm

# 1. Get the number of already connected systems to current MAC
# 2. For all other options, find the max number of connections to a MAC, lesser than the current max
# 3. Assign this as the output

@app.route('/cmac=<currentMAC>&cstr=<currentStrength>&cname=<currentName>&address=<ip>&opts=<allPossibleTriplets>')
@app.route('/cmac=<currentMAC>&cstr=<currentStrength>&cname=<currentName>&address=<ip>&opts=',defaults={ "allPossibleTriplets" : "" })
def algorithm(currentMAC,currentStrength,currentName,ip,allPossibleTriplets):
	global retSSID
	global retMAC
	if ip in connectionRecords:
		for ssid in dict:
			for mac in dict[ssid]:
				if mac==connectionRecords[ip][1]: dict[ssid][mac] -= 1
	connectionRecords[ip] = [currentName,currentMAC]
	retSSID,retMAC,maxNum = "","",0
	allPossibleTriplets = allPossibleTriplets.split(',')
	values = [[],[],[]]
	for i in range(len(allPossibleTriplets)): values[i%3].append(allPossibleTriplets[i])
	# add to current dict
	if currentName in dict:
		if currentMAC in dict[currentName]: dict[currentName][currentMAC] += 1
		else: dict[currentName][currentMAC] = 1
	else:
		dict[currentName] = { currentMAC : 1 }
	# find max connections MAC
	# find max strength MAC
	noOfOptions,maxScr = len(values[2]),0
	maxScrSSID,maxScrMAC,maxScrCon,maxScrStr = "","",0,0
	for i in range(noOfOptions):
		if values[2][i] in dict and values[0][i] in dict[values[2][i]]:
			curscore = strengthWeight*float(values[1][i])-connectionWeight*(dict[values[2][i]][values[0][i]])
			if curscore > maxScr: 
				maxScrSSID,maxScrStr,maxScrCon,maxScrMAC = values[2][i],values[1][i],dict[values[2][i]][values[0][i]],values[0][i]
	# compare options with the best
	scores = [strengthWeight*(float(currentStrength)-connectionWeight*(dict[currentName][currentMAC]))/100.0,strengthWeight*(float(maxScrStr)-connectionWeight*maxScrCon)/100.0]
	if currentMAC in hotspotInfo: scores[0] *= hotspotWeight
	if maxScrMAC in hotspotInfo: scores[1] *= hotspotWeight
	maxScore,retSSID,retMAC = max(scores),currentName,currentMAC
	if maxScore==scores[1]:
		retSSID,retMAC = minConSSID,minConMAC
	suggestions[ip] = [retSSID,retMAC]
	return render_template('form.html')

@app.route('/success', methods=['POST'])
def success():
	return render_template('success.html',name=retSSID,mac=retMAC)

@app.route('/address=<ip>&accepted=<action>')
def status(ip,action):
	if action=="true" and suggestions[ip][1] != connectionRecords[ip][1]:
		for ssid in dict:
			for mac in dict[ssid]:
				if mac==connectionRecords[ip]: dict[ssid][mac] -= 1
		connectionRecords[ip] = suggestions[ip]
		if suggestions[ip][0] in dict:
			if suggestions[ip][1] in dict[suggestions[ip][0]]:
				dict[suggestions[ip][0]][suggestions[ip][1]] += 1
			else:
				dict[suggestions[ip][0]][suggestions[ip][1]] = 1
		else:
			dict[suggestions[ip][0]] = { suggestions[ip][1] : 1 }
	return render_template('index.html')

@app.route('/hotspot=<mac>')
def hotspot(mac):
	if mac not in hotspotInfo:
		hotspotInfo.append(mac)
	return render_template('index.html')

@app.route('/address=<address>&feedback=<value>')
def feedback(address,value):

	global feedbackCounter
	global feedbackRecords

	if (address not in connectionRecords) or (value not in ["true","false"]):
		return render_template('index.html')

	if address in feedbackRecords:
		if feedbackRecords[address] and value=="false":
			feedbackRecords[address] = False
			feedbackCounter -= 2
		elif not feedbackRecords[address] and value=="true":
			feedbackRecords[address] = True
			feedbackCounter += 2
	else:
		if value=="true":
			feedbackRecords[address] = True
			feedbackCounter += 1
		elif value=="false":
			feedbackRecords[address] = False
			feedbackCounter -= 1

	with open("feedback.out","a") as outputFile:
		recordTime = datetime.datetime.fromtimestamp(time.time()).strftime('%d-%m-%Y %H:%M:%S')
		outputFile.write(recordTime + " " + address + " - feedback = " + value + "\n")
		outputFile.write("Total Value: " + str(feedbackCounter) + "\n")
	return render_template('index.html')

@app.route('/downloads/<size>')
def download(size):
	if size in ["5","10","20","50","100"]:
		return send_file("data/" + size + "MB.zip",as_attachment=True)
	else:
		return render_template('404.html'), 404

if(__name__) == '__main__':
	os.system("rm feedback.out")
	app.run(debug=True, host='0.0.0.0', port=5000, threaded=True, use_reloader=False)
