require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'fileutils'
include FileUtils::Verbose

After("@needs_file_cleanup") do
  FileUtils::rm_r("projects/#{@my_project.name}")
end




Given /^I have a project called "([^"]*)"$/ do |name|
  @my_project = BookphileProject.new(name)
end


When /^I load images into the project from directory "([^"]*)"$/ do |image_path|
  @my_project.load_images(image_path)
end


When /^directory "([^"]*)" contains "([^"]*)"$/ do |path, image_filename|
  original_path = Dir.pwd
  Dir.chdir(path)
  unless File.exist?(image_filename)
    `convert logo: #{image_filename}`
  end
  Dir.chdir(original_path)
end


When /^I launch a new project called "([^"]*)"$/ do |project_name|
  @my_project = BookphileProject.new(project_name)
  @my_project.launch
end


Then /^a new directory "([^"]*)" will exist$/ do |dir_path|
  Dir.exist?(dir_path).should == true
end


Then /^directory "([^"]*)" should contain (\d+) files$/ do |directory_path, file_count|
  original_path = Dir.pwd
  Dir.chdir(directory_path)
  Dir.glob("*").length.should == file_count.to_i
  Dir.chdir(original_path)
end
