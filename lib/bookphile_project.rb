class DuplicateProjectError < StandardError
end

class BookphileProject
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def project_directory
    "projects/#{@name}"
  end
  
  def launch
    raise DuplicateProjectError, "project already exists" if Dir.exist?(project_directory)
    Dir.mkdir(project_directory)
    Dir.mkdir("#{project_directory}/scans")
  end
  
  def absolute_image_paths
    Dir.glob("*.{tif,tiff,jpg,jpeg,png}").collect {|filename| File.expand_path(filename)}
  end
  
  def load_images(path_to_images)
    original_path = Dir.pwd
    Dir.chdir(path_to_images)
    image_files = absolute_image_paths
    Dir.chdir(original_path)
    image_files.each {|im| FileUtils::cp(im, "#{project_directory}/scans")}
  end
end