class FileReader
  def read_first_arg
    filename = ARGV[0]
    other_file = ARGV[1]
    if filename == nil || other_file == nil || filename[-4..-1] != ".txt" || other_file[-4..-1] != ".txt"
      puts ""
      puts "Please put in two arguments after running the file:"
      puts "1) the file from which you'd like to read"
      puts "2) the file to which you'd like to write"
      puts "* the first file must already exist, and end with '.txt'"
      exit
    else
      File.read("data/#{filename}")
    end
  end

  def read_second_arg
    filename = ARGV[1]
    File.read("data/#{filename}")
  end
end
