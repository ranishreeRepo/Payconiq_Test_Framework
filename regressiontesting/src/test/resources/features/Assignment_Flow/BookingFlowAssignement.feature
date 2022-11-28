Feature: Validation of the cases when we have valid values for Create booking

 #------------------ Author: Ranishree T M -----------------


@Auth
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer hits Auth API for token
		Given Create a valid Auth Payload using "<username>", "<password>" by hitting "<AuthEndPoint>"
Examples:
  | statusCode |AuthEndPoint                             | username  | password  |
  |200         |https://restful-booker.herokuapp.com/auth| admin     |password123|
  

  
  @GetBookingById
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to returns the ids of all the bookings that exist within the API
Given Hit a GET request for GetBookingById using "https://restful-booker.herokuapp.com/booking"

  @GetBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to returns a specific booking based upon the booking id provided
Given Hit a GET request for GetBooking using "https://restful-booker.herokuapp.com/booking/6570"
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
    #Then  log response all
   # And   response code is <statusCode>
    And   response at "<bookingId_res>" is "<bookingId_val>"
  #  And   response at "<booking_res>" is not null
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
 #   And   response at "<bookingdates_res>" is not null
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  | statusCode |EndPoint| firstname  | lastname  | depositpaid | checkin      |checkout   | additionalneeds | bookingId_res| bookingId_val| booking_res| firstname_res| firstname_val| lastname_res| lastname_val |totalprice_res |totalprice_val |depositePaid_res |depositePaid_val |bookingdates_res |checkIn_res |checkIn_val |checkout_res| checkout_val |additionalNeeds_res| additionalNeeds_val|
  | 200        |https://restful-booker.herokuapp.com/booking        |Ranishree  | TM               | true          | 2022-11-28   |2022-11-29 | Breakfast        |              |              |            |              |              |             |              |               |               |                 |                 |                 |            |            |            |              |                   |                    |
  
@UpdateBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer update the booking
Given Create a valid update booking Payload using "<firstname>", "<lastname>", "<totalprice>", "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit update booking End point "<EndPoint>" with the generated payload
    Then  log response all
    And   response code is <statusCode>
    And   response at "<bookingId_res>" is "<bookingId_val>"
    And   response at "<booking_res>" is not null
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<bookingdates_res>" is not null
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  | statusCode |EndPoint| firstname  | lastname | totalprice | depositpaid | checkin      |checkout   | additionalneeds | bookingId_res| bookingId_val| booking_res| firstname_res| firstname_val| lastname_res| lastname_val |totalprice_res |totalprice_val |depositePaid_res |depositePaid_val |bookingdates_res |checkIn_res |checkIn_val |checkout_res| checkout_val |additionalNeeds_res| additionalNeeds_val|
  | 200        |https://restful-booker.herokuapp.com/booking/        |Ranishree  | TM       | 100        | 50          | 30-11-2022   |31-11-2022 | Lunch        |              |              |            |              |              |             |              |               |               |                 |                 |                 |            |            |            |              |                   |                    |
  
@PartialUpdateBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer update the booking
Given Create a valid partial update booking Payload using "<firstname>", "<lastname>"
    When  I hit update booking End point "<EndPoint>" with the generated payload
    Then  log response all
    And   response code is <statusCode>
    And   response at "<bookingId_res>" is "<bookingId_val>"
    And   response at "<booking_res>" is not null
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
    And   response at "<bookingdates_res>" is not null
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  | statusCode |EndPoint| firstname  | lastname | totalprice | depositpaid | checkin      |checkout   | additionalneeds | bookingId_res| bookingId_val| booking_res| firstname_res| firstname_val| lastname_res| lastname_val |totalprice_res |totalprice_val |depositePaid_res |depositePaid_val |bookingdates_res |checkIn_res |checkIn_val |checkout_res| checkout_val |additionalNeeds_res| additionalNeeds_val|
  | 200        |https://restful-booker.herokuapp.com/booking/        |Rekha  | JK       | 100        | 50          | 30-11-2022   |31-11-2022 | Lunch        |              |              |            |              |              |             |              |               |               |                 |                 |                 |            |            |            |              |                   |                    |
  		

 @DeleteBooking
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to delete the existing booking
Given Hit a DELETE request for deleting the booking using "<https://restful-booker.herokuapp.com/booking/>"

@HealthCheck
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when we try to check whether API is up and running
Given Hit a GET request for checking health of API using "<https://restful-booker.herokuapp.com/booking/ping>"





