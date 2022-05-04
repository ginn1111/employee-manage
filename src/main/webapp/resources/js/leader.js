$(function () {
	if (window.localStorage.getItem('showDialogGetEmpCooperateWithLeader')) {
		showDialog();
		window.localStorage.removeItem('showDialogGetEmpCooperateWithLeader');
	}
	
    function showDialog() {
        $('.backdrop').fadeIn(function () {
            $('.form').slideDown();
        });
        $('.modal').fadeIn();
    }
    $('.modal').click(function (e) {
        e.stopPropagation();
    });

    $('.btn--task').click(function(e) {
		e.stopPropagation();
		window.localStorage.setItem('showDialogGetEmpCooperateWithLeader', 1);
	});
	
});
