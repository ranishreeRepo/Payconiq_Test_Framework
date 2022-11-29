package stepDef;


import static org.assertj.core.api.Assertions.assertThat;

import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import com.google.gson.Gson;
import com.payconiq.qa.regressiontesting.pojo.classes.CreateBooking.BookingDates;
import com.payconiq.qa.regressiontesting.pojo.classes.CreateBooking.CreateBooking_Payload;
import com.payconiq.qa.regressiontesting.pojo.classes.CreateBooking.GetToken_Payload;
import com.payconiq.qa.regressiontesting.pojo.classes.CreateBooking.PartialUpdateBooking_Payload;
import com.payconiqproject.regressiontesting.utilities.Constants;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;


public class BookingStepDef{
	public  Response response=null;
	public String payload = null;
	public Map<String,String> header= new HashMap<String,String>();
	
	CreateBooking_Payload cb_Payload = new CreateBooking_Payload();
	PartialUpdateBooking_Payload pub_Payload = new PartialUpdateBooking_Payload();
	GetToken_Payload getToken = new GetToken_Payload();
	BookingDates bd = new BookingDates();
	public String token = null;
	String actualusername = null;
	String actualpassword = null;
	public String bookingId = null;
	

	public void generateCreateBookingPayload(String firstname, String lastname, int totalprice, String depositepaid, String checkin, String checkout, String additionalneeds) throws ParseException
	{
		boolean depositpaid_bool = Boolean.parseBoolean(depositepaid);

		cb_Payload.setFirstname(firstname);
		cb_Payload.setLastname(lastname);
		cb_Payload.setTotalprice(totalprice);
		cb_Payload.setDepositpaid(depositpaid_bool);
		bd.setCheckin(checkin);
		bd.setCheckout(checkout);
		cb_Payload.setBookingdates(bd);
		cb_Payload.setAdditionalneeds(additionalneeds);

		payload = new Gson().toJson(cb_Payload);

		System.out.println(payload);

	}
	
