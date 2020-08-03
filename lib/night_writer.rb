require './lib/english_translator'

night_writer = EnglishTranslator.new
night_writer.read_and_write_english_to_braille
night_writer.output_statement
