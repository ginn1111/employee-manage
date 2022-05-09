<div class="toggle">
	<ion-icon name="menu-outline"></ion-icon>
</div>
<div class="time">
	<span class="time__date"> Date: 05/03/2022 </span> <span
		class="time__shift">${shiftNow.getClass().getSimpleName().equals('String') ? shiftNow : shiftNow.name}</span>
</div>
<div class="user">
	<div class="user__infor">
		<ion-icon name="person-outline"></ion-icon>
		<span class="user__role">${userInfo.fullNamePositionAndId}</span>
	</div>
	<div class="user__refesh">
		<ion-icon name="reload-outline"></ion-icon>
	</div>
</div>
