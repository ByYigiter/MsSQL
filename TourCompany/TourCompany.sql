/*--Tour Company Projesi
--Bu dok�man geli�tirilecek Tour Company adl� uygulaman�n analizini i�ermektedir. Projenin amac� turizm sekt�r�nde hizmet veren Tour Company isimli firman�n organizasyonunu 
	y�netebilmesidir.
	--Tour Company isimli �irket, �stanbul�un �e�itli yerlerini rehberler e�li�inde turistlere gezdiren ve tan�tan bir �irkettir. D�zenledi�i turlar g�n�birlik turlard�r.
	--Uygulama ile d�zenlenen turlar belirlenecek, belirlenen turlar�n sat��� yap�labilecektir. �irketle �al��an rehberler de uygulama �zerinde tan�mlanabilecektir.
	--� Uygulamay� sadece �irket yetkilisi kullanacakt�r.
	--� Uygulama �zerinde tur �irketinin hizmet verdi�i b�lgeler tan�mlanmal�d�r. �irket yetkilisi tur tan�mlamas� yaparken gezilecek b�lgeleri se�ecektir.
	--� �irket farkl� kanallardan yapt��� sat��lar� da uygulama �zerinden sisteme girecektir.
	--� Turlara kat�lacak turistlerin bilgileri girilecek ve ard�ndan fatura olu�turulacakt�r.
	--� �irket tur sat���n� uygulamaya girerken �al��t��� rehberlerden birini se�ecektir.

Kullan�m Senaryolar�

Tur Tan�mlama

	�irket yetkilisi tur tan�mlamas� yaparken, sistemde kay�tl� hizmet verdi�i yerlerden en az 1, en fazla 3 tanesini se�ebilir. Tura bir isim vererek tan�mlamay� tamamlar.
		Tur ismi en fazla 150 karakter olabilir.
	Tur tan�mlayabilmek i�in �nceden hizmet verdi�i b�lgeleri sisteme girmelidir. �lgili ekrandan bu giri�leri yaparken b�lgenin ad�n� ve bu b�lge i�in verilecek 
		hizmetin �cretini belirtmelidir. Turun �creti de i�erdi�i b�lgelerin �cretlerinin toplam�d�r. 
		B�lge ad� en fazla 30 karakter olmal�d�r. B�lge �creti de min 20 TL�dir.
	�irket yetkilisi yeni b�lgeler girebilir, olan b�lgeleri silebilir. Ayr�ca b�lgeler i�in ge�erli hizmet �cretlerini de�i�tirebilir. 
		Sat��� yap�lmam�� turlar �zerinde de�i�iklik yapabilir veya turu iptal edebilir.

Tur Sat��� Yapma

	�irket yetkilisi ilgili ekran �zerinden tur sat��lar�n� sisteme girmelidir. Sat��� yap�lan turu ve bu tura kat�lacak turisti/turistleri belirtmelidir. 
		Turun ger�ekle�ece�i tarihi ve bu turda g�revlendirece�i rehberi de yine bu ekran �zerinden girmelidir.
	Turisti/turistleri belirtirken ad, soyad, cinsiyet, do�um tarihi, uyruk ve geldi�i �lke bilgilerini girmelidir. E�er daha �nce de tur satt��� bir turistse, 
		bu bilgileri tekrar girmemeli ve turisti sistemden bulup eklemelidir.
	Ad en fazla 20, soyad ise en fazla 40 karakter olmal�d�r.

Rehber Tan�mlama

	�irket �al��t��� rehberlerin kayd�n� sistemde tutacakt�r. �irket yetkilisi rehber ekleyebilir, rehber bilgilerini d�zenleyebilir ve 
		�al��may� sonland�rd��� rehberi sistemden kald�rabilir.
	Rehber eklerken ad, soyad, cinsiyet, telefon numaras� bilgilerini girmelidir. Rehberler en az bir yabanc� dil bilmektedir ve 
		sisteme eklenirken bu bilgi de tan�mlanmal�d�r. Rehberlerin hepsi hizmet verilen t�m b�lgeler hakk�nda bilgi sahibidir.
	Rehberlerin ad� en fazla 20, soyad� en fazla 40 karakter olmal�d�r.
Fatura Olu�turma

	Sat�� yetkilisi, turlar�n sat���n� sisteme girdikten sonra sat�n alan turist i�in fatura olu�turacakt�r. Bir turist ayn� anda birden fazla tur sat�n alabilir.
		Bu durumda her tur sat��� birer fatura kalemi olmal�d�r.
	Fatura �creti i�erdi�i turlar�n toplam �cretidir. Turlar�n �creti belirlenirken kat�lacak turistlerden 60 ya� �zeri olanlar i�in %15 indirim uygulan�r.
	Sat�� yetkilisi sistemde kay�tl� faturalar� g�r�nt�leyebilir. Fatura numaras�, fatura kesilme tarihi, faturan�n kesildi�i turist ve 
		toplam �cret bilgileri g�sterilmelidir. Fatura numaras� �FTR20220110001�, �FTR20220110002� �eklinde bir bilgidir.
		Yetkili istedi�i faturay� bu bilgi ile arayarak bulabilmelidir.
		*/
