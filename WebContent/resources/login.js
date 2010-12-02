var asyncScripts = ['./resources/highcharts.js', './resources/common-chart.js', 
                    './resources/jquery.easing.js', './resources/cookie.js',
                    'dwr/interface/MenuBuilder.js'];
	$(document).ready(function() {
		//alert('ccallinf');
		var head = $('head');
		$.each(asyncScripts, function(i) {
			$('<script/>').attr('src', this).appendTo(head);
		});
		
		Authenticate.getAuth(function(auth) {
			//alert(auth);
			if(auth) {
				showDashboard();
			} else {
				easingsOn('div.easing-visibility', 'show', easings[1]);
				$('#container img').fadeIn(3000);
			}
		});
	});

	function repaintImage(selector, withURL, callback) {
		$(selector).fadeOut('fast', function() {
			$(this).attr('src', withURL).fadeIn('fast', callback);
		});
	}

	function preLogin() {
		easingsOn('div.easing-visibility', 'hide', easings[0]);
		repaintImage('#container img', './images/progress.gif', authenticate);
	}
	
	function authenticate() {
		Authenticate.login($('#username').val(), $('#password').val(), function(res) {
			if(res == 'failure') {
				repaintImage('#container img', './images/puppy.gif', function() {
					easingsOn('div.easing-visibility', 'show', easings[1]);
					$('#login-button').html('relogin').addClass('button-err');
				});
			} else {
				showDashboard();
			}
		});
	}

	//TODO: Security against geeks opening this source at client agents?
	function showDashboard() {
		repaintImage('#container img', './images/dog.gif', function() {	});
		$('#container img').remove();
		//TODO:cleanup after this part
		$('<div/>').attr('id', 'chart-container').appendTo($('#container'));
		$('<div/>').addClass('chart-options').attr('id', 'chart-options-container').appendTo($('#center'));
		
		var chartparent = $('#chart-options-container');
		addChartOptions([
		                 {
		                	 src : './images/column-chart.png',
		                	 type : 'column',
		                	 parent : chartparent
		                 }, {
		                	 src : './images/chart-line.png',
		                	 type : 'line',
		                	 parent : chartparent
		                 },{
		                	 src : './images/chart-bar.png',
		                	 type : 'bar',
		                	 parent : chartparent
		                 }, {
		                	 src : './images/chart-area.png',
		                	 type : 'area',
		                	 parent : chartparent
		                 }, {
		                	 src : './images/chart-pie.png',
		                	 type : 'pie',
		                	 parent : chartparent
		                 }]);
		var sPref = readCookie('sm-dash-chart');
		sPref = (sPref == null ? 'column' : sPref);
		plotCommonChart( sPref );
		writeCookie('sm-dash-chart', sPref, 1);
		$('<a/>').html("Workspace").attr('href', "services.htm").appendTo($('<li/>').appendTo('#menu'));
	}
	
	function addChartOptions(options) {
		$.each(options, function(i, map) {
			$('<img/>').attr('src', map.src)
			.attr('charttype', map.type)
			.addClass('chart-option-icon')
			.click(function() { 
				plotCommonChart($(this).attr('charttype'));
				writeCookie('sm-dash-chart', $(this).attr('charttype'), 1);
			}).appendTo(map.parent);
		});
	}
