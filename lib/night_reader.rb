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
    p "Created '#{message.reduce}' containing #{reader.read_second_arg.chomp.length} characters"
  end

  def find_braille_multiple_lines(new_text)
    find_braille_multiple_lines = []
    find_braille_multiple_lines << new_text.split("\n")
    find_braille_multiple_lines
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

  def translate_to_english(new_text)
    english_message = []
    until new_text == ["", "", ""]
      dictionary.dictionary.each do |letter, braille|
        if new_text[0].length > 2
          if [new_text[0][0..1], new_text[1][0..1], new_text[2][0..1]].join(" ")  == ".. .. .."
            english_message << " "
            new_text[0] = new_text[0].slice(2..-1)
            new_text[1] = new_text[1].slice(2..-1)
            new_text[2] = new_text[2].slice(2..-1)
          elsif braille == [new_text[0][0..3], new_text[1][0..3], new_text[2][0..3]].join(" ")
            english_message << letter
            new_text[0] = new_text[0].slice(4..-1)
            new_text[1] = new_text[1].slice(4..-1)
            new_text[2] = new_text[2].slice(4..-1)
          elsif braille == [new_text[0][0..1], new_text[1][0..1], new_text[2][0..1]].join(" ")
            english_message << letter
            new_text[0] = new_text[0].slice(2..-1)
            new_text[1] = new_text[1].slice(2..-1)
            new_text[2] = new_text[2].slice(2..-1)
          else
            next
          end
        elsif [new_text[0][0..1], new_text[1][0..1], new_text[2][0..1]].join(" ")  == ".. .. .."
          english_message << " "
          new_text[0] = new_text[0].slice(2..-1)
          new_text[1] = new_text[1].slice(2..-1)
          new_text[2] = new_text[2].slice(2..-1)
        elsif braille.split(" ").join("\n") == new_text.join("\n")
          english_message << letter
          new_text[0] = new_text[0].slice(2..-1)
          new_text[1] = new_text[1].slice(2..-1)
          new_text[2] = new_text[2].slice(2..-1)
        else
          next
        end
      end
    end
    english_message.join("")
  end

  def read_and_write_braille_to_english
    new_text = reader.read_first_arg.chomp
    braille_multiple_lines = find_braille_multiple_lines(new_text)
    untransposed_b_message_w_breaks = find_untransposed_b_message(braille_multiple_lines)
    english_message = translate_to_english(untransposed_b_message_w_breaks)
    writer.write(english_message)
  end

end

#turn the below on to use program.  Test won't work if they're on, however.
# night_reader = NightReader.new
# night_reader.read_and_write_braille_to_english
# night_reader.output_statement
