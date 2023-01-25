/*--Tour Company Projesi
--Bu doküman geliþtirilecek Tour Company adlý uygulamanýn analizini içermektedir. Projenin amacý turizm sektöründe hizmet veren Tour Company isimli firmanýn organizasyonunu 
	yönetebilmesidir.
	--Tour Company isimli þirket, Ýstanbul’un çeþitli yerlerini rehberler eþliðinde turistlere gezdiren ve tanýtan bir þirkettir. Düzenlediði turlar günübirlik turlardýr.
	--Uygulama ile düzenlenen turlar belirlenecek, belirlenen turlarýn satýþý yapýlabilecektir. Þirketle çalýþan rehberler de uygulama üzerinde tanýmlanabilecektir.
	--• Uygulamayý sadece þirket yetkilisi kullanacaktýr.
	--• Uygulama üzerinde tur þirketinin hizmet verdiði bölgeler tanýmlanmalýdýr. Þirket yetkilisi tur tanýmlamasý yaparken gezilecek bölgeleri seçecektir.
	--• Þirket farklý kanallardan yaptýðý satýþlarý da uygulama üzerinden sisteme girecektir.
	--• Turlara katýlacak turistlerin bilgileri girilecek ve ardýndan fatura oluþturulacaktýr.
	--• Þirket tur satýþýný uygulamaya girerken çalýþtýðý rehberlerden birini seçecektir.

Kullaným Senaryolarý

Tur Tanýmlama

	Þirket yetkilisi tur tanýmlamasý yaparken, sistemde kayýtlý hizmet verdiði yerlerden en az 1, en fazla 3 tanesini seçebilir. Tura bir isim vererek tanýmlamayý tamamlar.
		Tur ismi en fazla 150 karakter olabilir.
	Tur tanýmlayabilmek için önceden hizmet verdiði bölgeleri sisteme girmelidir. Ýlgili ekrandan bu giriþleri yaparken bölgenin adýný ve bu bölge için verilecek 
		hizmetin ücretini belirtmelidir. Turun ücreti de içerdiði bölgelerin ücretlerinin toplamýdýr. 
		Bölge adý en fazla 30 karakter olmalýdýr. Bölge ücreti de min 20 TL’dir.
	Þirket yetkilisi yeni bölgeler girebilir, olan bölgeleri silebilir. Ayrýca bölgeler için geçerli hizmet ücretlerini deðiþtirebilir. 
		Satýþý yapýlmamýþ turlar üzerinde deðiþiklik yapabilir veya turu iptal edebilir.

Tur Satýþý Yapma

	Þirket yetkilisi ilgili ekran üzerinden tur satýþlarýný sisteme girmelidir. Satýþý yapýlan turu ve bu tura katýlacak turisti/turistleri belirtmelidir. 
		Turun gerçekleþeceði tarihi ve bu turda görevlendireceði rehberi de yine bu ekran üzerinden girmelidir.
	Turisti/turistleri belirtirken ad, soyad, cinsiyet, doðum tarihi, uyruk ve geldiði ülke bilgilerini girmelidir. Eðer daha önce de tur sattýðý bir turistse, 
		bu bilgileri tekrar girmemeli ve turisti sistemden bulup eklemelidir.
	Ad en fazla 20, soyad ise en fazla 40 karakter olmalýdýr.

Rehber Tanýmlama

	Þirket çalýþtýðý rehberlerin kaydýný sistemde tutacaktýr. Þirket yetkilisi rehber ekleyebilir, rehber bilgilerini düzenleyebilir ve 
		çalýþmayý sonlandýrdýðý rehberi sistemden kaldýrabilir.
	Rehber eklerken ad, soyad, cinsiyet, telefon numarasý bilgilerini girmelidir. Rehberler en az bir yabancý dil bilmektedir ve 
		sisteme eklenirken bu bilgi de tanýmlanmalýdýr. Rehberlerin hepsi hizmet verilen tüm bölgeler hakkýnda bilgi sahibidir.
	Rehberlerin adý en fazla 20, soyadý en fazla 40 karakter olmalýdýr.
Fatura Oluþturma

	Satýþ yetkilisi, turlarýn satýþýný sisteme girdikten sonra satýn alan turist için fatura oluþturacaktýr. Bir turist ayný anda birden fazla tur satýn alabilir.
		Bu durumda her tur satýþý birer fatura kalemi olmalýdýr.
	Fatura ücreti içerdiði turlarýn toplam ücretidir. Turlarýn ücreti belirlenirken katýlacak turistlerden 60 yaþ üzeri olanlar için %15 indirim uygulanýr.
	Satýþ yetkilisi sistemde kayýtlý faturalarý görüntüleyebilir. Fatura numarasý, fatura kesilme tarihi, faturanýn kesildiði turist ve 
		toplam ücret bilgileri gösterilmelidir. Fatura numarasý “FTR20220110001”, “FTR20220110002” þeklinde bir bilgidir.
		Yetkili istediði faturayý bu bilgi ile arayarak bulabilmelidir.
		*/
