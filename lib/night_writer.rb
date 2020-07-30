require 'pry'


File.open("data/message.txt", "r+") do |file|

  

  file.each do |message|
    split_message = message.split("")
    split_message.each do |char|

      binding.pry
    end
  end

end

File.open("data/braille.txt", "w") do |file|


# binding.pry

  # file.write


end
