<%@ tag language="java" pageEncoding="UTF-8"%>

<%@ attribute name="prefix" required="true" type="java.lang.String"%>

<!-- LINK FOR NAV -->
<%@ attribute name="link1" required="true" type="java.lang.String"%>
<%@ attribute name="link2" required="true" type="java.lang.String"%>

<!-- URI FOR NAV -->
<%@ attribute name="uri1" required="true" type="java.lang.String"%>
<%@ attribute name="uri2" required="true" type="java.lang.String"%>

<!-- ITEM NAME FOR NAV -->
<%@ attribute name="name1" required="true" type="java.lang.String"%>
<%@ attribute name="name2" required="true" type="java.lang.String"%>

<%@ attribute name="icon1" required="true" type="java.lang.String"%>
<%@ attribute name="icon2" required="true" type="java.lang.String"%>

<ul class="list">
	<li><a class="list__item" href="#"> <span class="icon">
				<ion-icon name="logo-apple"></ion-icon>
		</span> <span class="title">Brand Name</span>
	</a></li>
	<li><a class="list__item" data-uri="dashboard" href="${prefix}/index.htm">
			<span class="icon"> <ion-icon name="home-outline"></ion-icon>
		</span> <span class="title">Dash board</span>
	</a></li>
	<li><a class="list__item" data-uri="${uri1}" href="${prefix}/${link1}">
			<span class="icon"> <ion-icon name="${icon1}"></ion-icon>
		</span> <span class="title">${name1}</span>
	</a></li>
	<li><a class="list__item" data-uri="${uri2}" href="${prefix}/${link2}">
			<span class="icon"> <ion-icon name="${icon2}"></ion-icon>
		</span> <span class="title">${name2}</span>
	</a></li>
	<li><a class="list__item" data-uri="settings" href="settings.htm"> <span
			class="icon"> <ion-icon name="settings-outline"></ion-icon>
		</span> <span class="title">Settings</span>
	</a></li>
	<li><a class="list__item" data-uri="password" href="password.htm"> <span
			class="icon"> <ion-icon name="lock-closed-outline"></ion-icon>
		</span> <span class="title">Password</span>
	</a></li>
	<li><a class="list__item" data-uri="sign-out" href="${pageContext.request.contextPath}/logout"> <span
			class="icon"> <ion-icon name="log-out-outline"></ion-icon>
		</span> <span class="title">Sign out</span>
	</a></li>
</ul>
