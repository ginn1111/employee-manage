<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="message" required="true" type="java.lang.String"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:if test="${message.length() != 0 && message != null}">
	<div class="backdrop" style="display: block;">
		<dialog class="modal" style="display: block;">
		<h5 class="dialog__title">Notice!</h5>
		<span class="dialog__message">${message}</span>
		<div style="justify-content: flex-end; margin-left: auto"
			class="form__item--action">
			<button class="btn-cancel btn--customize">OK</button>
		</div>
		</dialog>
	</div>
</c:if>