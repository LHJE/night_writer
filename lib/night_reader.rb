require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require './lib/braille_translator'

class NightReader

  attr_reader :reader, :writer, :dictionary, :braille_translator

  def initialize
    @braille_translator = BrailleTranslator.new
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    braille, *message = ARGV
    p "Created '#{message.reduce}' containing #{reader.read_second_arg.chomp.length} characters"
  end
end

#turn the below on to use program.  Test won't work if they're on, however.
# night_reader = BrailleTranslator.new
# night_reader.read_and_write_braille_to_english
# night_reader.output_statement
