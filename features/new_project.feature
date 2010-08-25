Feature: New project
  In order to create a new bookphile project
  As a scanner
  I want a New Project setup process on the main page
  
  
  Scenario: New Project… setup dialog
    When I go to New Project
    Then I should see "New Project"
    And I should see "Project name"
    
    
  @needs_file_cleanup
  Scenario: new project launch creates the necessary directories
    When I launch a new project called "foo"
    Then a new directory "projects/foo" will exist
    And a new directory "projects/foo/scans" will exist
    
    
  @needs_file_cleanup
  Scenario: loading images copies them into the project from the denoted path
    When I launch a new project called "foo"
    And directory "features/fixtures/test_images" contains "test1.tif"
    And directory "features/fixtures/test_images" contains "test3.tif"
    And directory "features/fixtures/test_images" contains "test6.tif"
    And directory "features/fixtures/test_images" contains "test2.jpeg"
    And directory "features/fixtures/test_images" contains "test5.jpg"
    And directory "features/fixtures/test_images" contains "test4.png"
    And I load images into the project from directory "features/fixtures/test_images"
    Then directory "projects/foo/scans" should contain 6 files
    And directory "features/fixtures/test_images" should contain 6 files
    
    
  # @needs_file_cleanup
  # Scenario: re-loading any image raises an error
  #   Given I have launched a project named "foo"
  #   And directory "projects/foo/scans" contains "test1.jpg"
  #   And directory "projects/foo/scans" contains "test2.jpg"
  #   When I load images into the project from directory "features/fixtures/test_images"
  #   Then an error should occur
  
  
  
  
  
  