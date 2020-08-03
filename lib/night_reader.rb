require './lib/braille_translator'

night_reader = BrailleTranslator.new
night_reader.read_and_write_braille_to_english
night_reader.output_statement
