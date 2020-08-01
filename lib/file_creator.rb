require 'pry'

class FileCreator
  def write
    filename = ARGV[1]
    File.write("data/#{filename}", "w")
  end
end
