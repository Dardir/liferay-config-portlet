<%@ include file="init.jsp"%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@page import="javax.portlet.PortletSession"%>
<%@ page import="java.util.HashMap"%>

<%
	String departmentKey = renderRequest.getParameter("idConfig");
	pageContext.setAttribute("departmentKey", departmentKey);
	PortletSession ps = renderRequest.getPortletSession();
	HashMap configurations = (HashMap) ps.getAttribute("configMap", PortletSession.PORTLET_SCOPE);
	String departmentValue = (String) configurations.get(departmentKey);
	pageContext.setAttribute("departmentValue", departmentValue);
%>

<portlet:actionURL name="editConfiguration" var="editConfiguration">
	<portlet:param name="departmentKey" value="${departmentKey}" />
	<portlet:param name="departmentValue" value="${departmentValue}" />
</portlet:actionURL>



<body>
	<aui:form id="the_from" action="<%=editConfiguration%>"
		enctype="multipart/form-data" method="post">
		<aui:fieldset-group markupView="lexicon">
			<div class="container-table100">
				<aui:fieldset>
					<aui:input name='department' id='department' label="Department"
						inlineLabel="true" value="<%=departmentKey%>" disabled="true">
						<aui:validator name="required" />
					</aui:input>
					<aui:input name='sharedloc' id='sharedloc' label="Shared Location"
						inlineLabel="true" value="<%=departmentValue%>">
						<aui:validator name="required" />
					</aui:input>
				</aui:fieldset>
			</div>
		</aui:fieldset-group>
		<aui:button type="submit" value="Edit" cssClass="btn-info btn-save"
			icon="icon-edit" iconAlign="right" />
	</aui:form>


</body>