require 'pry'

class FileWriter
  def write(new_text)
    filename = ARGV[1]
    File.write("data/#{filename}", new_text)
  end
end
