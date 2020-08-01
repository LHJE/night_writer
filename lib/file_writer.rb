require 'pry'

class FileWriter
  def write
    filename = ARGV[1]
    File.write("data/#{filename}", "w")
  end
end
