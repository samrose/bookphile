Feature: New project
  In order to create a new bookphile project
  As a scanner
  I want a New Project setup process on the main page
  
  
  Scenario: New Project… setup dialog
    When I go to New Project
    Then I should see "New Project"
    And I should see "Project name"