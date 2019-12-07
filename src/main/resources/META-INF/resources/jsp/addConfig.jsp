<%@ include file="init.jsp"%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>


<portlet:actionURL name="addConfiguration" var="addConfiguration" />


<body>
	<aui:form id="the_from" action="<%=addConfiguration%>"
		enctype="multipart/form-data" method="post">
		<aui:fieldset-group markupView="lexicon">
			<div class="container-table100">
				<aui:fieldset>
					<aui:input name='department' id='department' label="Department"
						inlineLabel="true">
						<aui:validator name="required" />
					</aui:input>
					<aui:input name='sharedloc' id='sharedloc' label="Shared Location"
						inlineLabel="true">
						<aui:validator name="required" />
					</aui:input>
				</aui:fieldset>
			</div>
		</aui:fieldset-group>
		<aui:button type="submit" value="Add" cssClass="btn-info btn-save"
			icon="icon-plus" iconAlign="right" />
	</aui:form>


</body>