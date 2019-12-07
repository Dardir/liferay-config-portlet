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

<portlet:actionURL name="deleteConfiguration" var="deleteConfiguration">
	<portlet:param name="departmentKey" value="${departmentKey}" />
</portlet:actionURL>

<portlet:renderURL var="cancelURL">
	<portlet:param name="mvcPath" value="/jsp/view.jsp" />
</portlet:renderURL>

<body>
	<aui:form id="the_from" action="<%=deleteConfiguration%>"
		enctype="multipart/form-data" method="post">
		<aui:fieldset-group markupView="lexicon">
			<div class="container-table100">
				<span class="deletelabel label-warning">Warning</span> <span
					class="warning-label"><liferay-ui:message
						key="swiftconfiguration.delete.warning" /></span>
				<aui:fieldset>
					<aui:input name='department' id='department' label="Department"
						inlineLabel="true" value="<%=departmentKey%>" disabled="true">
						<aui:validator name="required" />
					</aui:input>
					<aui:input name='sharedloc' id='sharedloc' label="Shared Location"
						inlineLabel="true" value="<%=departmentValue%>" disabled="true">
						<aui:validator name="required" />
					</aui:input>
				</aui:fieldset>
			</div>
		</aui:fieldset-group>
		<aui:button type="submit" value="Delete" cssClass="btn-info btn-save"
			icon="icon-trash" iconAlign="right" />
			<aui:button onClick="<%=cancelURL.toString()%>" value="Cancel" cssClass="btn-info btn-save"
			icon="icon-arrow-left" iconAlign="right" />
	</aui:form>


</body>