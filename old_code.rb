puts "WITAJ W ANALIZATORZE DAT! "                         # ekran powtalny
puts "Z której opcji chcesz skorzystać?"                  # prośba o wprowadzenie informacji o opcji z której użytkownik chce skorzystać
puts " 1 - konwersja daty na słowa"                       #
puts " 2 - konwersja słowa na datę"                       #

abc = gets                                                # pobranie od użytkownika informacji o tym, z której opcji chce skorzystać
abc = abc.chomp                                           # usunięcie ze stringa znaku końca linii (bug Windowsa)
if abc.to_s == "1"                                        # instrukcje do wykonania kiedy użytkownik wybrał opcję "1" - konwersja daty na słowo

puts "Podaj swoją datę urodzenia"  	                      # prośba o wprowadzenie daty 

data = gets 				                                      # pobranie daty od użytkownika
def checkDateUpdated(aDate)		                            # definicja funkcji sprawdzania poprawności daty - tylko poprawne daty będą konwertowane
  matched =                                               # tworzenie schematu do którego musi dopasować się data
    %r{
        (?<year>
        (^                                                  # nie powinno być ż adnego znaku przez rozpoczęciem
          [1-9]\d{3}                                        # rok nie może zaczynać się od zera
        )
      )
      (?<month>
        (0[1-9])                                            # miesiąc może zaczynać się od zera, jednak na drugim miejscu zera być nie może
        |
        (1[0-2])                                            # lub miesiąc może być 10, 11 lub 12
      )
      (?<day>
        (0[1-9])                                            # dzień może zaczynać się od zera, jednak na drugim miejscu zera być nie może
        |(1[0-9])                                           # lub powiniec mieścić się w przedziale od 10 do 31
        |(2[0-9])                                           #
        |30                                                 #      
        |31
      )$              
    }x.match(aDate)                                       # wprowadzana data jest analizowana ze schematem

    if (matched)                                          # jeżeli data pasuje do schematu wykonywane są dalsze instrukcje
      day, month, year = matched[:day], matched[:month], matched[:year]
      day = day[-1] if day[0] == "0"        
      month = month[-1] if month[0] == "0"  

      year, month, day = year.to_i, month.to_i, day.to_i

      require 'date'
      begin
        date = Date.new(year, month, day)                #stworzenie zmiennej date zawierającej datę
      rescue ArgumentError => e
       
	return false
      end
      true
    else
      false
    end
end
 
date = data                                              # przypisanie daty wprowadzonej przez użytkownika do zmiennej date

checkDateUpdated(date) ? wynik = "tak" : wynik= "nie"    # uruchomienie funkcji sprawdzenia poprawności podanej daty oraz przekazanie parametru wynik
if wynik == "tak"
puts "Dziękuję. Trwa analiza..."

dictionary=[]                                            # utworzenie pustej tablicy dla słownika oraz wpisanie słownika z pliku do tablicy (z pominięciem \n)
dictionary = File.open('slowa.txt', 'r'){|file| file.readlines.collect{|line|line.chomp}}
puts "Twoja data w innych systemach:" 

inter = data.to_i
nazwa = [] 

for j in (0..10)                                         # dla systemów o podstawie niższej niż 11 wpisywane jest automatycznie 0 (nie ma tam słów)
  nazwa[j] = "0"
end
for i in (11..36)                                        # dla systemów o podstawach od 11 do 36  data jest konwertoana i wpisywana do tablicy
nazwa[i] = inter.to_s(i) 
puts nazwa[i]                                            # tablica jest wypisywana

end
puts "Szukam słów w słowniku..."
se=[]                                                    # utworzenie pustej tablicy dla znalezionych duplikatów w obu tablicach

for k in (11..36)                                        # porównywanie każego elementu tablicy z przekonwertowanymi datami do kolejnych elementów słownika
  for l in (0..2965376)                                  
  if nazwa[k].to_s == dictionary[l].to_s
  se = nazwa[k]                                          # wpisywnaie znalezionych duplikatów do tablicy
  end
end
end

if se.length > 0                                         # jeżeli tablica nie jest pusta - zostaje wyświetlona

puts "Po konwersji Twojej daty znaleziono następujące słowa: "
puts se 
else                                                     # jeżeli tablica jest pusta - zostaje wyswietlony komunikat
puts "Niestety, nie odnaleziono żadnych słów."
end

else                                                     # jeżeli wprowadzona przez użytkownika data była niepoprawna - pojawia się komunikat   
print "Podana data jest #{checkDateUpdated(date) ? "" : "nie"}poprawna! \n"
system ('ruby valid.rb')                                 # program jest restartowany 
end 

elsif abc.to_s == "2"                                    # jeżeli uzytkownik wybrał opcję "2" - konwersja słów na daty 
puts "Podaj słowo do konwersji: "
  wslowo = gets                                          # pobranie od uzytkownika slowa
  daysInMonth=[31,28,31,30,31,30,31,31,30,31,30,31]      # tablica z liczbą dni w poszczególnych miesiącach

  slowo=wslowo.to_i(36)                                  # konwersja słowa 
  rok=(slowo-(slowo%10000))/10000                        # 
  
   dzien=slowo%100                                       # ostatnie dwa znaki reprezentują dzień
   miesiac=(slowo%10000-dzien)/100                        
  
  if miesiac == 0                                        # jeżeli miesiąc po obliczeniach = 0, zamień na grudzień i odejmij rok
    miesiac = 12
    rok=rok-1
  end
  
  if dzien == 0                                          # jeżeli dzień po obliczeniach = 0, sprawdz ile dni ma miesiąc, odejmij miesiąc, ustaw dzień 
    miesiac = daysInMonth[miesiac%12]
    miesiac=miesiac-1
    if miesiac == 0
      miesiac = 12
      rok=rok-1
    end
  end
  while (dzien > daysInMonth[miesiac%12]) do             # przeliczanie dni na dodatkowe miesiące (z uwzględnieniem ilości dni w danym miesiącu)
    dzien= dzien - daysInMonth[miesiac%12]
    miesiac = miesiac+ 1
  end
  ile_dodac_lat = miesiac/12                             # obliczenie o ile lat należy zwiększyć rok
  miesiac = miesiac%12                                   # obliczenie miesiąca
  rok= rok+ ile_dodac_lat                                # obliczanie roku 

  data_poprawna=rok*10000+miesiac*100+dzien              # utworzenie liczby reprezentującej poprawny kod
  puts "Podane slowo w postaci daty: "                   # wypisanie daty 
  puts data_poprawna                                     # 

else
  puts "Błędny wybór"                                    # jeżeli użytkownik wprowadził błędny znak przy wyborze opcji 
  system ('ruby valid.rb')                               # program jest uruchamiany od nowa 
end 