package com.payconiqproject.regressiontesting_stepdefinition;

import com.payconiqproject.regressiontesting.utilities.*;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class CreateBookingStepDef extends PayconiqGenericMethods{

	@Given("Create a valid Create booking Payload using {string}, {string}, {string}, {string}, {string}, {string}, {string}")
	public void CreateBookingPayload(String firstname, String lastname, String totalprice, String depositepaid, String checkin, String checkout, String additionalneeds)
	{

		this.generateCreateBookingPayload(firstname, lastname, totalprice, depositepaid, checkin, checkout, additionalneeds);

	}

	@When("I hit Create booking End point {string} with the generated payload")

	public void tnc_maintainI_UAT_URL_hit_v3(String endpoint)

	{
		try {
			header.put(Constants.content_type_Key, Constants.content_type_Value);
			header.put(Constants.Accept_Key, Constants.Accept_Value);
			this.runPOSTAction(endpoint,payload, header);
		} catch (Exception e) {

			e.getMessage();
		}
	}
}
