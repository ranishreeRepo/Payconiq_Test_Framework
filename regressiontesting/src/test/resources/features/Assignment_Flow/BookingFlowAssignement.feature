Feature: Validation of the cases when we have valid values for Create booking

 #------------------ Author: Ranishree T M -----------------


@HealthCheck 
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to check whether API is up and running
Given Hit a GET request for checking health of API using "https://restful-booker.herokuapp.com/ping"
Then response code is <statusCode>
Examples:
  | statusCode |
  | 201        |

  
  @GetBookingById 
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to returns the ids of all the bookings that exist within the API
Given Hit a GET request for GetBookingById using "https://restful-booker.herokuapp.com/booking"
Then response code is <statusCode>

Examples:
  | statusCode|
  | 200       |

  @GetBooking 
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to returns a specific booking based upon the booking id provided
Given Hit a GET request for GetBooking using "https://restful-booker.herokuapp.com/booking/"
Then response code is <statusCode>
    Then response at "<firstname_res>" is "<firstname_val>"	
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"

Examples:
  | statusCode | firstname_res| firstname_val      | lastname_res     | lastname_val            |totalprice_res |totalprice_val   |depositePaid_res |depositePaid_val |bookingdates_res |checkIn_res |checkIn_val   |checkout_res  | checkout_val |additionalNeeds_res| additionalNeeds_val|
  | 200        | firstname    | Guoqiang           | lastname         | Combs                      | totalprice    |111              |depositpaid      | true            |                 |bookingdates.checkin     | 2018-01-01  | bookingdates.checkout     | 2019-01-01  | additionalneeds   |      Breakfast              |                
  
@CreateBooking 
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer create the booking
		Given Create a valid Create booking Payload using "<firstname>", "<lastname>", 100, "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit Create booking End point "<EndPoint>" with the generated payload
   Then   Save bookingid for furthur usecase from "<bookingIdPath>"
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  |bookingIdPath| statusCode |EndPoint                                     | firstname  | lastname | depositpaid | checkin      |checkout   | additionalneeds |firstname_res     | firstname_val| lastname_res     | lastname_val |totalprice_res     |totalprice_val |depositePaid_res     |depositePaid_val |checkIn_res                  |checkIn_val |checkout_res                  | checkout_val |additionalNeeds_res     | additionalNeeds_val|
  |bookingid    | 200        |https://restful-booker.herokuapp.com/booking |Ranishree   | TM       | true        | 2022-11-28   |2022-11-29 | Breakfast       |booking.firstname | Ranishree    | booking.lastname | TM           |booking.totalprice |100            | booking.depositpaid |  true           |booking.bookingdates.checkin |2022-11-28  |booking.bookingdates.checkout | 2022-11-29   |booking.additionalneeds | Breakfast          |   

@Auth 
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer hits Auth API for token
		Given Create a valid Auth Payload using "<username>", "<password>" by hitting "<AuthEndPoint>"
		Then extract and save token 
		Then response code is <statusCode>
Examples:
  | statusCode |AuthEndPoint                             | username  | password  |
  |200         |https://restful-booker.herokuapp.com/auth| admin     |password123|
  
    
@UpdateBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer update the booking
Given Create a valid Auth Payload using "<username>", "<password>" by hitting "<AuthEndPoint>"
		Then extract and save token
    Given Create a valid Create booking Payload using "<firstname>", "<lastname>", 100, "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit Create booking End point "<EndPoint>" with the generated payload
   Then   Save bookingid for furthur usecase from "<bookingIdPath>"
    Given Create a valid update booking Payload using "<updatedfirstname>", "<updatedlastname>", 200, "<updateddepositpaid>", "<updatedcheckin>", "<updatedcheckout>", "<updatedadditionalneeds>"
    When  I hit update booking End point "<Update_EndPoint>" with the generated payload
    And   response code is <statusCode>
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
    
   Examples:
  |bookingIdPath| statusCode |EndPoint                                     |Update_EndPoint |AuthEndPoint                             | username  | password  |firstname  | lastname | depositpaid | checkin      |checkout   | additionalneeds                                 |updatedfirstname  | updatedlastname |updateddepositpaid  | updatedcheckin |updatedcheckout |updatedadditionalneeds| firstname_res     | firstname_val| lastname_res     | lastname_val |totalprice_res     |totalprice_val |depositePaid_res     |depositePaid_val |checkIn_res                  |checkIn_val |checkout_res                  | checkout_val |additionalNeeds_res     | additionalNeeds_val|
  |bookingid    | 200        |https://restful-booker.herokuapp.com/booking |https://restful-booker.herokuapp.com/booking/ |https://restful-booker.herokuapp.com/auth | admin     |password123| Ranishree   | TM       | true        | 2022-11-28   |2022-11-29 | Breakfast       |Rekha             | JK              |false                    |  2023-01-01              |    2023-01-02            |  lunch                    |firstname | Rekha    | lastname | JK           |totalprice |200            | depositpaid |  false           |bookingdates.checkin |2023-01-01  |bookingdates.checkout | 2023-01-02   |additionalneeds | lunch          |   
 
@PartialUpdateBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer update the booking
    Given Create a valid Auth Payload using "<username>", "<password>" by hitting "<AuthEndPoint>"
		Then extract and save token
		Given Create a valid Create booking Payload using "<firstname>", "<lastname>", 100, "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit Create booking End point "<EndPoint>" with the generated payload
		Then   Save bookingid for furthur usecase from "<bookingIdPath>"
    Given Create a valid partial update booking Payload using "<updated_firstname>", "<updated_lastname>"
    When  I hit update booking End point "<EndPoint>" with the generated payload
    And   response code is <statusCode>
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  | statusCode |EndPoint                                       |bookingIdPath| AuthEndPoint                             | username  | password  |firstname  | lastname  |depositpaid | checkin      |checkout   | additionalneeds |updated_firstname  | updated_lastname |firstname_res     | firstname_val| lastname_res     | lastname_val |totalprice_res     |totalprice_val |depositePaid_res     |depositePaid_val |checkIn_res                  |checkIn_val |checkout_res                  | checkout_val |additionalNeeds_res     | additionalNeeds_val|
  | 200        |https://restful-booker.herokuapp.com/booking/  |bookingid    |https://restful-booker.herokuapp.com/auth | admin     |password123|Ranishree       | TM       |true        | 2022-11-28   |2022-11-29 | Breakfast       |Rekha              | JK               | firstname | Rekha    | lastname | JK           |totalprice |100            | depositpaid |  true           |bookingdates.checkin |2022-11-28  |bookingdates.checkout | 2022-11-29   |additionalneeds | Breakfast          |   
  		

 @DeleteBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to delete the existing booking
 Given Create a valid Auth Payload using "<username>", "<password>" by hitting "<AuthEndPoint>"
		Then extract and save token
		Given Create a valid Create booking Payload using "<firstname>", "<lastname>", 100, "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit Create booking End point "<EndPoint>" with the generated payload
		Then   Save bookingid for furthur usecase from "<bookingIdPath>"
		Given Hit a DELETE request for deleting the booking using "https://restful-booker.herokuapp.com/booking/"
 
 Examples:
  | statusCode |EndPoint                                       |bookingIdPath| AuthEndPoint                             | username  | password  |firstname  | lastname  |depositpaid | checkin      |checkout   | additionalneeds |updated_firstname  | updated_lastname |firstname_res     | firstname_val| lastname_res     | lastname_val |totalprice_res     |totalprice_val |depositePaid_res     |depositePaid_val |checkIn_res                  |checkIn_val |checkout_res                  | checkout_val |additionalNeeds_res     | additionalNeeds_val|
  | 200        |https://restful-booker.herokuapp.com/booking/  |bookingid    |https://restful-booker.herokuapp.com/auth | admin     |password123|Ranishree       | TM       |true        | 2022-11-28   |2022-11-29 | Breakfast       |Rekha              | JK               | firstname | Rekha    | lastname | JK           |totalprice |100            | depositpaid |  true           |bookingdates.checkin |2022-11-28  |bookingdates.checkout | 2022-11-29   |additionalneeds | Breakfast          |   
  	




