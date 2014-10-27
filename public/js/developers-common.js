var DNA = {};
DNA.UI = {
	init: function() {
		// this.addEvent();
	},
	snbMenu: function() {
		if(location.pathname.startsWith('/webs-test-2014/basic/1team/envy2dj/dna/console-detail.html')) {
			console.log('test');
		}
	},
	addEvent: function() {
		$('.test_modal').click(function() {
			DNA.UI.modalPopup('.modal_g');
		});
	},
	scrollEvent: function() {
		$(document).scroll(function() {
			console.log('1');
		});
	}
};
$(document).ready(function() {
	DNA.UI.init();
	DNA.UI.snbMenu();
	// DNA.UI.scrollEvent();
});