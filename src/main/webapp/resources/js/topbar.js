$(function () {
    $('.toggle').click(function () {
        $('.navigation').toggleClass('active');
        $('.main').toggleClass('active');
    });
    $('span.time__date').text(
        new Date().toLocaleDateString('en-US', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
        })
    );
    $('.user__refesh').click(function() {
		location.reload();
	});
});
