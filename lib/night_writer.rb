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
          braille_message << braille.split("\\")
        end
      end
    end
    reassembled_message = []
    broken_up_message = []
    braille_message.map! do |character|
      character.each do |line|
        broken_up_message << "#{line}\n"
      end
      reassembled_message << broken_up_message.join("").delete_suffix("\n")
    end
    binding.pry


      # broken_up_message = "#{word}\n" }

    # broken_up_message = braille_message.flatten.map! { |word| "#{word}\n" }
    writer.write(reassembled_message.reduce)
  end

end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightWriter.new
# night_writer.output_statement
