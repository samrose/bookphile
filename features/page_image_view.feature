Feature: Page image view
  In order to see what we're working with
  As a scanner
  I want a view that shows me one scanned book page

  Scenario: includes the local path to the original image file
    Given I have a project called "my_project" 
    And project "my_project" has a page scan called "019.jpg"
    When I go to "/my_project/page/019"
    Then I should see "019.jpg" within "//img[@class='original']/@src"
  
  
  
