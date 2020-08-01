require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require 'pry'

class NightWriter

  attr_reader :reader, :writer, :dictionary

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    message, *braille = ARGV

    p "Created '#{braille.reduce}' containing #{reader.read_first_arg.chomp.length} characters"
  end

  def read_and_write_english_to_english
    new_text = reader.read_first_arg.chomp
    writer.write(new_text)
  end

  def read_and_write_english_to_braille
    new_text = reader.read_first_arg.chomp.split("")
    braille_message = []
    dictionary.dictionary.each do |letter, braille|
      new_text.each do |character|
        if letter == character
          binding.pry
          braille_message << [braille]
        end
      end
    end


    writer.write(braille_message.flatten.reduce)

  end

end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightWriter.new
# night_writer.output_statement
