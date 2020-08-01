require 'pry'
require './lib/file_reader'

class NightWriter
  attr_reader :reader
  def initialize
    @reader = FileReader.new
  end

  def output_statement
    message, *braille = ARGV

    puts "Created '#{braille.reduce}' containing #{reader.read.chomp.length} characters"
  end

end


night_writer = NightWriter.new
night_writer.output_statement