--Raporlar

	--�irket yetkilisi rapor ekran�ndan a�a��da listelenen raporlar�n sonucunu g�rmelidir.

	/*

--insert into tumveri values ('Levi',	  'Acevedo',	'Kad�n',	'06.11.91', 'Japanese',	'Italy',	 'Ozan Temiz',		7773204562, '11.01.12',  'Ayasofya, Yerebatan Sarn�c�')
--insert into tumveri values ('Basil',	  'Aguilar',	'Erkek',	'04.22.94', 'Greek',	'Greek',	 'Bahar Sevgin',	7773204563, '08.11.14',  'Pierre Loti, K�z Kulesi')
--insert into tumveri values ('Zenaida',  'Holder',		'Erkek',	'01.09.90', 'Finnish',	'Greek',	 '�mer U�ar',		7773204564, '02.04.14',  'Adalar, Ayasofya, Dolmabah�e Saray�')
--insert into tumveri values ('Illana',	  'Browning',	'Kad�n' ,	'01.28.91', 'Greek',	'English',	 'Sevgi �akmak',	7773204565, '05.01.14',  'Miniat�rk, Sultan Ahmet Cami')
--insert into tumveri values ('Raja' ,	  'Duke' ,		'Erkek',	'07.27.83', 'Dutch',	'Dutch' ,	 'Bahar Sevgin',	7773204563, '09.08.14',  'Rumeli Hisar�')
--insert into tumveri values ('Isaiah',	  'Valdez',		'Erkek',	'01.16.98', 'Finnish',	'Finnish',	 'Ozan Temiz',		7773204562, '08.28.12',  'Dolmabah�e Saray�, M�s�r �ar��s�')
--insert into tumveri values ('Gray' ,	  'Marshall',	'Kad�n',	'11.21.80', 'Japanese', 'Japanese',  'Linda Callahan',	7773204566, '08.27.13',  'Rumeli Hisar�, K�z Kulesi')
--insert into tumveri values ('Ora' ,	  'Fletcher',	'Kad�n',	'01.19.94', 'English' ,	'English' ,	 'Bahar Sevgin',	7773204563, '08.23.14',  'Anadolu Hisar�, Ey�p Sultan Camii')
--insert into tumveri values ('Lavinia',  'Lloyd',		'Kad�n',	'10.26.86', 'English',	'English',	 'Ozan Temiz',		7773204562, '03.26.12',  'Pierre Loti, K�z Kulesi')
--insert into tumveri values ('Jenna' ,	  'Williams',	'Kad�n',	'05.01.82', 'Greek',	'Greek',	 '�mer U�ar' ,		7773204564, '11.26.14',  'Atat�rk Arboretumu, Dolmabah�e Saray�')
--insert into tumveri values ('Christian','Nash' ,		'Erkek',	'08.09.80', 'English',	'English',	 '�mer U�ar',		7773204564, '02.15.13',  'Kapal��ar��, M�s�r �ar��s�')
--insert into tumveri values ('Basil' ,	  'Aguilar' ,	'Erkek',	'04.22.94', 'Greek',	'Greek' ,	 'Ozan Temiz',		7773204562, '09.09.14',  'Atat�rk Arboretumu')
--insert into tumveri values ('Brianna',  'Everett',	'Erkek',	'09.03.78', 'Japanese', 'Japanese' , 'Bahar Sevgin',	7773204563, '04.19.13',  'Pierre Loti, K�z Kulesi')
--insert into tumveri values ('Geoffrey', 'Knowles',	'Erkek' ,	'02.17.85', 'Ukrainian','Ukrainian', 'Linda Callahan',	7773204566, '01.26.14',  'M�s�r �ar��s�, Atat�rk Arboretumu')
--insert into tumveri values ('Quinn' ,	  'Hamilton',	'Erkek' ,	'07.10.90', 'English',	'English' ,	 'Sevgi �akmak',	7773204565, '12.04.13',  'Miniat�rk, K�z Kulesi')
select * from TumVeri
delete from Tumveri
*/
/*
select * from satis
insert into satis values (2,2,1,1)
insert into satis values (3,3,2,2)
insert into satis values (4,4,4,4)
insert into satis values (5,5,5,2)
insert into satis values (6,6,6,1)
insert into satis values (7,7,7,5)
insert into satis values (8,8,8,2)
insert into satis values (9,9,9,1)
insert into satis values (10,10,10,3)
insert into satis values (11,11,11,3)
insert into satis values (12,12,12,1)
insert into satis values (13,13,13,2)
insert into satis values (14,14,14,5)
insert into satis values (15,15,15,3)

*/

