require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'
require './lib/file_writer'
require './lib/night_reader'
require './lib/dictionary'
require './lib/braille_translator'

class NightReaderTest < Minitest::Test

  def test_it_exists
    night_reader = NightReader.new

    assert_instance_of NightReader, night_reader
  end

  def test_it_has_attributes
    night_reader = NightReader.new

    assert_instance_of BrailleTranslator, night_reader.braille_translator
    assert_instance_of FileReader, night_reader.reader
    assert_instance_of FileWriter, night_reader.writer
    assert_instance_of Dictionary, night_reader.dictionary
  end
end
