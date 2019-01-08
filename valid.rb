load 'slowo_do_daty.rb' 						# załadowanie dwóch pozostałych plików
load 'data_do_slowa.rb'							#

puts "WITAJ W ANALIZATORZE DAT! "				# ekran powialny
puts "Z której opcji chcesz skorzystać?"		# prośba o wybór opcji przez użytkownika 
puts " 1 - konwersja daty na słowa" 			#
puts " 2 - konwersja słowa na datę" 			#

case gets.chomp									# popbranie odpowiedzi oraz uzależnienie od niej dalszego działania
when "1"										# wybranie opcji nr "1" pzez użytkownika
	puts "Podaj swoją datę urodzenia"  			# komunikat - prośba o podanie daty
	input = gets 								# pobranie daty
	c = DataDoSlowa.new(input)					# przypisanie pobranej daty jako obiekt odpowiedniej klasy
	c.sprawdzDate								# uruchomienie funkcji sprawdzania danych

when "2"										# wybranie przez użytkownika opcji nr "2" 
	puts "Podaj słowo do konwersji: "			# komunikat  - prośba o podanie słowa do kowersji
	input = gets								# pobranie słowa 
	calculator= SlowoDoDaty.new(input)			# przypisanie pobranego słowa jako obiekt odpowiedniej klasy 
	calculator.procesujSlowo					# uruchomienie funkcji konwersji słowa na datę 
	calculator.wypiszPoprawnaDate				# uruchomienie funkcji poprawiającej daty 

else
  puts "Błędny wybór"							# wybranie przez użytkownika niepoprawnej opcji

end 
