require 'pry'

class FileReader
  def read
    filename = ARGV[0]
    # binding.pry
    File.read("data/#{filename}")
  end
end
