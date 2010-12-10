
$.fn.reverse = [].reverse;

var easings = [ 'easeInQuad', 'easeOutQuad', 'easeInCubic', 'easeOutCubic',
    			'easeInQuart', 'easeOutQuart', 'easeInQuint', 'easeOutQuint',
    			'easeInSine', 'easeOutSine', 'easeInExpo', 'easeOutExpo',
    			'easeInCirc', 'easeOutCirc', 'easeInElastic', 'easeOutElastic',
    			'easeInBack', 'easeOutBack', 'easeInBounce', 'easeOutBounce' ];
	
function easingsOn(selector, visibility, easing) {
		var elements = (visibility == 'show') ? $(selector) : ($(selector)
				.reverse());
		elements.each(function(i) {
			var $de = $(this);
			setTimeout(function() {
				$de.animate({
					height : visibility
				}, 50, easing);
			}, 50 * (i + 1));
		});
}

function changeDisplay(selector, visibility) {
	var elements = (visibility == 'inline' || visibility == 'block') ? $(selector) : ($(selector)
			.reverse());
	elements.each(function(i) {
		var $de = $(this);
		setTimeout(function() {
			$de.css('display', visibility);
		}, 50 * (i + 1));
	});
}


function uniform() {
	$("select, input:text, input:checkbox, input:radio, input:file").uniform();
}	


function fresh(id) {
	$('#' + id)[0].reset();
}

var infoBar;
function pageInit(id) {
	uniform();
	infoBar = $(parent.document).find('#' + id+  ' .evidence').hide();
}

function acknowledge(cn, stat, type) {
	$('<a class="awesome no-border"/>').addClass(cn).html(stat.split(':')[1])
	.appendTo(infoBar.html(type));
	infoBar.show('slow');
	setTimeout(function() { infoBar.hide('slow'); }, 5000);
}

function detectAndDoClassName(stat, pageId) {
	if(isError(stat)) { 
		return "red";				
	} else if(isSuccess(stat)) {
		if(pageId)
			fresh(pageId);
		return "blue";		
	}
	
}

function detectAndDoType(stat, info, pageId) {
	if(isError(stat)) {
		return "Error.";
	} else if(isSuccess(stat)) {
		if(pageId)
			fresh(pageId);
		return info ? info : "Success.";
	}
}

function isError(stat) {
	return stat.substr(0, "E:".length) === "E:";
}

function isSuccess(stat) {
	return stat.substr(0, "S:".length) === "S:";
}

function preAjax(page) {
	page.find('a').hide();
	page.addClass('transparency-20');
}

function postAjax(page) {
	page.removeClass('transparency-20');
	page.find('a').show();
}

