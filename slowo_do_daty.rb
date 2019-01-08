class SlowoDoDaty																							# utworzenie klasy 
	@dzien =0 																								  # utworzenie atrybutów dla dnia, miesiąca i roku
	@miesiac=0																									# 
	@rok =0                                                     # 
	def initialize(data) 																				# zainicjowanie metody
	@data = data 
	end
	$ileMiesiacMaDni=[31,28,31,30,31,30,31,31,30,31,30,31]			# utworzenie tablicy z liczbami dni w posczególnych miesiącach

	def przeliczSlowoNaDate(tmp)																# definicja metody zamieniającej słowo na datę
	  slowo = tmp.to_i(36)																				# konwersja
	  @rok = (slowo-(slowo%10000))/10000													# rok = pozostałe znaki
	  @dzien=slowo%100																						# dzień = dwa ostatnie znaki
	  @miesiac=(slowo%10000-@dzien)/100												  	# mieisąc = trzeci i czwarty znak od końca 
	  
	  # FOR DEBUG PURPOSES																			# testowe wypisywanie zmiennych 
	  #puts @dzien
	  #puts @miesiac
	  #puts @rok
	end

	def zwalidujMiesiac(argMiesiac)															# definicja metody sprawdzającej czy miesiąc jest poprawny 
	  if argMiesiac == 0																					# jeżeli mieisąc = 0
		@miesiac = 12																								# zamienia miesiac na grudzień
		@rok = @rok - 1																					  	# odejmuje rok 
	  end
	end
	
	def zwalidujDzien(argDzien)																	# definicja metody sprawdzającej czy dzień jest poprawny 
	  if argDzien == 0																						# jeżeli dzien = 0
		@miesiac = ileMiesiacMaDni[@miesiac%12-1]										# cofnij o jeden miesiąc (sprawdzając ile ma dni)
		@miesiac = @miesiac - 1																			#				
		zwalidujMiesiac(@Miesiac)																		# ponowne sprawdzenie poprawności miesiąca
	  end
	end

	def zwalidujDate																						# definicja metody sprawdzającej datę
	  zwalidujMiesiac(@Miesiac)																  	# wywołanie metody sprawdzania miesiąca
	  zwalidujDzien(@Dzien) 																			# wywołanie metody sprawdzenia dnia

	  while (@dzien > $ileMiesiacMaDni[@miesiac%12-1]) do 			  # tworzenie poprawnej daty
		@dzien = @dzien - $ileMiesiacMaDni[@miesiac%12-1]
		@miesiac = @miesiac+ 1
	  end
	  @rok = @rok + @miesiac/12
	  @miesiac = @miesiac%12
	end
	
	def procesujSlowo																							# definicja metody składającej datę
		przeliczSlowoNaDate(@data)																		# wywołanie metody przeliczania  
		zwalidujDate																									# wywołanie metody walidującej
	end
	
	def wypiszPoprawnaDate																			 # definicja metody wypisującej poprawioną datę
	   data_poprawna=@rok*10000+@miesiac*100+@dzien 								
	   puts data_poprawna
	end
end