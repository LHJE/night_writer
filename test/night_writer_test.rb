require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/night_writer'
require './lib/dictionary'
require './lib/english_translator'

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new

    assert_instance_of NightWriter, night_writer
  end

  def test_it_has_attributes
    night_writer = NightWriter.new

    assert_instance_of EnglishTranslator, night_writer.english_translator
    assert_instance_of FileReader, night_writer.reader
    assert_instance_of FileWriter, night_writer.writer
    assert_instance_of Dictionary, night_writer.dictionary
  end
end
