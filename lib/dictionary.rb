require 'pry'
class Dictionary

  def initialize(filepath)
    Hash[File.read(filepath.chomp).scan(/(.+?), (.+)/)]
  end

end
