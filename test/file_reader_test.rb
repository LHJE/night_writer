require 'minitest/autorun'
require 'minitest/pride'
require './lib/file_reader'

class FileReaderTest < Minitest::Test

  def test_it_exists
    reader = FileReader.new

    assert_instance_of FileReader, reader
  end

end
