var easings = [ 'easeInQuad', 'easeOutQuad', 'easeInCubic', 'easeOutCubic',
    			'easeInQuart', 'easeOutQuart', 'easeInQuint', 'easeOutQuint',
    			'easeInSine', 'easeOutSine', 'easeInExpo', 'easeOutExpo',
    			'easeInCirc', 'easeOutCirc', 'easeInElastic', 'easeOutElastic',
    			'easeInBack', 'easeOutBack', 'easeInBounce', 'easeOutBounce' ];
$.fn.reverse = [].reverse;

	$(document).ready(function() {
		easingsOn('div.easing-visibility', 'show', easings[1]);
		$('#container img').fadeIn(3000);
	});

	function easingsOn(selector, visibility, easing) {
		var elements = (visibility == 'show') ? $(selector) : $(selector)
				.reverse();
		elements.each(function(i) {
			var $de = $(this);
			setTimeout(function() {
				$de.animate({
					height : visibility
				}, 200, easing);
			}, 200 * (i + 1));
		});
	}
	
	function repaintImage(selector, withURL, callback) {
		$(selector).fadeOut('slow', function() {
			$(this).attr('src', withURL).fadeIn('slow', callback);
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
				//TODO: Forward to next page
			} else {
				repaintImage('#container img', './images/dog.gif', function() {	});
				$('#container img').remove();
				$('<div/>').attr('id', 'chart-container').appendTo($('#container'));
				plotCommonChart();
			}
		});
	}
