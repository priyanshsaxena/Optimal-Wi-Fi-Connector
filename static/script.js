var x = document.createElement('script');
x.src = 'static/dist/sweetalert.min.js';
document.getElementsByTagName("head")[0].appendChild(x);

var limit = 4;
var started = false;

function start(num,al) {
	var s = document.getElementById('load');
	s.style.display = "block";
	if(num<limit) { 
		if(!started) {
			for(var i=1;i<limit;i++) {
				var bar = document.getElementById('progressBar' + i.toString());
				var status = document.getElementById('status' + i.toString());
				bar.value = 0;
				status.innerHTML = "";
			}
			started = true;
		}
		var bar = document.getElementById('progressBar' + num.toString());
		var status = document.getElementById('status' + num.toString());
		status.innerHTML = al + "%";
		bar.value = al;
		al++;
		var sim = setTimeout("start(" + num.toString() + "," + al + ")", num*5);
		if (al == 100) {
			status.innerHTML = "100%";
			bar.value = 100;
			clearTimeout(sim);
			start(num+1,0);
		}
	}
	else {
		started = false;
		swal("Congratulations!", "Your queries have run succesfully!", "success");
		document.getElementById('startButton').innerHTML = "<a href='bower.json' download>Download Results</a>";
		document.getElementById('load').src = "checkmark.gif";
	}
}