--Raporlar

	--Þirket yetkilisi rapor ekranýndan aþaðýda listelenen raporlarýn sonucunu görmelidir.

	/*

--insert into tumveri values ('Levi',	  'Acevedo',	'Kadýn',	'06.11.91', 'Japanese',	'Italy',	 'Ozan Temiz',		7773204562, '11.01.12',  'Ayasofya, Yerebatan Sarnýcý')
--insert into tumveri values ('Basil',	  'Aguilar',	'Erkek',	'04.22.94', 'Greek',	'Greek',	 'Bahar Sevgin',	7773204563, '08.11.14',  'Pierre Loti, Kýz Kulesi')
--insert into tumveri values ('Zenaida',  'Holder',		'Erkek',	'01.09.90', 'Finnish',	'Greek',	 'Ömer Uçar',		7773204564, '02.04.14',  'Adalar, Ayasofya, Dolmabahçe Sarayý')
--insert into tumveri values ('Illana',	  'Browning',	'Kadýn' ,	'01.28.91', 'Greek',	'English',	 'Sevgi Çakmak',	7773204565, '05.01.14',  'Miniatürk, Sultan Ahmet Cami')
--insert into tumveri values ('Raja' ,	  'Duke' ,		'Erkek',	'07.27.83', 'Dutch',	'Dutch' ,	 'Bahar Sevgin',	7773204563, '09.08.14',  'Rumeli Hisarý')
--insert into tumveri values ('Isaiah',	  'Valdez',		'Erkek',	'01.16.98', 'Finnish',	'Finnish',	 'Ozan Temiz',		7773204562, '08.28.12',  'Dolmabahçe Sarayý, Mýsýr Çarþýsý')
--insert into tumveri values ('Gray' ,	  'Marshall',	'Kadýn',	'11.21.80', 'Japanese', 'Japanese',  'Linda Callahan',	7773204566, '08.27.13',  'Rumeli Hisarý, Kýz Kulesi')
--insert into tumveri values ('Ora' ,	  'Fletcher',	'Kadýn',	'01.19.94', 'English' ,	'English' ,	 'Bahar Sevgin',	7773204563, '08.23.14',  'Anadolu Hisarý, Eyüp Sultan Camii')
--insert into tumveri values ('Lavinia',  'Lloyd',		'Kadýn',	'10.26.86', 'English',	'English',	 'Ozan Temiz',		7773204562, '03.26.12',  'Pierre Loti, Kýz Kulesi')
--insert into tumveri values ('Jenna' ,	  'Williams',	'Kadýn',	'05.01.82', 'Greek',	'Greek',	 'Ömer Uçar' ,		7773204564, '11.26.14',  'Atatürk Arboretumu, Dolmabahçe Sarayý')
--insert into tumveri values ('Christian','Nash' ,		'Erkek',	'08.09.80', 'English',	'English',	 'Ömer Uçar',		7773204564, '02.15.13',  'Kapalýçarþý, Mýsýr Çarþýsý')
--insert into tumveri values ('Basil' ,	  'Aguilar' ,	'Erkek',	'04.22.94', 'Greek',	'Greek' ,	 'Ozan Temiz',		7773204562, '09.09.14',  'Atatürk Arboretumu')
--insert into tumveri values ('Brianna',  'Everett',	'Erkek',	'09.03.78', 'Japanese', 'Japanese' , 'Bahar Sevgin',	7773204563, '04.19.13',  'Pierre Loti, Kýz Kulesi')
--insert into tumveri values ('Geoffrey', 'Knowles',	'Erkek' ,	'02.17.85', 'Ukrainian','Ukrainian', 'Linda Callahan',	7773204566, '01.26.14',  'Mýsýr Çarþýsý, Atatürk Arboretumu')
--insert into tumveri values ('Quinn' ,	  'Hamilton',	'Erkek' ,	'07.10.90', 'English',	'English' ,	 'Sevgi Çakmak',	7773204565, '12.04.13',  'Miniatürk, Kýz Kulesi')
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
--insert into Turist values (1,'Levi',		'Acevedo',	 'Kadýn',	'06.11.91', 'Japanese',	'Italy'	)
--insert into Turist values (2,'Basil',	'Aguilar',	 'Erkek',	'04.22.94', 'Greek',	'Greek'		)
--insert into Turist values (3,'Zenaida',	'Holder',	 'Erkek',	'01.09.90', 'Finnish',	'Greek' 	)
--insert into Turist values (4,'Illana',	'Browning',	 'Kadýn' ,	'01.28.91', 'Greek',	'English'	)
--insert into Turist values (5,'Raja' ,	'Duke' ,	 'Erkek',	'07.27.83', 'Dutch',	'Dutch' 	)
--insert into Turist values (6,'Isaiah',	'Valdez',	 'Erkek',	'01.16.98', 'Finnish',	'Finnish'	)
--insert into Turist values (7,'Gray' ,	'Marshall',	 'Kadýn',	'11.21.80', 'Japanese', 'Japanese'  )
--insert into Turist values (8,'Ora' ,		'Fletcher',	 'Kadýn',	'01.19.94', 'English' ,	'English')
--insert into Turist values (9,'Lavinia',	'Lloyd',	 'Kadýn',	'10.26.86', 'English',	'English'	)
--insert into Turist values (10,'Jenna' ,	'Williams',	 'Kadýn',	'05.01.82', 'Greek',	'Greek' 	)
--insert into Turist values (11,'Christian','Nash' ,	 'Erkek',	'08.09.80', 'English',	'English'	)
--insert into Turist values (12,'Basil' ,	'Aguilar' ,	 'Erkek',	'04.22.94', 'Greek',	'Greek'  	)
--insert into Turist values (13,'Brianna' ,	'Everett',	 'Erkek',	'09.03.78', 'Japanese', 'Japanese')
--insert into Turist values (14,'Geoffrey',	'Knowles',	 'Erkek' ,	'02.17.85', 'Ukrainian','Ukrainian')
--insert into Turist values (15,'Quinn' ,	'Hamilton',	 'Erkek' ,	'07.10.90', 'English',	'English' 	)
	select * from Turist
*/

