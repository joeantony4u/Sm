
$.fn.reverse = [].reverse;

var easings = [ 'easeInQuad', 'easeOutQuad', 'easeInCubic', 'easeOutCubic',
    			'easeInQuart', 'easeOutQuart', 'easeInQuint', 'easeOutQuint',
    			'easeInSine', 'easeOutSine', 'easeInExpo', 'easeOutExpo',
    			'easeInCirc', 'easeOutCirc', 'easeInElastic', 'easeOutElastic',
    			'easeInBack', 'easeOutBack', 'easeInBounce', 'easeOutBounce' ];
	
function easingsOn(selector, visibility, easing) {
		var elements = (visibility == 'show') ? $(selector) : $(selector)
				.reverse();
		elements.each(function(i) {
			var $de = $(this);
			setTimeout(function() {
				$de.animate({
					height : visibility
				}, 50, easing);
			}, 50 * (i + 1));
		});
}

function uniform() {
	$("select, input:text, input:checkbox, input:radio, input:file").uniform();
}	


function fresh(id) {
	$('#' + id)[0].reset();
}