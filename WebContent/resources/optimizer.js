function loadAsyncScripts(asyncScripts) {
	var head = document.getElementsByTagName("head")[0];
	for(as in asyncScripts) {
		var script = document.createElement("script");
		script.setAttribute("src", asyncScripts[as]);
		head.appendChild(script);
	}
}
