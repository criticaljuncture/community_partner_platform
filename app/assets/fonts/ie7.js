/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referring to this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'community_partner_platform\'">' + entity + '</span>' + html;
	}
	var icons = {
		'icon-cpp-close-x-inv': '&#xe607;',
		'icon-cpp-users': '&#xe606;',
		'icon-cpp-small-business': '&#xe600;',
		'icon-cpp-school': '&#xe601;',
		'icon-cpp-handshake': '&#xe602;',
		'icon-cpp-graph': '&#xe603;',
		'icon-cpp-gears': '&#xe604;',
		'icon-cpp-close-x': '&#xe605;',
		'0': 0
		},
		els = document.getElementsByTagName('*'),
		i, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		c = el.className;
		c = c.match(/icon-cpp-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
}());
