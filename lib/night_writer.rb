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

  def translate_to_braille(new_text)
    braille_message = []
    new_text.each do |character|
      dictionary.dictionary.each do |letter, braille|
        if letter == character
          braille_message << braille.split(" ")
        end
      end
    end
    braille_message
  end

  def find_braille_rows_assembled(braille_by_row)
    braille_rows_assembled = []
    braille_by_row.each do |character|
      braille_rows_assembled << "#{character.join("")}\n"
    end
    braille_rows_assembled
  end

  def find_braille_all_one_line(braille_rows_assembled)
    braille_all_one_line = []
    braille_all_one_line << braille_rows_assembled.join("").delete_suffix("\n")
    braille_all_one_line
  end

  def read_and_write_english_to_braille
    new_text = reader.read_first_arg.chomp.split("")
    braille_message = translate_to_braille(new_text)
    header, *rows = braille_message
    braille_by_row = header.zip(*rows)
    braille_rows_assembled = find_braille_rows_assembled(braille_by_row)
    braille_rows_with_breaks = braille_rows_assembled.map do |braille_row|
      braille_row.scan(/.{1,40}/).join(" ").split(" ")
    end
    binding.pry



    # make an array of the row, broken up into set of 40 characters.
    # array [[a1,a2,a3,a4], [b1,b2,b3,b4], [c1,c2,c3,c4]]
    # arrange them so they are all in a line like a1, b1, c1, a2, b2, c2,... c4
    #
    # you don't need the triple break at that point, you'd just need the single break.


    # b_rows_w_breaks_and_returns = braille_rows_with_breaks.each do |braille_row|
    #   if braille_row == braille_rows_with_breaks[0]
    #     next
    #   elsif braille_row == braille_rows_with_breaks[1]
    #     braille_row.insert(0, "\r")
    #   elsif braille_row == braille_rows_with_breaks[2]
    #     braille_row.insert(0, "\r\r")
    #   else
    #     next
    #   end
    # end
    # braille_all_one_line = find_braille_all_one_line(processed_rows)
    # writer.write(b_rows_w_breaks_and_returns[0])
    writer.write(b_rows_w_breaks_and_returns[1])
    # writer.write(b_rows_w_breaks_and_returns[2])
  end

end

#this below isn't gonna work I don't think
# ARGV[0] = "message.txt"
# ARGV[1] = "braille.txt"
night_writer = NightWriter.new
# night_writer.output_statement
