require 'pry'
require './lib/file_reader'

class NightWriter
  attr_reader :reader
  def initialize
    @reader = FileReader.new
  end

  def output_statement
    message, *braille = ARGV

    p "Created '#{braille.reduce}' containing #{braille.reduce.length} characters"
  end

end




#
# night_writer.output_statement
