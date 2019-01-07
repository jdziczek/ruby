require 'set'
puts "WITAJ W ANALIZATORZE DAT! "
puts "Z której opcji chcesz skorzystać?"
puts " 1 - konwersja daty na słowa" 
puts " 2 - konwersja słowa na datę" 

abc = gets 
abc = abc.chomp
if abc.to_s == "1"

puts "Podaj swoją datę urodzenia"  	#communicate

data = gets 				#getting date of birth from user
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
 
date = data

checkDateUpdated(date) ? wynik = "tak" : wynik= "nie" 
if wynik == "tak"
puts "Dziękuję. Trwa analiza..."

dictionary=[]
dictionary = File.open('slowa.txt', 'r'){|file| file.readlines.collect{|line|line.chomp}}
puts "Twoja data w innych systemach:" 

inter = data.to_i
nazwa = [] 

for j in (0..10)
  nazwa[j] = "0"
end
for i in (11..36)
nazwa[i] = inter.to_s(i) 
puts nazwa[i] 

end

se=[]

for k in (11..36)
  for l in (0..2965376)
  if nazwa[k].to_s == dictionary[l].to_s
  se = nazwa[k] 
  end
end
end

puts "Po konwersji Twojej daty znaleziono następujące słowa: "
puts se 

else
print "Podana data jest #{checkDateUpdated(date) ? "" : "nie"}poprawna! \n"
system ('ruby valid.rb') 
end 

elsif abc.to_s == "2"
data = gets
  daysInMonth=[31,28,31,30,31,30,31,31,30,31,30,31]

  slowo=data.to_i(36)
  rok=(slowo-(slowo%10000))/10000
  
  puts dzien=slowo%100
  puts miesiac=(slowo%10000-dzien)/100
  
  if miesiac == 0
    miesiac = 12
    rok=rok-1
  end
  
  if dzien == 0
    miesiac = daysInMonth[miesiac%12]
    miesiac=miesiac-1
    if miesiac == 0
      miesiac = 12
      rok=rok-1
    end
  end
  while (dzien > daysInMonth[miesiac%12]) do 
    dzien= dzien - daysInMonth[miesiac%12]
    miesiac = miesiac+ 1
  end
  ile_dodac_lat = miesiac/12
  miesiac = miesiac%12
  rok= rok+ ile_dodac_lat 

  data_poprawna=rok*10000+miesiac*100+dzien 
  puts data_poprawna

else
  puts "Błędny wybór"

end 