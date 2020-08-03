require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require './lib/english_translator'

class NightWriter

  attr_reader :reader, :writer, :dictionary, :english_translator

  def initialize
    @english_translator = EnglishTranslator.new
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    message, *braille = ARGV
    p "Created '#{braille.reduce}' containing #{reader.read_second_arg.chomp.length} characters"
  end
end

#turn the below on to use program.  Test won't work if they're on, however.
# night_writer = EnglishTranslator.new
# night_writer.read_and_write_english_to_braille
# night_writer.output_statement
