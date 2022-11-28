package com.payconiqproject.regressiontesting.utilities;

import static org.assertj.core.api.Assertions.assertThat;
import io.cucumber.java.en.Then;
import io.restassured.response.Response;

public class CommonRestAssertionMethods {

	private  Response response=null;

	public Response getResponse() {

		System.out.println(response.asString());

		return response;

	}

	



	@Then("^log response all$")

	public void logResponseAll() throws Throwable {

		this.getResponse().then().log().all();

	}



	@Then("^response at \"([^\"]*)\" is empty$")

	public void responseAtIsEmpty(String path) throws Throwable {

		assertThat(this.getResponse().jsonPath().getDouble(path.replace(".size()", "")+".size()")).isEqualTo(0);

	}



	@Then("^response at \"([^\"]*)\" is ((?:\\d|\\.)+)$")

	public void responseAtIs(String path, double value) throws Throwable {

		assertThat(this.getResponse().jsonPath().getDouble(path)).isEqualTo(value);

	}



	


}
