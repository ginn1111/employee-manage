$(function() {
	const formControl = window.localStorage.getItem('showDialogEdit');

	if (formControl) {
		showForm(formControl);
		window.localStorage.removeItem('showDialogEdit');
	}

	const now = new Date();
	const year = now.getFullYear();
	const month = ('0' + (now.getMonth() + 1)).slice(-2);
	const date = ('0' + now.getDate()).slice(-2);
	const hourStart = ('0' + now.getHours()).slice(-2);
	const hourEnd = ('0' + (now.getHours() + 6) % 24).slice(-2);
	const minute = ('0' + now.getMinutes()).slice(-2);

	let formSubmit;

	const formInputTimeStart = $('.form__input--time-start');
	const birthdayInputDate = $('#birthday');
	
	if(birthdayInputDate.val() === '') {
		birthdayInputDate.val(`${year-18}-${month}-${date}`);
	}

	if (formInputTimeStart.val() === '') {
		$('.form__input--time-start').val(`${hourStart}:${minute}`);
		$('.form__input--time-end').val(`${hourEnd}:${minute}`);
	}

	function showForm(suffix) {
		$('.modal')
			.find(`.form--${suffix}`)
			.css('display', 'flex');

		$('.modal').fadeIn();
		$('.backdrop').fadeIn();
	}

	function enableBtnRemove(suffix) {
		$(`.table__item--${suffix} .table__item--delete`).click(function(event) {
			event.stopPropagation();
			const parent = $(this).parent();
			parent.toggleClass('hovered');
			if ($(`.table__item--${suffix}.hovered`).length > 0) {
				$(`.btn-remove-${suffix}`).attr('disabled', false);
				parent.children('input[type="checkbox"]').attr('checked', true);
			} else {
				$(`.btn-remove-${suffix}`).attr('disabled', true);
				parent.children('input[type="checkbox"]').attr('checked', false);
			}
		});
	}
	
	function handleShowDialogEdit() {
		window.localStorage.setItem('showDialogEdit', $(this).data('control'));
	}

	enableBtnRemove('shifts');
	enableBtnRemove('positions');
	enableBtnRemove('faults');
	enableBtnRemove('tasks');
	enableBtnRemove('employees');
	enableBtnRemove('uptasks');

	$('.btn--customize.btn-add').click(function() {
		handleShowDialogEdit.call(this);
	});

	$('.btn-confirm').click(function() { });

	$('.table__item--edit').click(function() {
		handleShowDialogEdit.call($(this).parents('.table__item'));
	});

	$('.btn-remove').click(function() {
		$('.dialog').fadeIn();
		$('.backdrop').fadeIn();
		const classList = this.classList;
		const splitClassList = classList[classList.length - 1].split('-');
		formSubmit = $(`.form-${splitClassList[splitClassList.length - 1]}`)
	});

	$('.btn--warning').click(function() {
		if (formSubmit) {
			formSubmit.submit();
		}
	});
});