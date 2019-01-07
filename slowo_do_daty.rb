class SlowoDoDaty
	@dzien =0 
	@miesiac=0
	@rok =0
	def initialize(data)
	@data = data 
	end
	$ileMiesiacMaDni=[31,28,31,30,31,30,31,31,30,31,30,31]

	def przeliczSlowoNaDate(tmp)
	  slowo = tmp.to_i(36)
	  @rok = (slowo-(slowo%10000))/10000
	  @dzien=slowo%100
	  @miesiac=(slowo%10000-@dzien)/100
	  
	  # FOR DEBUG PURPOSES
	  #puts @dzien
	  #puts @miesiac
	  #puts @rok
	end
	
	#/* sprawdza czy przypadkiem miesiac nie jest zero */
	def zwalidujMiesiac(argMiesiac)
	  if argMiesiac == 0
		@miesiac = 12
		@rok = @rok - 1
	  end
	end
	
	#/* sprawdza czy przypadkiem dzien nie jest zero */
	def zwalidujDzien(argDzien)
	  if argDzien == 0
		@miesiac = ileMiesiacMaDni[@miesiac%12-1]
		@miesiac = @miesiac - 1
		zwalidujMiesiac(@Miesiac)
	  end
	end
	#/* poprawia date do formatu  */
	def zwalidujDate
	  zwalidujMiesiac(@Miesiac)
	  zwalidujDzien(@Dzien)

	  while (@dzien > $ileMiesiacMaDni[@miesiac%12-1]) do 
		@dzien = @dzien - $ileMiesiacMaDni[@miesiac%12-1]
		@miesiac = @miesiac+ 1
	  end
	  @rok = @rok + @miesiac/12
	  @miesiac = @miesiac%12
	end
	
	def procesujSlowo
		przeliczSlowoNaDate(@data)
		zwalidujDate
	end
	
	def wypiszPoprawnaDate
	   data_poprawna=@rok*10000+@miesiac*100+@dzien 
	   puts data_poprawna
	end
end