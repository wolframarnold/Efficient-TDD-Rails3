Feature: Users API
  In order to support API client applications
  a client
  wants to do CRUD operations on User and associated Shipping Addresses

  Scenario: Get all users and shipping addresses
    Given that it is 2010-01-01T00:00:00
    And the following users:
      |first_name|last_name|
      |Joe|Smith|
      |Sally|Porter|
#    Given the following shipping addresses:
#      |first_name|last_name|street  |city|state|zip  |
#      |Joe       |Smith    |123 Main|SF  |CA   |12345|
#      |Sally     |Porter   |123 Main|LA  |CA   |23456|
    When I make a GET request to /users.json
    Then I should get a 200 response code
    And  I should get a content-type of "application/json"
    And the response body should contain the JSON hash:
    """
      [{user:{created_at:"2010-01-01T08:00:00Z",updated_at:"2010-01-01T08:00:00Z",
              id:1,
              last_name:"Smith", email:null, first_name: "Joe",
              middle_name:null}},
       {user:{created_at:"2010-01-01T08:00:00Z",updated_at:"2010-01-01T08:00:00Z",
              id:2, last_name: "Porter", email:null,
              first_name:"Sally",middle_name:null}}]
    """
