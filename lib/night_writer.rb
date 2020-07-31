require 'pry'


class NightWriter
  attr_reader :file_reader

  def initialize
    @reader = FileReader.new
  end

  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = reader.read
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(input)
    # you've taken in an INPUT string
    # do the magic
    # send out an OUTPUT string
  end
end

puts ARGV.inspect

# File.open("data/message.txt", "r+") do |file|
#
#
#
#   file.each do |message|
#     split_message = message.split("")
#     split_message.each do |char|
#
#       binding.pry
#     end
#   end
#
# end
#
# File.open("data/braille.txt", "w") do |file|
#
#
# # binding.pry
#
#   # file.write
#
#
# end
