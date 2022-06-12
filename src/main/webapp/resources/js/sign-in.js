const hidePass = document.querySelectorAll('.toggle-password');
const showPass = document.querySelector('.toggle-password.show');
const inputPass = document.querySelector('.input-box > input[type="password"]');

let show = false;

hidePass.forEach((e) => {
    e.onclick = function () {
        hidePass.forEach((el) => {
            el.classList.toggle('show');
        });
        show = !show;
        if (show) {
            inputPass.type = 'text';
        } else {
            inputPass.type = 'password';
        }
    };
});

const placeholders = document.querySelectorAll('.input ~ span')
const inputs = document.querySelectorAll('.input')

inputs.forEach(input => {
    input.addEventListener('blur', function(e) {
        if(e.target.value) {
            this.classList.add('focus')
        } else {
            this.classList.remove('focus')
        }
    })
    if(input.value.trim().length !== 0) {
		console.log(input.value)
		this.classList.add('focus')
	}
	input.addEventListener('change', function() {
		if(this.value.trim().length !== 0) {
			this.classList.add('focus')
		}
	})
})
