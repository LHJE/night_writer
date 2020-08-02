require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require 'pry'

class NightReader

  attr_reader :reader, :writer, :dictionary

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @dictionary = Dictionary.new("./data/braille_dictionary.txt")
  end

  def output_statement
    braille, *message = ARGV

    p "Created '#{message.reduce}' containing #{reader.read_first_arg.chomp.length} characters"
  end

  def read_and_write_english_to_english
    new_text = reader.read_first_arg.chomp
    writer.write(new_text)
  end

  def read_and_write_braille_to_braille
    new_text = reader.read_first_arg.chomp
    writer.write(new_text)
  end

  # def translate_to_english(new_text)
  #   english_message = []
  #   new_text.each do |character|
  #     binding.pry
  #     dictionary.dictionary.each do |letter, braille|
  #       if braille == character
  #         english_message << letter.split(" ")
  #       end
  #     end
  #   end
  #   english_message
  # end

  def find_braille_by_row(braille_message)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_by_row
  end

  def find_braille_rows_assembled(braille_by_row)
    braille_rows_assembled = []
    braille_by_row.each do |character|
      braille_rows_assembled << "#{character.join("")}"
    end
    braille_rows_assembled
  end

  def find_untransposed_b_message(braille_multiple_lines)
    untransposed_b_message = []
    extra_lines = []
    braille_multiple_lines.transpose.each do |braille_line|
        index_number = 3
        while braille_multiple_lines.flatten[braille_multiple_lines.flatten.find_index(braille_line.reduce) + index_number] != nil
          extra_lines << braille_multiple_lines.flatten[braille_multiple_lines.flatten.find_index(braille_line.reduce) + index_number]
          index_number += 3
        end
        untransposed_b_message << (braille_line.reduce + extra_lines.join(""))
        extra_lines = []
    end
    untransposed_b_message[0..2]
  end

  def find_braille_multiple_lines(new_text)
    find_braille_multiple_lines = []
    find_braille_multiple_lines << new_text.split("\n")
    find_braille_multiple_lines
  end

  def read_and_write_braille_to_english
    new_text = reader.read_first_arg.chomp

    braille_multiple_lines = find_braille_multiple_lines(new_text)

    untransposed_b_message_w_breaks = find_untransposed_b_message(braille_multiple_lines)
    binding.pry
    # CHECK FOR CAPITALS FIRST.
    braille_rows_disassembled = find_braille_rows_disassembled(untransposed_b_message_w_breaks)
    #English_by_row?
    braille_by_row = find_braille_by_row(braille_rows_disassembled)

    english_message = translate_to_english(braille_by_row)
    writer.write(english_message)
  end

end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightReader.new
# night_writer.output_statement
