require 'set'
load 'slowo_do_daty.rb'
load 'data_do_slowa.rb'

puts "WITAJ W ANALIZATORZE DAT! "
puts "Z której opcji chcesz skorzystać?"
puts " 1 - konwersja daty na słowa" 
puts " 2 - konwersja słowa na datę" 

case gets.chomp
when "1"
	puts "Podaj swoją datę urodzenia"  	#communicate
	input = gets 				#getting date of birth from user
	c = DataDoSlowa.new(input)
	c.sprawdzDate

when "2"
	puts "Podaj słowo do konwersji: "
	input = gets
	calculator= SlowoDoDaty.new(input)
	calculator.procesujSlowo
	calculator.wypiszPoprawnaDate

else
  puts "Błędny wybór"

end 
