require './lib/file_reader'
require 'pry'


message, *braille = ARGV


message_file = File.open("data/#{message}")
message_read = message_file.read.chomp.chars
binding.pry

# puts first_arg
# puts the_rest
#
# puts first_arg.length
# puts the_rest.length
#
# puts first_arg.to_s
# puts the_rest.to_s
puts "Created '#{braille.reduce}' containing #{braille.reduce.length} characters"

# ARGV.each do|a|
#   puts "Argument: #{a}"
# end
#


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


# class NightWriter
#   attr_reader :file_reader
#
#   def initialize
#     @reader = FileReader.new
#     binding.pry
#   end
#
#   def encode_file_to_braille
#     # I wouldn't worry about testing this method
#     # unless you get everything else done
#     plain = reader.read
#     braille = encode_to_braille(plain)
#   end
#
#   def encode_to_braille(input)
#     # you've taken in an INPUT string
#     # do the magic
#     # send out an OUTPUT string
#   end
# end
#
# puts ARGV.inspect
