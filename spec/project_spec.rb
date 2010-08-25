require 'spec_helper'

describe "new project" do
  it "have a readable #name attribute" do
    BookphileProject.new("foo").name.should == "foo"
  end
  
  it "should raise an error if it doesn't have one upon initialization" do
    lambda{BookphileProject.new}.should raise_error(ArgumentError)
  end
end

describe "#launch" do
  before(:each) do
    Dir.stub!(:mkdir)
  end
  
  describe "creating file structure" do
    it "should check to see if the directory already exists" do
      Dir.stub!(:mkdir)
      Dir.should_receive(:exist?).with("projects/foo")
      BookphileProject.new("foo").launch
    end
    
    it "should raise an exception if the directory already exists" do
      Dir.stub!(:mkdir)
      Dir.should_receive(:exist?).with("projects/foo").and_return(true)
      lambda{BookphileProject.new("foo").launch}.should raise_error(DuplicateProjectError)
    end
    
    it "should create a named directory in projects" do
      Dir.stub!(:mkdir)
      Dir.should_receive(:mkdir).with("projects/foo")
      BookphileProject.new("foo").launch
    end
    
    it "should create a /scans directory inside the project root" do
      Dir.stub!(:mkdir)
      Dir.should_receive(:mkdir).with("projects/foo/scans")
      BookphileProject.new("foo").launch
    end
  end
  
  describe "#load_images" do
    it "should collect a glob list of all images in the path argument" do
      Dir.stub!(:chdir)
      FileUtils.stub!(:cp)
      proj = BookphileProject.new("foo")
      proj.should_receive(:absolute_image_paths).and_return(["foo.tif"])
      proj.launch
      proj.load_images("bar/baz")
    end
    
    it "should copy all matched files into projects/project_name/scans/" do
      Dir.stub!(:chdir)
      FileUtils.should_receive(:cp).with("foo.tif", "projects/foo/scans")
      FileUtils.should_receive(:cp).with("bar.png", "projects/foo/scans")
      proj = BookphileProject.new("foo")
      proj.stub!(:absolute_image_paths).and_return(["foo.tif", "bar.png"])
      proj.launch
      proj.load_images("bar/baz")
    end
  end
end