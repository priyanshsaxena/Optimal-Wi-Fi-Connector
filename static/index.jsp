<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<style>
	#footer {
	   position:absolute;
	   bottom:0;
	   width:100%;
	   height:60px;   /* Height of the footer */
	   background:#6cf;
	}
	td {
		padding:2% 2px 2% 2%;
	}
	table#innerTable {
		border:thick ridge black;
		background-color:white;
	}
	
</style>
<script>
	/* $(document).ready(function(){
	    $("button").click(function(){
	        $.ajax({url: "http://localhost:8080/ServiceHealthCheck/Test", success: function(result){
	            $("#div1").html(result);
	        }});
	    });
	    function loadDoc() {
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("demo").innerHTML =
			      this.responseText;
			    }
			  };
			  xhttp.open("GET", "http://localhost:8080/ServiceHealthCheck/ajax_info.txt", true);
			  xhttp.send();
			}
		<div id="demo">
			<h1>The XMLHttpRequest Object</h1>
			<button type="button" onclick="loadDoc()">Change Content</button>
		</div>
	}); */
	// http://localhost:8080/ServiceHealthCheck
		
		function start(service) {
			//alert(service);
			var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      //document.getElementById("text").innerHTML =
			      //this.responseText;
			      var jsonResponse = JSON.parse(this.responseText);
			      //console.log(jsonResponse.toString() + "AYE");
			      var jsonServiceInfo = jsonResponse.ServiceInfo;
			      var status = jsonServiceInfo.state;
			      var progressService = document.getElementById("progress" + service);
			      progressService.style.width="100%";
			      if(status=="STARTED")
			      	progressService.style.backgroundColor='green';
			      else if(status=="INSTALLED")
			    	progressService.style.backgroundColor='green';
			      else	
			    	progressService.style.backgroundColor='red';
			    }
			  };
			  xhttp.open("GET", "http://localhost:8080/ServiceHealthCheck/Test?service=" + service, true);
			  xhttp.send();
		}
		function createDelay() {
			//document.getElementById("progressHIVE").className += "progress-bar-animated";
			
			var hiveElement = document.getElementById("progressHIVE");
			hiveElement.className += " " + 'progress-bar-animated';
			
			var hiveHDFS = document.getElementById("progressHDFS");
			hiveHDFS.className += " " + 'progress-bar-animated';
			
			var hiveYARN = document.getElementById("progressYARN");
			hiveYARN.className += " " + 'progress-bar-animated';
			
			var hiveSPARK = document.getElementById("progressSPARK");
			hiveSPARK.className += " " + 'progress-bar-animated';
			
			var zookeeperElement = document.getElementById("progressZOOKEEPER");
			zookeeperElement.className += " " + 'progress-bar-animated';
			
			var atlasElement = document.getElementById("progressATLAS");
			atlasElement.className += " " + 'progress-bar-animated';
			
			
			
			setTimeout(startCheck, 3000);
		}
		function startCheck() {
			var serviceArray = ["YARN","HIVE","ATLAS","HDFS","SPARK","ZOOKEEPER"];
			for(i = 0; i < serviceArray.length; i++) {
				var progressService = document.getElementById("progress" + serviceArray[i]);
				start(serviceArray[i]);
			}
		}
</script>
</head>
<body bgcolor="cyan">
	<div id="text"></div>
	<table width="100%" border="0">
		<tr>
			<td bgcolor="#b5dcb3">
				<center>
					<h1>Services Health Check</h1>
				</center>
			</td>
		</tr>
		<tr valign="top" height="200">
			<td colspan="2">
				<center>
				<table border="2" width="80%" id="innerTable">
					<tr>
						<td width="30%"><B><font family="verdana" size="5">HIVE</font></B></td>
						<td>
							<center>
								<div class="progress" id="progressBar">
								  <div id = "progressHIVE" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center>
						</td>
					</tr>
					<tr>
						<td width="30%"><B><font type="verdana" size="5">HDFS</font></B></td>
						<td>
							<center>
								<div class="progress" id="progressBar">
								  <div id = "progressHDFS" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center>
						</td>
					</tr>
					<tr>
						<td width="30%"><B><font type="verdana" size="5">ATLAS</font></B></td>
						<td>
							<center>
								<div class="progress" id="progressBar">
								  <div id = "progressATLAS" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center>
						</td>
					</tr>
					<tr>
						<td width="30%"><B><font type="verdana" size="5">SPARK</font></B></td>
						<td>
							<center>
								<div class="progress" id="progressBar">
								  <div id = "progressSPARK" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center>
						</td>
					</tr>
					<tr>
						<td width="30%"><B><font type="verdana" size="5">YARN</font></B></td>
						<td>
							<center>
								<div class="progress" id="progressBar">
								  <div id = "progressYARN" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center>
						</td>
					</tr>
					<tr>
						<td width="30%"><B><font type="verdana" size="5">ZOOKEEPER</font></B></td>
						<td><center>
								<div class="progress" id="progressBar">
								  <div id = "progressZOOKEEPER" class="progressClass progress-bar progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
								</div>
							</center></td>
					</tr>
					
				</table>
				</center>
			</td>
		</tr>
		<tr>
			<td>
				<center>
					<button id="Button" type="button" class="btn btn-primary" onclick='createDelay()'>Check Health Of Services</button>
				</center>
			</td>
		</tr>
	</table>
	<footer id="id" bgcolor="#b5dcb3" style="margin-bottom:10px">
		<center>Copyright © 2007 Siemens.com</center>
	</footer>
</body>
</html>