package stepDef;


import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import com.google.gson.Gson;
import com.payconiqproject.regressiontesting.pojo.classes.CreateBooking.BookingDates;
import com.payconiqproject.regressiontesting.pojo.classes.CreateBooking.CreateBooking_Payload;
import com.payconiqproject.regressiontesting.utilities.Constants;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;


public class CreateBookingStepDef{
	public  Response response=null;
	public String payload = null;
	public Map<String,String> header= new HashMap<String,String>();
	CreateBooking_Payload cb_Payload = new CreateBooking_Payload();
	BookingDates bd = new BookingDates();

	String actualusername = null;
	String actualpassword = null;

	public void generateCreateBookingPayload(String firstname, String lastname, int totalprice, String depositepaid, String checkin, String checkout, String additionalneeds) throws ParseException
	{
		boolean depositpaid_bool = Boolean.parseBoolean(depositepaid);

		cb_Payload.setFirstname(firstname);
		cb_Payload.setLasttname(lastname);
		cb_Payload.setTotalprice(totalprice);
		cb_Payload.setDepositpaid(depositpaid_bool);
		bd.setCheckin(checkin);
		bd.setCheckout(checkout);
		cb_Payload.setBookingdates(bd);
		cb_Payload.setAdditionalneeds(additionalneeds);

		payload = new Gson().toJson(cb_Payload);

		System.out.println(payload);

	}

	public String getValueFromPropFile(String key) throws IOException
	{
		FileReader reader=new FileReader("vaultConfig.properties");
		Properties p=new Properties();
		p.load(reader);
		String value = p.getProperty(key);
		return value;
	}

	public Response runPOSTAction(String url,String jsonBody,Map<String,String> header) {
		System.out.println(jsonBody);
		try {
			response = RestAssured
					.given()
					.baseUri(url)
					.auth()
 				.basic("admin", "password123")
					.contentType(Constants.Content_Type_Value)
					.accept(Constants.Accept_Value)
					.body(jsonBody)
					.when()
					.post()
					.then()
					.assertThat().statusCode(200).log().all()
					.extract().response();
			System.out.println(response.asString());
			Thread.sleep(2000);
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}

	@Given("Create a valid Create booking Payload using {string}, {string}, {int}, {string}, {string}, {string}, {string}")

	public void CreateBookingPayload(String firstname, String lastname, int totalprice, String depositepaid, String checkin, String checkout, String additionalneeds) throws ParseException
	{
		this.generateCreateBookingPayload(firstname, lastname, totalprice, depositepaid, checkin, checkout, additionalneeds);
	}
	
	@When("I hit Create booking End point {string} with the generated payload")
	public void tnc_maintainI_UAT_URL_hit_v3(String endpoint)
	{
		try {
			header.put(Constants.Content_Type_Key, Constants.Content_Type_Value);
			header.put(Constants.Accept_Key, Constants.Accept_Value);
			this.runPOSTAction(endpoint,payload, header);
		} catch (Exception e) {
			e.getMessage();
		}
	}
}
