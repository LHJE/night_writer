require 'pry'
require './lib/file_reader'

class NightWriter
  attr_reader :reader
  def initialize
    @reader = FileReader.new
  end

end


message, *braille = ARGV

puts "Created '#{braille.reduce}' containing #{braille.reduce.length} characters"
