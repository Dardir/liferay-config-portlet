package swift.configuration.portlet;

import swift.configuration.constants.SwiftConfigurationPortletKeys;
import swift.configuration.utilities.CSVUtils;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.PortletSession;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author mdardir
 */
@Component(immediate = true, property = { "com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.instanceable=true", "com.liferay.portlet.header-portlet-css=/css/main.css",
		"javax.portlet.init-param.template-path=/", "javax.portlet.init-param.view-template=/jsp/view.jsp",
		"javax.portlet.name=" + SwiftConfigurationPortletKeys.SwiftConfiguration,
		"javax.portlet.resource-bundle=content.Language", "javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.private-session-attributes=false" }, service = Portlet.class)
public class SwiftConfigurationPortlet extends MVCPortlet {
	private static final Log logger = LogFactoryUtil.getLog(SwiftConfigurationPortlet.class);
	private static final String FILE_LOCATION = "E:\\swift.csv";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet#doView(javax.
	 * portlet.RenderRequest, javax.portlet.RenderResponse)
	 */
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		logger.info("Inside doView of SwiftConfigurationPortlet");	
		Map<String, String> configMap = null; //= new HashMap<String, String>();
		String cvsSplitBy = ",";
		File file = new File(FILE_LOCATION);
		if (!file.exists()) {
			file.createNewFile();
		}
		
		try (BufferedReader br = Files.newBufferedReader(Paths.get(FILE_LOCATION))) {

			//br returns as stream and convert it into a Map
			configMap = br.lines().skip(1).collect(Collectors.toMap(l -> l.split(cvsSplitBy)[0], l -> l.split(cvsSplitBy)[1]));
		} 

		catch (FileNotFoundException e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		} 
		catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}

		final PortletSession portletSession = renderRequest.getPortletSession();
		portletSession.setAttribute("configMap", configMap, PortletSession.PORTLET_SCOPE);

		super.doView(renderRequest, renderResponse);
	}

	public void saveConfigs(ActionRequest request, ActionResponse response) {
		logger.info("Inside saveConfigs");
		HashMap<String, String> configMap = (HashMap<String, String>) request.getPortletSession()
				.getAttribute("configMap");
		logger.info("Starting to save config map = " + configMap);
		String csvFile = FILE_LOCATION;
		try {
			File file = new File(csvFile);
			FileWriter writer;
			if (file.exists()) {
				writer = new FileWriter(file, false);// if file exists
			} else {
				file.createNewFile();
				writer = new FileWriter(file);
			}

			CSVUtils.writeLine(writer, Arrays.asList("Department", "Shared Location"));
			for (Map.Entry<String, String> entry : configMap.entrySet()) {
				CSVUtils.writeLine(writer, Arrays.asList(entry.getKey(), entry.getValue()));
			}
			writer.flush();
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}

	public void addConfiguration(ActionRequest request, ActionResponse response) {
		logger.info("Inside addConfiguration");
		logger.info("All request params = " + request.getParameterMap());
		String department = (String) request.getParameter("department");
		String sharedloc = (String) request.getParameter("sharedloc");
		HashMap<String, String> configMap = (HashMap<String, String>) request.getPortletSession()
				.getAttribute("configMap");
		configMap.put(department, sharedloc);
		final PortletSession portletSession = request.getPortletSession();
		portletSession.removeAttribute("configMap");
		portletSession.setAttribute("configMap", configMap, PortletSession.PORTLET_SCOPE);
		response.setRenderParameter("mvcPath", "/jsp/view.jsp");
	}
	
	public void editConfiguration(ActionRequest request, ActionResponse response) {
		logger.info("Inside editConfiguration");
		String departmentKey = (String) request.getParameter("departmentKey");
		logger.info("department to be edited = "+departmentKey);
		String newDepartmentValue = (String) request.getParameter("sharedloc");
		logger.info("New department Location  = "+newDepartmentValue);
		HashMap<String, String> configMap = (HashMap<String, String>) request.getPortletSession()
				.getAttribute("configMap");
		configMap.put(departmentKey, newDepartmentValue);
		final PortletSession portletSession = request.getPortletSession();
		portletSession.removeAttribute("configMap");
		portletSession.setAttribute("configMap", configMap, PortletSession.PORTLET_SCOPE);
		response.setRenderParameter("mvcPath", "/jsp/view.jsp");
	}
	
	public void deleteConfiguration(ActionRequest request, ActionResponse response) {
		logger.info("Inside deleteConfiguration");
		String departmentKey = (String) request.getParameter("departmentKey");
		logger.info("department to be deleted = "+departmentKey);
		HashMap<String, String> configMap = (HashMap<String, String>) request.getPortletSession()
				.getAttribute("configMap");
		configMap.remove(departmentKey);
		final PortletSession portletSession = request.getPortletSession();
		portletSession.removeAttribute("configMap");
		portletSession.setAttribute("configMap", configMap, PortletSession.PORTLET_SCOPE);
		response.setRenderParameter("mvcPath", "/jsp/view.jsp");
		
	}
		
		

}