	public void generatePartialUpdateBookingPayload(String firstname, String lastname) throws ParseException
	{

		pub_Payload.setFirstname(firstname);
		pub_Payload.setLastname(lastname);

		payload = new Gson().toJson(pub_Payload);

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
					.assertThat().log().all()
					.extract().response();
			System.out.println(response.asString());
			Thread.sleep(2000);
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response runPATCHActionForParitalUpdate(String url,String jsonBody,Map<String,String> header) {
		System.out.println(jsonBody);
		try {
			response = RestAssured
					.given()
					.baseUri(url)
					.headers(header)
					.contentType(Constants.Content_Type_Value)
					.accept(Constants.Accept_Value)
					.body(jsonBody)
					.when()
					.patch()
					.then()
					.assertThat().log().all()
					.extract().response();
			System.out.println(response.asString());
			Thread.sleep(2000);
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response runPUTActionForUpdate(String url,String jsonBody,Map<String,String> header) {
		System.out.println(jsonBody);
		try {
			response = RestAssured
					.given()
					.baseUri(url)
					.headers(header)
					.contentType(Constants.Content_Type_Value)
					.accept(Constants.Accept_Value)
					.body(jsonBody)
					.when()
					.put()
					.then()
					.assertThat().log().all()
					.extract().response();
			System.out.println(response.asString());
			Thread.sleep(2000);
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response runGETAction(String URL) {
		try {
			response = RestAssured
					.given()
					.baseUri(URL)
					.accept(Constants.Accept_Value)
					.when()
					.get()
					.then()
					.assertThat().log().all()
					.extract().response();
			System.out.println(response.asString());
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response runGETActionForPing(String URL) {
		try {
			response = RestAssured
					.given()
					.baseUri(URL)
					.when()
					.get()
					.then()
					.assertThat().statusCode(201)
					.extract().response();
			System.out.println(response.asString());
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response runDELETEAction(String URL,Map<String,String> header) {
		try {
			response = RestAssured
					.given()
					.baseUri(URL)
					.headers(header)
					.contentType(Constants.Content_Type_Value)
					.when()
					.delete()
					.then()
					.assertThat().statusCode(201).log().all()
					.extract().response();
			System.out.println(response.asString());
			Thread.sleep(2000);
		} catch (Exception e) {
			e.getMessage();
		}return response;
	}
	
	public Response getToken(String username, String password, String oAuthEndPoint, String payload)
	{
		response = RestAssured
		.given()
		.baseUri(oAuthEndPoint)
		.contentType(Constants.Content_Type_Value)
		.body(payload)
		.when()
		.post()
		.then()
		.assertThat()
		.extract().response();
		return response;
	}
	
	@Then("extract and save token")
	public String saveToken()
	{
		token = response.then().extract().path("token").toString();
		return token;
	}
	
	@Given("Create a valid Create booking Payload using {string}, {string}, {int}, {string}, {string}, {string}, {string}")
	public void CreateBookingPayload(String firstname, String lastname, int totalprice, String depositepaid, String checkin, String checkout, String additionalneeds) throws ParseException
	{
		this.generateCreateBookingPayload(firstname, lastname, totalprice, depositepaid, checkin, checkout, additionalneeds);
	}
	
	@When("I hit Create booking End point {string} with the generated payload")
	public void hitCreateBookingAPI(String endpoint)
	{
		try {
			header.put(Constants.Content_Type_Key, Constants.Content_Type_Value);
			header.put(Constants.Accept_Key, Constants.Accept_Value);
			this.runPOSTAction(endpoint,payload, header);
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	@Then("Save bookingid for furthur usecase from {string}")
	public String saveBookingId(String bookingIdPath)
	{
		bookingId = this.response.jsonPath().getString(bookingIdPath);
		return bookingId;
	}
	
	@Given ("Create a valid Auth Payload using {string}, {string} by hitting {string}")
	public void createToken(String username, String password, String oAuthEndPoint)
	{
		getToken.setUsername(username);
		getToken.setPassword(password);
		payload = new Gson().toJson(getToken);
		System.out.println(payload);
		
		this.getToken(username,password, oAuthEndPoint, payload);
	}
	
	@Given("Hit a GET request for GetBookingById using {string}")
	public void hitGetBookingByIdAPI(String URL)
	{
		this.runGETAction(URL);
	}
	
	@Given("Hit a GET request for GetBooking using {string}")
	public void hitGetBookingAPI(String URL)
	{
		String appended_ID_URL = URL+bookingId;
		this.runGETAction(appended_ID_URL);
	}
	
	@Given("Create a valid update booking Payload using {string}, {string}, {int}, {string}, {string}, {string}, {string}")
	public void UpdateBookingPayload(String firstname, String lastname, int totalprice, String depositepaid, String checkin, String checkout, String additionalneeds) throws ParseException
	{
		this.generateCreateBookingPayload(firstname, lastname, totalprice, depositepaid, checkin, checkout, additionalneeds);
	}
	
	@Given("Create a valid partial update booking Payload using {string}, {string}")
	public void partialpdateBookingPayload(String firstname, String lastname) throws ParseException
	{
		this.generatePartialUpdateBookingPayload(firstname, lastname);
	}
	
	@When("I hit update booking End point {string} with the generated payload")
	public void hitupdateBookingAPI(String endpoint)
	{
		String append_BookingID = endpoint+bookingId;
		try {
			header.put(Constants.Content_Type_Key, Constants.Content_Type_Value);
			header.put(Constants.Accept_Key, Constants.Accept_Value);
			header.put(Constants.Coockie_Key, Constants.Coockie_Value+token);
			this.runPUTActionForUpdate(append_BookingID,payload, header);
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
	@Given("Hit a DELETE request for deleting the booking using {string}")
	public void hitDeleteBookingAPI(String URL)
	{
		header.put(Constants.Content_Type_Key, Constants.Content_Type_Value);
		header.put(Constants.Coockie_Key, Constants.Coockie_Value+token);
		String appended_ID_URL = URL+bookingId;
		this.runDELETEAction(appended_ID_URL, header);
	}
	
	@Given("Hit a GET request for checking health of API using {string}")
	public void getHealthCheckStatus(String URL)
	{
		this.runGETActionForPing(URL);
	}
	
	@Then("^response at \"([^\"]*)\" is \"([^\"]*)\"$")
	public void responseAtIs(String path, String value) throws Throwable {
		assertThat(this.response.jsonPath().getString(path)).isEqualTo(value);
	}
	
	@Then("^response code is (\\d+)$")
    public void responseCodeIs(int code) throws Throwable {
             this.response.then().log().ifValidationFails().assertThat().statusCode(code);
    }

	
}
