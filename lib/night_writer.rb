require 'pry'
require './lib/file_reader'

class NightWriter

  attr_reader :reader
  
  def initialize
    @reader = FileReader.new
  end

  def output_statement
    message, *braille = ARGV

    p "Created '#{braille.reduce}' containing #{reader.read.chomp.length} characters"
  end



end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightWriter.new
# night_writer.output_statement
