require 'pry'

class FileCreator
  def create
    filename = ARGV[1]
    File.write("data/#{filename}", "w")
  end
end
