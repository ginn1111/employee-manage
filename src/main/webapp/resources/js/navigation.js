$(function () {
    const windowHref = window.location.pathname;
    const splitHref = windowHref.split('/');
    const suffix = splitHref[splitHref.length - 1].split('.')[0];
    $('.list__item').each(function () {
        if ($(this).data('uri') === suffix) {
            $(this).parent().addClass('hovered');
        }
    });
    if (!$('.list__item').parent().hasClass('hovered'))
        $('[data-uri=dashboard]').parent().addClass('hovered');
});
