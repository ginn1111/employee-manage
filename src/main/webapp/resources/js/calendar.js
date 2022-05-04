$(function() {
	const SHIFTS = $('.shifts-register')
		.not('.shifts-register--read')
		.find('.register__body').length;
	const WEEK_OF_MON = $('.shifts-register').not(
		'.shifts-register--read'
	).length;

	function getTimeTable() {
		return [...Array(WEEK_OF_MON)].map((_, week) => {
			return [...Array(SHIFTS)].map((_, shift) => {
				return [...Array(7)].map((_, date) =>
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
						).addClass('checked');

					} else {
						$(
							`.shifts-register--${week + 2} .body__container--${shift + 1
							} > .body__check:nth-child(${date + 2})`
						).removeClass('checked');
					}
				});
			});
		});
	}
	function handleGetTimeTable() {
		/*console.log(
			JSON.stringify(getTimeTableOfEmp()))*/
		/*JSON.stringify(getTimeTable().reduce((timeTable, week, i) => {
				return {
					...timeTable,
					[`week${i + 1}`]: week.reduce((weekTimeTable, shift, j) => ({ ...weekTimeTable, [`shift${j + 1}`]: shift }), {})
				}
			}, {}))*/
		$.ajax({
			url: `http://${window.location.host}/QLNV_QTS/employee/get-timetable.htm`,
			type: 'POST',
			dataType: 'json',
			contentType: 'application/json',
			data: JSON.stringify(getTimeTableOfEmp())
		})
			.done(function(response) {
				location.reload();
			})
			.fail(function(e) {
				location.reload();
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
	function getTimeTableOfEmp() {
		let timeTable = [];
		$('.shifts-register:not(.shifts-register--read):not(.assignment) .body__check.checked').each(function() {
			timeTable.push({ shift: `${$(this).data('shift')}`, date: `${$(this).data('date')}` });
		});
		return { dateShifts: timeTable, idEmployee: 'NV02' }
		
	}
	if(window.localStorage.getItem('is_all') == 1) {
		checkAll();
	} else {
		check();
	}
	function check() {
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
	}
	
	// for all-day emp
	function checkAll() {
		$('.body__check').click(function() {
			const week = $(this).parents('.shifts-register').attr('class').split(' ')[1];
			const index = $(this).index()
			if($(`.${week} .body__container .body__check:nth-child(${index+1}):not('.disabled')`).length == 3)
				$(`.${week} .body__container .body__check:nth-child(${index+1})`).toggleClass('checked')
			else {
				$('body').append(
				`<div class="backdrop" style="display: block;">
					<dialog class="modal" style="display: block;">
						<span>Register is not valid</span>
					</dialog>
				</div>`
			)
			setTimeout(function(){
				$('.backdrop').fadeOut(function() {
					$('body').find('.backdrop').remove();
				})
			}, 1000)
			}
		});
	}
	
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
	/*$('.get-time-table').click(handleGetTimeTable);*/
});
