<%@ include file="/jsp/init.jsp"%>
<%@page import="javax.portlet.PortletSession"%>
<%@ page import="java.util.HashMap"%>

<portlet:actionURL name="addConfiguration" var="addConfiguration" />


<body>
	<form action="<%=addConfiguration%>" method="post">
		<c:out value="Adding new configuration form here" />
		<aui:button type="submit" value="Save" cssClass="btn-info btn-save" icon="icon-save" iconAlign="right"/>
	</form>

</body>