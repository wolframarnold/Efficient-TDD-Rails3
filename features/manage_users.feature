Feature: Manage users
  In order to administer Users and their Shipping Addresses
  a user
  wants to add a new record
  
#  Scenario: Register new user
#    Given I am on the new user page
#    When I fill in "First name" with "Joe"
#    And I fill in "Last name" with "Smith"
#    And I press "Create"
#    Then I should see "Joe"
#    And I should see "Smith"

  Scenario: Register new user with Shipping Address
    Given I am on the new user page
    When I fill in "First name" with "Joe"
    And I fill in "Last name" with "Smith"
    And I fill in "Street" with "123 Main"
    And I fill in "City" with "San Francisco"
    And I fill in "State" with "CA"
    And I fill in "Zip" with "94108"
    And I press "Create"
    And I should see "Joe"
    And I should see "Smith"
    And I should see "123 Main"
    And I should see "San Francisco"
    And I should see "CA"
    And I should see "94108"

#  Scenario: Delete user
#    Given the following users:
#      |first_name|last_name|
#      |Joe|Smith|
#      |Sally|Porter|
#      |Mark|Parker|
#    When I delete the 3rd user
#    Then I should see the following users:
#      |First name|Last name|
#      |Joe|Smith|
#      |Sally|Porter|
