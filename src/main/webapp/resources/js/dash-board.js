const detailHeader = document.querySelector('.details__header');
const listDetail = document.querySelector('.list__detail');
const contents = document.querySelectorAll('.content');
const searchInput = document.querySelector('.search-box > input');
const iconSearch = document.querySelector('.search__icon');
const searchBox = document.querySelector('.search-box');

contents.forEach((e) => {
    e.onclick = function () {
        detailHeader.classList.remove('not-have');
        listDetail.classList.remove('hide');
    };
});

if(searchInput) {
	searchInput.onfocus = () => {
	    iconSearch.style.color = 'lightblue';
	    searchBox.style.borderColor = 'lightblue';
	};
}

if(searchBox) {
	searchBox.style.color = 'lightblue';
	searchInput.onblur = () => {
	    iconSearch.style.color = '#e3e3e3';
	    searchBox.style.borderColor = '#e3e3e3';
	};
	
	$('.search-box > input').keydown(function(event) {
		const data = $(this).val().trim();
		if(event.which === 13) {
			$('.get-roles').html(`<input type="hidden" name="data" value="${data}" />`);
			$('.get-roles').attr('action',`manager/search.htm`);
			$('.get-roles').submit();
		} 
	})

}