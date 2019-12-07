<%@ include file="/jsp/init.jsp"%>
<%@page import="javax.portlet.PortletSession"%>
<%@ page import="java.util.HashMap"%>

<portlet:actionURL name="saveConfigs" var="saveConfigs" />
<portlet:renderURL var="addConfig">
	<portlet:param name="mvcPath" value="/jsp/addConfig.jsp" />
</portlet:renderURL>

<%
	PortletSession ps = renderRequest.getPortletSession();
	HashMap configurations = (HashMap) ps.getAttribute("configMap", PortletSession.PORTLET_SCOPE);
	pageContext.setAttribute("configurations", configurations);
%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/perfect-scrollbar/perfect-scrollbar.css">

</head>
<body>
	<form action="<%=saveConfigs%>" method="post">
		<div class="limiter">
			<div class="container-table100">
				<div class="wrap-table100">
					<div class="table100">
						<aui:button value="Add" onClick="<%=addConfig.toString()%>"
							name="addButton" cssClass="btn-info btn-save btn-add" icon="icon-plus" iconAlign="right" />
						<table>
							<thead>
								<tr class="table100-head">
									<th class="column3"><liferay-ui:message
											key="swiftconfiguration.department" /></th>
									<th class="column3"><liferay-ui:message
											key="swiftconfiguration.sharedloc" /></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="configItem" items="${configurations}">
									<tr class="row100 body">
										<td class="column3">${configItem.key}</td>
										<td class="column3">${configItem.value}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<aui:button type="submit" value="Save" cssClass="btn-info btn-save" icon="icon-save" iconAlign="right"/>
					</div>
				</div>
			</div>
		</div>

	</form>
	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="js/main.js"></script>
</body>