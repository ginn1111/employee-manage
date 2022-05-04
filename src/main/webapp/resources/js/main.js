$(function() {
	function showDialog() {
		$('.backdrop').fadeIn();
		$('.modal').fadeIn();
	}
	if (window.localStorage.getItem('showDialog')) {
		showDialog();
		$(`.form__${window.localStorage.getItem('showDialog')}-emp`).css(
			'display',
			'flex'
		);
		if (window.localStorage.getItem('date')) {
			const date = window.localStorage.getItem('date')
			const idShift = window.localStorage.getItem('shift')
			$('.form__change-emp').attr('action', `manager/change-emp.htm?date=${date}&id_shift=${idShift}`)
			$('.form__evaluate-emp').attr('action', `manager/evaluation.htm?date=${date}&id_shift=${idShift}`)
			window.localStorage.removeItem('date');
			window.localStorage.removeItem('shift');
		}
		window.localStorage.removeItem('showDialog');
	}
	
	function hideModal() {
		$('.backdrop').fadeOut(function() {
			$(this).find('.form').css('display', 'none');
		});
		$('.modal').fadeOut();
		$('.dialog').fadeOut();
	}
	
	function handleGetJobViaDateAndShift() {
		$('.get-roles > input[name="id_shift"]').val($(this).data('shift'))
		$('.get-roles > input[name="date"]').val($(this).data('date'))
		$('.get-roles').submit();
	}
	
	$('.action').click(function(e) {
		const date = $(this).parents('.content').data('date');
		const idShift = $(this).parents('.content').data('shift');
		const control = $(this).data('control');
		window.localStorage.setItem('showDialog', control);
		window.localStorage.setItem('date', date);
		window.localStorage.setItem('shift', idShift);
		$('.get-roles > input[name="id_shift"]').val(idShift)
		$('.get-roles > input[name="date"]').val(date)
		$('.get-roles').attr('action', 'manager/change-emp.htm')
		$('.get-roles').submit();

		e.stopPropagation();
	});

	$('.modal').click(function(e) {
		e.stopPropagation();
	});
	
	$('.btn-cancel').click(function(e) {
		hideModal();
		e.preventDefault();
		$('.form').submit(function(e) {
			e.preventDefault();
			$('.form').unbind('submit');
		});
	});

	$('.content').click(handleGetJobViaDateAndShift)
	$('.backdrop').click(hideModal);
});
