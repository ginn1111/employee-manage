$(function() {
	const SHIFTS = $('.shifts-register')
		.not('.shifts-register--read')
		.find('.register__body').length;
	const WEEK_OF_MON = $('.shifts-register').not(
		'.shifts-register--read'
	).length;

	const DAY_OF_WEEK = 7;

	function getTimeTable() {
		return [...Array(WEEK_OF_MON)].map((_, week) => {
			return [...Array(SHIFTS)].map((_, shift) => {
				return [...Array(DAY_OF_WEEK)].map((_, date) =>
					$(
						`.shifts-register--${week + 1} .body__container--${shift + 1
						} > .body__check:nth-child(${date + 2})`
					).hasClass('checked')
				);
			});
		});
	}

	function handleApplyForAll(e) {
		e.preventDefault();
		const timeTable = getTimeTable()[0];
		if(timeTable.flat().every(e => e === false))
			return;
		[...Array(WEEK_OF_MON - 1)].forEach((_, week) => {
			timeTable.forEach((shiftChecked, shift) => {
				shiftChecked.forEach((checked, date) => {
					if (checked) {
						$(
							`.shifts-register--${week + 2} .body__container--${shift + 1
							} > .body__check:nth-child(${date + 2}):not(.disabled)`
						).addClass('checked').find('input[type="checkbox"]').prop('checked', true);
					} else {
						$(
							`.shifts-register--${week + 2} .body__container--${shift + 1
							} > .body__check:nth-child(${date + 2})`
						).removeClass('checked').find('input[type="checkbox"]').prop('checked', false);
					}
				});
			});
		});
	}
	function handleResetTimeTable() {
		let bodyCheck;
		$('.shifts-register').each(function() {
			bodyCheck = $(this)
				.not('.shifts-register--read')
				.not('.assignment')
				.find('.body__container > .body__check');
			bodyCheck.removeClass('checked');
			bodyCheck.find('input[type="checkbox"]').prop('checked', false);
				
		});
		handleToggleControl(true);
	}
	
	(function check() {
		let isChecked;
		let checkbox;
		$('.body__check').click(function() {
			if($(this).parents('.shifts-register').not('.assignment').length !== 0) {
				checkbox = $(this).find('input[type="checkbox"]');
				isChecked = checkbox.is(':checked');
				
				$(this).toggleClass('checked');
				$(this).find('input[type="checkbox"]').prop('checked', !isChecked);
			}
				
		});
	})()
	
	function handleToggleControl(toggle) {
			$('.reset-time-table').attr('disabled', toggle);
			$('.apply-for-all').attr('disabled', toggle);
			$('.get-time-table').attr('disabled', toggle);
	}
	
	function enableControl () {
		if($(`.shifts-register:not('.shifts-register--read'):not('.assignment') .body__check.checked`).length > 0) {
			handleToggleControl(false);
		} else {
			handleToggleControl(true);
		}
	}
	
	$('.body__check').click(enableControl);
	$('.reset-time-table').click(handleResetTimeTable);
	$('.apply-for-all').click(handleApplyForAll);
});
