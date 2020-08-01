require 'pry'

class FileReader
  def read_first_arg
    filename = ARGV[0]
    File.read("data/#{filename}")
  end

  def read_second_arg
    filename = ARGV[1]
    File.read("data/#{filename}")
  end
end
