package com.keepcodeclean.ssoauth.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.IntSummaryStatistics;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.keepcodeclean.ssoauth.entity.Account;
import com.keepcodeclean.ssoauth.entity.Fields;
import com.keepcodeclean.ssoauth.entity.ObjectDetails;
import com.keepcodeclean.ssoauth.entity.ObjectResponse;
import com.keepcodeclean.ssoauth.service.SocialAuthService;

@Controller
public class HomeController {

	@Autowired
	private SocialAuthService authService;
	

	@RequestMapping(value = "/test")
	public String home(Principal principal, Model model) {
		Map<String, String> user = authService.extractUserFromAuthInfo(principal);

		model.addAttribute("user", user);

		return "home";
	}

	@RequestMapping(value = "/login")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView("loginpage");
		return mv;
	}

	@RequestMapping(value = "/dash")
	public ModelAndView loginpage() {
		ModelAndView mv = new ModelAndView("dashboard");
		return mv;

	}

	


	
	@RequestMapping(value = "/")
	public ModelAndView account(Principal principal, Model model) {
		Map<String, String> user = authService.extractUserFromAuthInfo(principal);
		//AllSobjects sobject=authService.getSObjects(principal);
		//System.out.println(sobject);
		//List<Sobjects> objectList=sobject.getSobjects();
		//System.out.println("Rest APi Sobject:"+objectList.size());
		//List<Sobjects> finalList=new ArrayList<Sobjects>();
	//	for (Sobjects s : objectList) {

		//if(s.isTriggerable())
		//{
		//	finalList.add(s);
		////}
		//}
		//System.out.println("Final List:"+finalList.size());

		
		
		
		
		
		
		
		
		
		List<Account> response = authService.account(principal);
		System.out.println("Object size:"+response.size());
		Map<String, Map<String, String>> FinalFields = new HashMap<String, Map<String, String>>();
		Map<String, Map<String, Integer>> MapObject = new HashMap<String, Map<String, Integer>>();
		HashMap<String, String> objectmap = new HashMap<String, String>();
		for (Account a : response) {

			objectmap.put(a.Label, a.QualifiedApiName);

		}

		model.addAttribute("user", user);
		model.addAttribute("allObjects", objectmap);
		model.addAttribute("size", objectmap.size());

		int objectcount = 0;
		int totalfields = 0;
		String objectresult = "";
		Map<String, Integer> percentageMap = new HashMap<String, Integer>();
		Map<String,Integer> MapFinal = new  HashMap<String, Integer>();
		List<Integer> percentagelist1 = new ArrayList<Integer>();
		for (Map.Entry e : objectmap.entrySet()) {
			ObjectResponse objectResponse = authService.objectfields(principal, e.getValue().toString());
			System.out.println(objectResponse);
			List<Fields> fields = objectResponse.getFields();

			System.out.println("Fields:" + fields);

			List<String> fieldsAll = new ArrayList<String>();
			List<String> fieldsAll2 = new ArrayList<String>();
			HashMap<String, String> fieldMap = new HashMap<String, String>();

			for (Fields f : fields) {
				if (f.isCreateable()) {
					fieldsAll.add(f.getName());
					fieldsAll2.add(f.getLabel());
					totalfields = totalfields + 1;
					fieldMap.put(f.getName(), f.getType());
					
				}

			}

			String fieldsString = String.join(",", fieldsAll);
			FinalFields.put(objectResponse.getName(), fieldMap);
			System.out.println("FieldMap:" + fieldMap);
			System.out.println("Final Fields:"+FinalFields);
			if (fieldsAll.size() != 0) {
				objectresult = authService.getObjectRecords(principal, e.getValue().toString(), fieldsString);

			}

			List<Integer> perList= ObjectDetails.getPopulation(objectresult, fieldsAll);
			Map<String,Integer> perMap= ObjectDetails.getPopulationMap(objectresult, fieldsAll);
			MapObject.put((String) e.getValue(),perMap);
           
			System.out.println(objectcount + " : " + e.getValue() + " Percentage: " + perList);
			IntSummaryStatistics iss = perList.stream().mapToInt((a) -> a).summaryStatistics();
			 System.out.println("The average of the percentage is: " + iss.getAverage());
			percentageMap.put(e.getValue().toString(), (int) iss.getAverage());
			percentagelist1.add((int) iss.getAverage());
		//themodel.addAttribute("objectName", objectName);
			model.addAttribute("fields", FinalFields);
			//model.addAttribute("result", perList);
			objectcount = objectcount + 1;

		}
		System.out.println("Total Number of objects:" + objectcount);
		System.out.println("Total Number of fields:" + totalfields);
		System.out.println("Avg % of each object:" + percentageMap);

		System.out.println("All Fields MapObject:" +MapObject+"  Size:"+MapObject.size());
		IntSummaryStatistics iss = percentagelist1.stream().mapToInt((a) -> a).summaryStatistics();
		// System.out.println("The average of the percentage is: " + iss.getAverage());

		int Overallpercentage = (int) iss.getAverage();

		System.out.println("overallPercentage" + Overallpercentage);
		model.addAttribute("result", percentageMap);
		model.addAttribute("ObjectCount", objectcount);
		model.addAttribute("FieldCount", totalfields);
		model.addAttribute("MapObject",MapObject);
		System.out.println("MapObject:"+MapObject.get("Account"));

		model.addAttribute("overallPercentage", Overallpercentage);
		ModelAndView mv = new ModelAndView("dashboard2");
		return mv;

	}

	@RequestMapping(value = "/objectdetails", method = RequestMethod.GET, params = { "objectName" })
	public ModelAndView getFieldsData(@RequestParam(value = "objectName", required = true) String objectName,
			Model themodel, OAuth2Authentication principal) {
		Map<String, String> user = authService.extractUserFromAuthInfo(principal);
		ObjectResponse objectResponse = authService.objectfields(principal, objectName);
		// System.out.println(objectResponse);
		List<Fields> fields = objectResponse.getFields();
		List<String> fieldsAll = new ArrayList<String>();
		HashMap<String, String> fieldMap = new HashMap<String, String>();
		for (Fields f : fields) {

			fieldsAll.add(f.getName());
			fieldMap.put(f.getLabel(), f.getType());

		}

		String fieldsString = String.join(",", fieldsAll);

		String objectresult = authService.getObjectRecords(principal, objectName, fieldsString);

		List<Integer> perList = ObjectDetails.getPopulation(objectresult, fieldsAll);

		themodel.addAttribute("objectName", objectName);
		themodel.addAttribute("fields", fieldMap);
		themodel.addAttribute("percentage", perList);
		themodel.addAttribute("user", user);
		ModelAndView mv = new ModelAndView("object-details");

		return mv;

	}

}
