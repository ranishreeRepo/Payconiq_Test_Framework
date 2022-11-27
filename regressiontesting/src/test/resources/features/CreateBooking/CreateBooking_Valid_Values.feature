Feature: Validation of the cases when we have valid values for Create booking

 #------------------ Author: Ranishree T M -----------------

@Payconiq_Regression
Scenario Outline: Payconiq Regression - Response Payload validations - Validate the response when customer create the booking
Given Create a valid Create booking Payload using "<firstname>", "<lastname>", "<totalprice>", "<depositpaid>", "<checkin>", "<checkout>", "<additionalneeds>"
    When  I hit Create booking End point "<EndPoint>" with the generated payload
    Then  log response all
    And   response code is <statusCode>
    And   response at "<bookingId_res>" is "<bookingId_val>"
  #  And   response at "<booking_res>" is not null
    And   response at "<firstname_res>" is "<firstname_val>"
    And   response at "<lastname_res>" is "<lastname_val>"
    And   response at "<totalprice_res>" is "<totalprice_val>"
    And   response at "<depositePaid_res>" is "<depositePaid_val>"
   # And   response at "<bookingdates_res>" is not null
    And   response at "<checkIn_res>" is "<checkIn_val>"
    And   response at "<checkout_res>" is "<checkout_val>"
    And   response at "<additionalNeeds_res>" is "<additionalNeeds_val>"
  Examples:
  | statusCode |EndPoint| firstname  | lastname | totalprice | depositpaid | checkin      |checkout   | additionalneeds | bookingId_res| bookingId_val| booking_res| firstname_res| firstname_val| lastname_res| lastname_val |totalprice_res |totalprice_val |depositePaid_res |depositePaid_val |bookingdates_res |checkIn_res |checkIn_val |checkout_res| checkout_val |additionalNeeds_res| additionalNeeds_val|
  | 200        |        |Ranishree  | TM       | 100        | 50          | 22-11-2022   |23-11-2022 | Breakfast        |              |              |            |              |              |             |              |               |               |                 |                 |                 |            |            |            |              |                   |                    |