/*
insert into rehber values (1,'Ozan',	'Temiz',	'Erkek', 7773204562,  'English')
insert into rehber values (2,'Bahar',	'Sevgin',	'Kadýn', 7773204563,  'English')
insert into rehber values (3,'Ömer',	'Uçar',		'Erkek', 7773204564,  'English')
insert into rehber values (4,'Sevgi',	'Çakmak',	'Kadýn', 7773204565,  'English')
insert into rehber values (5,'Linda',	'Callahan',	'Kadýn', 7773204566,  'English')
select * from rehber
*/

/*
insert into GidilecekYer values(1,'Ayasofya'			,'20.00')
insert into GidilecekYer values(2,'Yerebatan Sarnýcý'	,'50.00')
insert into GidilecekYer values(3,'Pierre Loti'			,'50.00')
insert into GidilecekYer values(4,'Kýz Kulesi'			,'50.00')
insert into GidilecekYer values(5,'Adalar'				,'100.00')
insert into GidilecekYer values(6,'Dolmabahçe Sarayý'	,'100.00')
insert into GidilecekYer values(7,'Miniatürk'			,'150.00')
insert into GidilecekYer values(8,'Sultan Ahmet Cami'	,'20.00')
insert into GidilecekYer values(9,'Rumeli Hisarý'		,'70.00')
insert into GidilecekYer values(10,'Mýsýr Çarþýsý'		,'20.00')
insert into GidilecekYer values(11,'Anadolu Hisarý'		,'100.00')
insert into GidilecekYer values(12,'Eyüp Sultan Camii'	,'20.00')
insert into GidilecekYer values(13,'Atatürk Arboretumu'	,'100.00')
insert into GidilecekYer values(14,'Kapalýçarþý'		,'20.00')
select * from gidilecekyer		   
delete from gidilecekyer

*/

/*
select * from Tur
	
 ('11.01.12',	'Ayasofya, Yerebatan Sarnýcý')
 ('08.11.14',   'Pierre Loti, Kýz Kulesi')
 ('02.04.14',   'Adalar, Ayasofya, Dolmabahçe Sarayý')
 ('05.01.14',   'Miniatürk, Sultan Ahmet Cami')
 ('09.08.14',   'Rumeli Hisarý')
 ('08.28.12',   'Dolmabahçe Sarayý, Mýsýr Çarþýsý')
 ('08.27.13',   'Rumeli Hisarý, Kýz Kulesi')
 ('08.23.14',   'Anadolu Hisarý, Eyüp Sultan Camii')
 ('03.26.12',   'Pierre Loti, Kýz Kulesi')
 ('11.26.14',   'Atatürk Arboretumu, Dolmabahçe Sarayý')
 ('02.15.13',   'Kapalýçarþý, Mýsýr Çarþýsý')
 ('09.09.14',   'Atatürk Arboretumu')
 ('04.19.13',   'Pierre Loti, Kýz Kulesi')
 ('01.26.14',   'Mýsýr Çarþýsý, Atatürk Arboretumu')
 ('12.04.13',   'Miniatürk, Kýz Kulesi')

*/

							

