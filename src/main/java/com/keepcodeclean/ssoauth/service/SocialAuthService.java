package com.keepcodeclean.ssoauth.service;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.keepcodeclean.ssoauth.entity.Account;
import com.keepcodeclean.ssoauth.entity.AllSobjects;
import com.keepcodeclean.ssoauth.entity.ObjectRecord;
import com.keepcodeclean.ssoauth.entity.ObjectResponse;

import lombok.NonNull;

@Service
public class SocialAuthService {

	@Bean
	@Primary
	public OAuth2RestTemplate oAuth2RestTemplate(OAuth2ProtectedResourceDetails resource, OAuth2ClientContext context) {
		return new OAuth2RestTemplate(resource, context);
	}

	@Autowired
	@Qualifier("oAuth2RestTemplate")
	private OAuth2RestTemplate restTemplate;

	public Map<String, String> extractUserFromAuthInfo(@NonNull Principal principal) {
		if (principal instanceof OAuth2Authentication) {
			return extractExternalUser(principal);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	private Map<String, String> extractExternalUser(@NonNull Principal principal) {
		OAuth2Authentication oAuth = (OAuth2Authentication) principal;

		Map<String, String> details = (Map<String, String>) oAuth.getUserAuthentication().getDetails();

		System.out.println("Details" + details);
		return details;
	}

	private static final String REST_VERSION = "54.0";

	@SuppressWarnings("unchecked")
	private static String restUrl(Principal principal) {
		HashMap<String, Object> details = (HashMap<String, Object>) ((OAuth2Authentication) principal)
				.getUserAuthentication().getDetails();
		HashMap<String, String> urls = (HashMap<String, String>) details.get("urls");

		return urls.get("rest").replace("{version}", REST_VERSION);
	}

	public List<Account> account(@NonNull Principal principal) {
		String url = restUrl(principal) + "query/?q={q}";

		Map<String, String> params = new HashMap<>();

		params.put("q",
				"SELECT Label, QualifiedApiName FROM EntityDefinition WHERE IsCustomizable = true and IsQueryable=true and QualifiedApiName LIKE '%__c' order by Label LIMIT 4 ");

		List<Account> acc = restTemplate.getForObject(url, QueryResultAccount.class, params).records;
		System.out.println("Objects  size:" + acc.size());
		HashMap<String, String> objectmap = new HashMap<String, String>();
		for (Account a : acc) {

			objectmap.put(a.Label, a.QualifiedApiName);

		}
		
		return acc;
	}

	public ObjectResponse objectfields(@NonNull Principal principal, String objectName) {
		String url = restUrl(principal) + "sobjects/" + objectName + "/describe/";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		ResponseEntity<ObjectResponse> acc = restTemplate.exchange(url, HttpMethod.GET, request, ObjectResponse.class);

		return (ObjectResponse) acc.getBody();
	}

	public String getObjectRecords(Principal principal, String objectName, String fieldsString) {
		String url = restUrl(principal);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		ResponseEntity<String> salesforceTestData1 = restTemplate.exchange(
				url + "query?q=SELECT FIELDS(ALL) FROM " + objectName + " LIMIT 200", HttpMethod.GET, request,
				String.class);
		// System.out.println("All Fields:" + salesforceTestData1);
		ResponseEntity<String> salesforceTestData = restTemplate.exchange(
				url + "query?q=select " + fieldsString + " from " + objectName + " ", HttpMethod.GET, request,
				String.class);

		return salesforceTestData.getBody();
	}

	public ObjectRecord getObjectRecords2(Principal principal, String objectName, String fieldsString) {
		String url = restUrl(principal);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		ResponseEntity<String> salesforceTestData1 = restTemplate.exchange(
				url + "query?q=SELECT FIELDS(ALL) FROM " + objectName + " LIMIT 200", HttpMethod.GET, request,
				String.class);
		// System.out.println("All Fields:" + salesforceTestData1);
		ResponseEntity<ObjectRecord> salesforceTestData = restTemplate.exchange(
				url + "query?q=select " + fieldsString + " from " + objectName + " ", HttpMethod.GET, request,
				ObjectRecord.class);

		return  salesforceTestData.getBody();
	}

	public OAuth2RestTemplate getRestTemplate() {
		return restTemplate;
	}

	public void setRestTemplate(OAuth2RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	@JsonIgnoreProperties(ignoreUnknown = true)
	private static class QueryResult<T> {
		public List<T> records;
	}

	private static class QueryResultAccount extends QueryResult<Account> {
	}

	
	
	public AllSobjects getSObjects(@NonNull Principal principal) {
		String url = restUrl(principal) + "sobjects/";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params,
				headers);

		ResponseEntity<AllSobjects> acc = restTemplate.exchange(url, HttpMethod.GET, request, AllSobjects.class);
		System.out.println("Sobjects :" + acc.getBody());
		return acc.getBody();
	}
	
}