/*
--insert into Turist values (1,'Levi',		'Acevedo',	 'Kad�n',	'06.11.91', 'Japanese',	'Italy'	)
--insert into Turist values (2,'Basil',	'Aguilar',	 'Erkek',	'04.22.94', 'Greek',	'Greek'		)
--insert into Turist values (3,'Zenaida',	'Holder',	 'Erkek',	'01.09.90', 'Finnish',	'Greek' 	)
--insert into Turist values (4,'Illana',	'Browning',	 'Kad�n' ,	'01.28.91', 'Greek',	'English'	)
--insert into Turist values (5,'Raja' ,	'Duke' ,	 'Erkek',	'07.27.83', 'Dutch',	'Dutch' 	)
--insert into Turist values (6,'Isaiah',	'Valdez',	 'Erkek',	'01.16.98', 'Finnish',	'Finnish'	)
--insert into Turist values (7,'Gray' ,	'Marshall',	 'Kad�n',	'11.21.80', 'Japanese', 'Japanese'  )
--insert into Turist values (8,'Ora' ,		'Fletcher',	 'Kad�n',	'01.19.94', 'English' ,	'English')
--insert into Turist values (9,'Lavinia',	'Lloyd',	 'Kad�n',	'10.26.86', 'English',	'English'	)
--insert into Turist values (10,'Jenna' ,	'Williams',	 'Kad�n',	'05.01.82', 'Greek',	'Greek' 	)
--insert into Turist values (11,'Christian','Nash' ,	 'Erkek',	'08.09.80', 'English',	'English'	)
--insert into Turist values (12,'Basil' ,	'Aguilar' ,	 'Erkek',	'04.22.94', 'Greek',	'Greek'  	)
--insert into Turist values (13,'Brianna' ,	'Everett',	 'Erkek',	'09.03.78', 'Japanese', 'Japanese')
--insert into Turist values (14,'Geoffrey',	'Knowles',	 'Erkek' ,	'02.17.85', 'Ukrainian','Ukrainian')
--insert into Turist values (15,'Quinn' ,	'Hamilton',	 'Erkek' ,	'07.10.90', 'English',	'English' 	)
	select * from Turist
*/

/*
insert into rehber values (1,'Ozan',	'Temiz',	'Erkek', 7773204562,  'English')
insert into rehber values (2,'Bahar',	'Sevgin',	'Kad�n', 7773204563,  'English')
insert into rehber values (3,'�mer',	'U�ar',		'Erkek', 7773204564,  'English')
insert into rehber values (4,'Sevgi',	'�akmak',	'Kad�n', 7773204565,  'English')
insert into rehber values (5,'Linda',	'Callahan',	'Kad�n', 7773204566,  'English')
select * from rehber
*/

/*
insert into GidilecekYer values(1,'Ayasofya'			,'20.00')
insert into GidilecekYer values(2,'Yerebatan Sarn�c�'	,'50.00')
insert into GidilecekYer values(3,'Pierre Loti'			,'50.00')
insert into GidilecekYer values(4,'K�z Kulesi'			,'50.00')
insert into GidilecekYer values(5,'Adalar'				,'100.00')
insert into GidilecekYer values(6,'Dolmabah�e Saray�'	,'100.00')
insert into GidilecekYer values(7,'Miniat�rk'			,'150.00')
insert into GidilecekYer values(8,'Sultan Ahmet Cami'	,'20.00')
insert into GidilecekYer values(9,'Rumeli Hisar�'		,'70.00')
insert into GidilecekYer values(10,'M�s�r �ar��s�'		,'20.00')
insert into GidilecekYer values(11,'Anadolu Hisar�'		,'100.00')
insert into GidilecekYer values(12,'Ey�p Sultan Camii'	,'20.00')
insert into GidilecekYer values(13,'Atat�rk Arboretumu'	,'100.00')
insert into GidilecekYer values(14,'Kapal��ar��'		,'20.00')
select * from gidilecekyer		   
delete from gidilecekyer

*/

/*
select * from Tur
	
 ('11.01.12',	'Ayasofya, Yerebatan Sarn�c�')
 ('08.11.14',   'Pierre Loti, K�z Kulesi')
 ('02.04.14',   'Adalar, Ayasofya, Dolmabah�e Saray�')
 ('05.01.14',   'Miniat�rk, Sultan Ahmet Cami')
 ('09.08.14',   'Rumeli Hisar�')
 ('08.28.12',   'Dolmabah�e Saray�, M�s�r �ar��s�')
 ('08.27.13',   'Rumeli Hisar�, K�z Kulesi')
 ('08.23.14',   'Anadolu Hisar�, Ey�p Sultan Camii')
 ('03.26.12',   'Pierre Loti, K�z Kulesi')
 ('11.26.14',   'Atat�rk Arboretumu, Dolmabah�e Saray�')
 ('02.15.13',   'Kapal��ar��, M�s�r �ar��s�')
 ('09.09.14',   'Atat�rk Arboretumu')
 ('04.19.13',   'Pierre Loti, K�z Kulesi')
 ('01.26.14',   'M�s�r �ar��s�, Atat�rk Arboretumu')
 ('12.04.13',   'Miniat�rk, K�z Kulesi')

*/

							

