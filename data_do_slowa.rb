class DataDoSlowa
	def initialize(data)
		@data = data 
	end
	
	def checkDateUpdated(aDate)		#function checking the date  
	  matched =
		%r{
			(?<year>
			(^            #no input before the start
			  [1-9]\d{3}  #a year cannot start from the zero
			)
		  )
		  (?<month>
			(0[1-9])      #a month can start from the zero
			|
			(1[0-2])      #or it could be just 10, 11 or 12 of course
		  )
		  (?<day>
			(0[1-9])      #a day can start from the zero
			|(1[0-9])     #or should fall into the range [1..31]
			|(2[0-9])
			|30
			|31
		  )$              #marks there should be the end of the input
		}x.match(aDate)

		if (matched)
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
	 

	def sprawdzDate
		@date = @data
		checkDateUpdated(@date) ? wynik = "tak" : wynik= "nie"
		if wynik == "tak"
			analiza
		else
			print "Podana data jest #{checkDateUpdated(@date) ? "" : "nie"}poprawna! \n"
		end
	end
	def wczytajSlownik
		@dictionary=[]
		@dictionary = File.open('slowa.txt', 'r'){|file| file.readlines.collect{|line|line.chomp}}
	end
	def analiza
		puts "Dziękuję. Trwa analiza..."
		wczytajSlownik

		puts "Twoja data w innych systemach:"
		konwertujNaRozneSystemy	
		znajdzWSlowniku
	end
	def konwertujNaRozneSystemy
		@nazwa = [] 
		for i in (11..36)
			@nazwa[i] = @date.to_i.to_s(i) 
			puts @nazwa[i] 
		end
	end
	def znajdzWSlowniku
		for k in (11..36)
			for l in (0..2965376)
				if @nazwa[k].to_s == @dictionary[l].to_s
					@se = @nazwa[k] 
				end
			end
		end
		if @se.length > 0 
			puts "Po konwersji Twojej daty znaleziono następujące słowa: "
			puts @se 
		else 
			puts "Niestety, nie odnaleziono żadnych słów."
		end
	end

end