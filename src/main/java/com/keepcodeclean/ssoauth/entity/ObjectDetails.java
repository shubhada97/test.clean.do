package com.keepcodeclean.ssoauth.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class ObjectDetails {
	private static String fieldname;
	 
	public static List<Integer> getPopulation(String objectresult, List<String> fields) {
		Map<String,Integer>	 permap=new HashMap<String, Integer>();
		List<Integer> perlist = new ArrayList<Integer>();
		try {
			JSONObject json = new JSONObject(objectresult);
                   
			JSONArray j = json.getJSONArray("records");
			
			 int name = json.getInt("totalSize");
					 
				
			 System.out.println("size" + name);
			String array1[] = new String[j.length()];

			for (String f : fields) {
				//System.out.println(f);
				float count = 0;
				float nullcount = 0;
				float totalCount = 0;
				int percentage = 0;
				for (int i = 0; i < j.length(); i++) {

					totalCount = totalCount + 1;
					if (((json.getJSONArray("records").getJSONObject(i).get(f).equals(null) != true))
							&& (json.getJSONArray("records").getJSONObject(i).get(f).equals(false) != true)) {

						fieldname = json.getJSONArray("records").getJSONObject(i).get(f).toString();
						//System.out.println(f+"::"+fieldname);
						array1[i] = fieldname;
						count = count + 1;

					} else {
						nullcount = nullcount + 1;
					}

				}

				if (count != 0) {
					percentage = (int) ((count / totalCount) * 100);
				
				} else {
					percentage = 0;
				}
				permap.put(f, percentage);
				perlist.add(percentage);
			}
			System.out.println("Map======:"+permap);
			System.out.println("Total Size:"+permap.size());

		} catch (JSONException je) {
			System.out.println(je.getMessage());
		}
		return perlist;
	}
	public static Map<String,Integer> getPopulationMap(String objectresult, List<String> fields) {
		Map<String,Integer>	 permap=new HashMap<String, Integer>();
		List<Integer> perlist = new ArrayList<Integer>();
		try {
			JSONObject json = new JSONObject(objectresult);
                   
			JSONArray j = json.getJSONArray("records");
			
			 int name = json.getInt("totalSize");
					 
				
			 System.out.println("size" + name);
			String array1[] = new String[j.length()];

			for (String f : fields) {
				//System.out.println(f);
				float count = 0;
				float nullcount = 0;
				float totalCount = 0;
				int percentage = 0;
				for (int i = 0; i < j.length(); i++) {

					totalCount = totalCount + 1;
					if (((json.getJSONArray("records").getJSONObject(i).get(f).equals(null) != true))
							&& (json.getJSONArray("records").getJSONObject(i).get(f).equals(false) != true)) {

						fieldname = json.getJSONArray("records").getJSONObject(i).get(f).toString();
						//System.out.println(f+"::"+fieldname);
						array1[i] = fieldname;
						count = count + 1;

					} else {
						nullcount = nullcount + 1;
					}

				}

				if (count != 0) {
					percentage = (int) ((count / totalCount) * 100);
				
				} else {
					percentage = 0;
				}
				permap.put(f, percentage);
				perlist.add(percentage);
			}
			System.out.println("Map======:"+permap);
			System.out.println("Total Size:"+permap.size());

		} catch (JSONException je) {
			System.out.println(je.getMessage());
		}
		return permap;
	}

}
