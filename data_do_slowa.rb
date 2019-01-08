class DataDoSlowa														# utworzenie klasy 	

	def initialize(data)											# inicjalizacja 
		@data = data 
	end
	
	def checkDateUpdated(aDate)								# definicja metody sprawdzania poprawności daty - tylko poprawne daty będą konwertowane
	  matched =																	# tworzenie schematu do którego musi dopasować się data
		%r{
			(?<year>
			(^           														# nie powinno być ż adnego znaku przez rozpoczęciem
			  [1-9]\d{3}  													# rok nie może zaczynać się od zera
			)
		  )
		  (?<month>
				(0[1-9])      												# miesiąc może zaczynać się od zera, jednak na drugim miejscu zera być nie może
				|
				(1[0-2])      												# lub miesiąc może być 10, 11 lub 12
		  )
		  (?<day>
				(0[1-9])      												# dzień może zaczynać się od zera, jednak na drugim miejscu zera być nie może
				|(1[0-9])     												#
				|(2[0-9])															# lub powiniec mieścić się w przedziale od 10 do 31
				|30																		#	
				|31																		#
		  )$             
		}x.match(aDate)													# wprowadzona data musi pasować do schematu

		if (matched)														# jeżeli pasuje, wykonywane są dalsze instrukcje
		  day, month, year = matched[:day], matched[:month], matched[:year]
		  day = day[-1] if day[0] == "0"
		  month = month[-1] if month[0] == "0"

		  year, month, day = year.to_i, month.to_i, day.to_i

		  require 'date'
		  begin
			date = Date.new(year, month, day)
		  rescue ArgumentError => e
		   
		return false
		  end
		  true
		else
		  false
		end
	end
	 
	def sprawdzDate																# definicja metoda prawdzającej datę
		@date = @data																# atrybut data
		checkDateUpdated(@date) ? wynik = "tak" : wynik= "nie"
		if wynik == "tak"														# jeżeli data przeszła sprawdzenie poprawności pozytywnie
			analiza																		# wykonywana jest funkcja analizy daty
		else
			print "Podana data jest #{checkDateUpdated(@date) ? "" : "nie"}poprawna! \n"
		end																					# jeżeli nie - wyświetlany jest komunikat
	end
	
	def wczytajSlownik														# definicja metody wczytującej słownik
		@slownik=[]													    		# utworzenie pustej tablicy (globalnej) zawierającej słownik
		@slownik = File.open('slowa.txt', 'r'){|file| file.readlines.collect{|line|line.chomp}}
	end																						# wczytanie slownika jako tablicy (z obcięciem znaku /n na końcu każdej linni, bug Windowsa)

	def analiza															  		# definicja metody analizującej datę
		puts "Dziękuję. Trwa analiza..."						# komunikat
		wczytajSlownik															# wykonywana jest metoda wczytywania słownika
		puts "Twoja data w innych systemach:"				# komunikat
		konwertujNaRozneSystemy											# uruchamiana jest metoda konwersji daty
		puts "Szukam w słowniku..." 								# komunikat 
		znajdzWSlowniku															# uruchamiana jest metoda szukania przekonwertowanych dat w słowniku
	end
	
	def konwertujNaRozneSystemy										# definicja metody konwersji daty
		@noweslowo = [] 														# utworzenie pustej tablicy 
		for i in (11..36)														# konwersja daty w systemach liczbowych od 11 do 36 
			@noweslowo[i] = @date.to_i.to_s(i) 				# wpisanie do tablicy
			print "   #{i}:      #{@noweslowo[i]}\n"	# wypisanie na ekran
		end
	end
	
	def znajdzWSlowniku														# definicja metody szukania słów w słowniku
		@znalezione = []														# utworzenie pustej tablicy dla 
		for k in (11..@noweslowo.length-1) 					# porownywanie tablicy ze slownikiem i z przekonwertowanymi datami
			for l in (0..@slownik.length-1)						# jeżeli znaleziono takie same słowo (data jest istaniejącym słowem)
				if @noweslowo[k].to_s == @slownik[l].to_s
					@znalezione = @noweslowo[k] 				  # wpisanie znalezionego slowa do tablicy 
				end
			end
		end
		if @znalezione.length > 0 									# jeżeli tablica znalezionych słów nie jest pusta
			puts "Po konwersji Twojej daty znaleziono następujące słowa: "
			print "   #{@znalezione}\n"								# wyswietl komunikat i pokaż tablicę
		else 																				# w przeciwnym wypadku - komunikat
			puts "Niestety, nie odnaleziono żadnych słów."
		end
	end
end