var easings = [ 'easeInQuad', 'easeOutQuad', 'easeInCubic', 'easeOutCubic',
    			'easeInQuart', 'easeOutQuart', 'easeInQuint', 'easeOutQuint',
    			'easeInSine', 'easeOutSine', 'easeInExpo', 'easeOutExpo',
    			'easeInCirc', 'easeOutCirc', 'easeInElastic', 'easeOutElastic',
    			'easeInBack', 'easeOutBack', 'easeInBounce', 'easeOutBounce' ];
    	

	$(function() {
		$('#container-4').tabs({
			fxFade : true,
			fxSpeed : 'fast'
		});

	});

	$(document).ready(function() {
		$.fn.reverse = [].reverse;
		$("#slider").easySlider({
			//auto: true,
			continuous : true
		});
		$("a", "#nextBtn").click();
		easingsOn('div.easing-visibility', 'show', easings[1]);
		$('#container img').fadeIn(3000);
	});

	function easingsOn(selector, visibility, easing) {
		var elements = visibility == 'show' ? $(selector) : $(selector)
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

	function login() {
		easingsOn('div.easing-visibility', 'hide', easings[0]);
		var bimg = $('#container img'); 
		bimg.fadeOut('slow', function() {
			bimg.attr('src', './images/progress.gif').fadeIn('slow', authenticate);
		});
	}
	
	function authenticate() {
		var bimg = $('#container img');
		Authenticate.login($('#username').val(), $('#password').val(), function(res) {
			if(res == 'failure') {
				bimg.fadeOut('slow', function() {
					bimg.attr('src', './images/puppy.gif').fadeIn('slow');
					easingsOn('div.easing-visibility', 'show', easings[1]);
					$('#login-button').html('relogin').addClass('button-err');
				}); 
				//TODO: Forward to next page
			} else {
				bimg.fadeOut('slow', function() {
					bimg.attr('src', './images/dog.gif').fadeIn('slow');
				}); 
			}
		});
	}
