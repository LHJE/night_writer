require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'
require './lib/file_reader'

class NightWriterTest < Minitest::Test

  # def test_it_exists
  #   night_writer = NightWriter.new
  #
  #   assert_instance_of NightWriter, night_writer
  # end

  def test_it_has_attributes
    night_writer = NightWriter.new
    ARGV[0] = "message.txt"
    ARGV[1] = "braille.txt"
    reader = FileReader.new
    binding.pry
    assert_equal "Created 'braille.txt' containing 11 characters", night_writer
  end

end
