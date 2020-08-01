require 'pry'

class FileReader
  def read
    filename = ARGV[0]
    File.read("data/#{filename}")
  end
end
