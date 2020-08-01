class Dictionary

  attr_reader :dictionary
  def initialize(filepath)
    @dictionary = Hash[File.read(filepath.chomp).scan(/(.+?), (.+)/)]
  end

end
