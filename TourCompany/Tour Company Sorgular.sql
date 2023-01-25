--Raporlar

--1. En �ok gezilen yer/yerler neresidir? +++

		select top 1 BolgeId1,g.GidilecekYer,sum(GidilenYerler) as [Ziyaret Edilme Sayisi] 
		from (			select BolgeId1, count(*) as GidilenYerler from Tur group by BolgeId1  union all
						select BolgeId2, count(*) as GidilenYerler from Tur group by BolgeId2 union  all
						select BolgeId3, count(*) as GidilenYerler from Tur  group by BolgeId3 )
		as toplamSay� 
						join GidilecekYer g on g.BolgeId=toplamSay�.BolgeId1	
		where toplamSay�.BolgeId1 is not null 
		group by  toplamSay�.BolgeId1,g.GidilecekYer 
		order by [Ziyaret Edilme Sayisi] desc

		--select * from tur
				
				-- !!! ACIKLAMA 
				-- bu sorguda tur tablosunda 3 bolumde yer alan gidilecek yerleri 1 tablo yapmak i�in union all ile birle�tirme yapt�m
				-- sonra bana bolgeid nin isimlerini almak i�in GidilecekYer ile join i�lemi yapt�m
				-- bu sorgunun son k�sm�nda da bolge�d olarak gruplama yapt�m ve gidilenyerlerin sum ile toplama i�lemi ile toplam ziyaret say�s�ni ald�m
				-- en son [Ziyaret Edilme Sayisi] n� desc olarak s�ralama yapt�m ve top 1 ile en fazla olan� buldum
 	
--2. A�ustos ay�nda en �ok �al��an rehber/rehberler kimdir/kimlerdir? +++
		

		select top 1  r.Ad +' '+r.Soyad as [Austos'ta en fazla calisan] ,count (*) as Calisma_Sayisi   
		from rehber r join satis s on r.RehberId= s.RehberId
					  join Tur t on s.TurId= t.TurId
		where DATENAME(MONTH,t.TurTarihi)='august'
		group by r.Ad +' '+r.Soyad
		order by Calisma_Sayisi desc

				--!!! ACIKLAMA
				-- bu soruda Satis, Rehber ve Tur tablolar�n� join ile ba�lant� kurdum
				--sonra rehber isim soyisim olarak bir grup yapt�m bu gruptan bize rehberlerin hangi turlara rehber olarak kat�ld��� bilgsi gelir
				-- bende  rehber ile grup yaparak turlar�n say�lar�n� count ile ald�m sonra ko�ulu August olanlar diye filtreleme yapt�m
				-- en sonda ters s�ralama ile top 1 i ald�m 


--3. Kad�n turistlerin gezdi�i yerleri, toplam ziyaret edilme say�lar�yla beraber listeleyin +++
		-- 1 ad�m 
			-- bu k�s�mda kad�n turistler kimler ve hangi tura kat�lm��lar bolge isimleri neler liste olarak gormek i�in yap�lan sorgu
			select t.Ad,t.Soyad,t.Cinsiyet,tur.TurAdi,g1.GidilecekYer as [1 yer],g2.GidilecekYer as [2. yer]
			from Turist t join Satis s on t.TuristId =s.TuristId
								join Tur tur on s.TurId=tur.TurId
								join GidilecekYer g1 on g1.BolgeId =tur.BolgeId1
								join GidilecekYer g2 on g2.BolgeId =tur.BolgeId2
			where Cinsiyet='Kad�n' 

			--2 ad�m
			/* bu sorguda bir ge�ici tablo olu�turdum bu tabloda bolgeid, turid ve bolgeye gitmesay�s� olarak 3 column ekledim
			olu�turdu�um tablo ile turist,sat�� ve gidilecekyer tablolor�n� join i�lemi yapt�m
			ko�ul ile fitreleme yapt�mce en son gidilecekyere gore bir gruplama yaparak bolgelere(gidilecekyer)ziyaret say�lar�n� sum ile buldum
			buradaki ziyaret say�lar� Kad�nlar�n ziyaret ettikleri say�d�r
			
			*/

				select t.Cinsiyet,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Ziyaret sayilari] from turist t 
								join Satis s on s.TuristId =t.TuristId
								join ( 		select  newTablo.BolgeId1,COUNT(*) as gitmeSayisi,TurId from (
													select TurId, TurAdi,BolgeId1,TurTarihi from tur union
													select TurId, TurAdi,BolgeId2,TurTarihi from tur union
													select tur�d, TurAdi,BolgeId3,TurTarihi from tur)
											as newTablo
											where BolgeId1 is not null
											group by newTablo.BolgeId1,TurId ) tsayisi on tsayisi.TurId=s.TurId
								join GidilecekYer g on g.BolgeId=tsayisi.BolgeId1

				where t.Cinsiyet='Kad�n'
				group by g.GidilecekYer,t.Cinsiyet

				-- 3 ad�m burada 1 soruda elde etti�imiz toplam ziyaret say�lar�n� sutun olarak ekleme yapt�m
					-- hem toplam z�yaret hem de kad�nlar�n ziyaret say�lar�n� ayr� columnlarda 2 sorguyu join yaparak g�sterdim
					
				select new1.Cinsiyet,new1.GidilecekYer,new1.[Kad�nlar�n Ziyaret sayilari],new2.[Toplam Ziyaret Edilme Sayisi] 
				from ( select t.Cinsiyet,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Kad�nlar�n Ziyaret sayilari] 
						from turist t	join Satis s on s.TuristId =t.TuristId
										join ( 	select  new1.BolgeId1,COUNT(*) as gitmeSayisi,TurId 
												from (	select TurId, TurAdi,BolgeId1,TurTarihi from tur union
														select TurId, TurAdi,BolgeId2,TurTarihi from tur union
														select tur�d, TurAdi,BolgeId3,TurTarihi from tur  )
												as new1
												where BolgeId1 is not null
												group by new1.BolgeId1,TurId 
											  ) tsayisi on tsayisi.TurId=s.TurId
										join GidilecekYer g on g.BolgeId=tsayisi.BolgeId1
				where t.Cinsiyet='Kad�n'
				group by g.GidilecekYer,t.Cinsiyet
					 ) as new1 			
					join (	select  BolgeId1,g.GidilecekYer,sum(GidilenYerler) as [Toplam Ziyaret Edilme Sayisi] 
							from (	select BolgeId1, count(*) as GidilenYerler from Tur group by BolgeId1  union all
									select BolgeId2, count(*) as GidilenYerler from Tur group by BolgeId2 union  all
									select BolgeId3, count(*) as GidilenYerler from Tur  group by BolgeId3 
								 ) as toplamSay� 
							join GidilecekYer g on g.BolgeId=toplamSay�.BolgeId1	
							where toplamSay�.BolgeId1 is not null 
							group by  toplamSay�.BolgeId1,g.GidilecekYer 
						) as new2 on new2.GidilecekYer= new1.GidilecekYer
		

--4. �ngiltere�den gelip de K�z Kulesi�ni gezen turistler kimlerdir? +++
		
					select t.Ad,t.Soyad,t.GeldigiUlke,tur.TurAdi from turist t	
								join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
					where GeldigiUlke='English' and TurAdi  like '%k�z kulesi%'

					--!!! ACIKLAMA
					/* bu sorguda turist satis tur tablolor�n� join i�lemmi yapt�m sonra 2 ko�ul ile filtreleme yaparak turist bilgilerini ald�m
					
					*/


--5. Gezilen yerler hangi y�lda ka� defa gezilmi�tir? +++
		
	       -- select * from tur

			select year(TurTarihi) as ZiyaretYili,g.GidilecekYer,count(*) as ZiyaretSayisi
			from (	select bolgeId1,TurTarihi  from Tur union all  
					select bolgeId2,TurTarihi  from Tur union all
					select bolgeId3,TurTarihi  from Tur
						)
			as newTablo  
					join GidilecekYer g on g.BolgeId=newTablo.BolgeId1
			group by year(newTablo.TurTarihi),g.GidilecekYer

			--!!! ACIKLAMA
			-- bir un�on i�lemi ile bolgeid(1,2,3) olan k�s�mlar� alt alta olacak �ekilde ge�ici bir tablo olu�tururuz sorgu ile 
			--olu�an tablo ile gidilecekyer tablosunu join i�lemi yaptim 
			-- en son y�llara gore  gidilecekyeri birlikte grup i�lemi yapt�m buradan count keywordu bize z�yaret say�s�n� verir

			
		

		


--6. 2�den fazla tura rehberlik eden rehberlerin en �ok tan�tt�klar� yerler nelerdir? +++
			select * from Rehber --rehber id lerini gormek i�in
			select RehberId,TurId from Satis -- hangi rehber hangi tura rehberlik etmi� gormek i�in
			select * from tur --tur da gidilen yerleri gormek i�in

			--!!! ACIKLAMA 
			-- 1 ad�mda yeni bir tablo ile rehber tablosuna benzer ama rehberlerin kat�ld�klar� rehberlik yapma say�lar�n� da yazan column ekleyerek bir tablo olu�turdum 
				select * from(
								select r.rehberId, r.Ad+r.Soyad as FullName,count(s.TurId) as RehberlikSayisi 
								from satis s join Rehber r on s.RehberId=r.RehberId
											 join Tur tur on tur.TurId=s.TurId	
								group by r.RehberId,r.Ad +r.Soyad 
							 ) 	as newRehber
			--2 ad�m 
			/*  bu ad�mda gidilecekyer tablosundan gidilecek yerin adini, sat�� tablosu ile newrehber tablosundan rehberid ve rehberlikSAy�s�n� almak i�in joinleme i�lemi yapt�m
				olusan sorgu ��kt�s�ndan ko�ul ile filtreleme i�lemi yapar�z sonra elimizdek� ��kt�yi gruplama(gidilecekyer) ile yapt���m�zda rehberlerin gittikeri yerlerin 
				say�s�n� al�r�z en sonda buyukten-kucuge s�ralama ile en fazla olan de�eri alrak sonuc elde ederiz
			
			*/
				select top 1  g.GidilecekYer,count(*) as [Tan�tt�klar yerin say�s�]
				from (	select TurAdi, turId, bolgeId1,TurTarihi  from Tur union all
						select TurAdi, turId, bolgeId2,TurTarihi  from Tur union all
						select TurAdi, turId, bolgeId3,TurTarihi  from Tur
						) as newTablo 
										join GidilecekYer g on g.BolgeId=newTablo.BolgeId1
										join Satis s on s.TurId =newTablo.TurId
										join   (	
												select r.rehberId, r.Ad+r.Soyad as FullName,count(s.TurId) as RehberlikSayisi 
												from satis s join Rehber r on s.RehberId=r.RehberId
															 join Tur tur on tur.TurId=s.TurId	
												group by r.RehberId,r.Ad +r.Soyad
												) as newRehber on newRehber.RehberId =s.RehberId	
				where newRehber.RehberlikSayisi>2
				group by g.GidilecekYer 
				order by [Tan�tt�klar yerin say�s�] desc  
						

			



								
		
		
--7. �talyan turistler en �ok nereyi gezmi�tir? +++
		-- 1 ad�m --> italyan turist sorgusunda kimse yok 
			select * from Turist where Uyruk ='Italy'

		-- 2 ad�m --> bende sorguyu English �eklinde test ettim
		 -- bu ad�mda ingilz turistleri ve kat�ld�klar� turadlarn� listeledim
			select t.Ad,t.Soyad,t.Uyruk,tur.TurAdi from turist t 
								join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
			where Uyruk='english' 

		-- 3 ad�m 
		/*
		 bu ad�mda ihtiyac�m olan sat�s,turist,tur,gidilecekyer ve yeni bir tsay�s� ad�nda tablo olu�turarak tablolar� join yapt�m
		 tsay�s� ==> bu tablo da 3 tane column olu�turdum bunlar turid, o turda gidilen bolgeler ve gitme say�lar�--
		tsay�s� tablosunu ollu�turmak i�in i�i�e subquery sorgu ile ula�t�m i� sorguda ismini toplamsay�2 ismini verdim bu olu�acak tablo sutunlar�
		turid, turadi,bolgeid dir burada 3 tane bolgeid(1,2,3) bunlar� toplamsay�2 tablosunda altalta listelemek istedim sonra bunlar� grup yapabilirim  
		�imdi elimde turid de gidilen bolgelerin gidilme say�lar� var o zaman ko�ul ile ingiliz turistleri filtrelerim
		sonra gidilecekyerleri gruopland�r�r�m (bu grupland�rma bolgeid ilede olur) bu �ekilde grup yapt��imda count ile gidilecekyerlerin grupland�rma say�lar�n� elde ederim
		*/
			select top 1 t.Uyruk,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Ziyaret sayilari] 
			from turist t 	join Satis s on s.TuristId =t.TuristId
							join Tur tur on tur.TurId =s.TurId
							join ( 	select  toplamsayi2.BolgeId,COUNT(*) as gitmeSayisi,TurId 
									from (	select TurId, TurAdi,BolgeId1 as BolgeId from tur union all
											select TurId, TurAdi,BolgeId2 as BolgeId from tur union all
											select tur�d, TurAdi,BolgeId3 as BolgeId from tur
										 )	
									as toplamsayi2
									where BolgeId is not null
									group by toplamsayi2.BolgeId,TurId 
								 ) 
							as tsayisi on tsayisi.TurId=tur.TurId
							join GidilecekYer g on g.BolgeId=tsayisi.BolgeId
			where t.Uyruk='english' -- buras� istenen query de Italy olmal�
			group by g.GidilecekYer,t.Uyruk
			order by [Ziyaret sayilari] desc


--8. Kapal� �ar���y� gezen en ya�l� turist kimdir? +++

			select top 1 t.Ad,t.Soyad,t.Yas,tur.TurAdi 
			from turist t	join Satis s on s.TuristId =t.TuristId
							join Tur tur on s.TurId =tur.TurId
			where TurAdi like '%Kapal��ar��%'
			order by yas desc

								--!!!
								/*
								bu sorguda tur ad�nda  Kapal��ar�� bolge ismi olan yerleri secerek
								turistleri buldum sonra yas column'a gore desc s�ralama yapt�m 1 datay� ald�m
								Not s�ralama ya� de�il do�um tarihine g�rede yaz�labilir 
								amac�m sutun k�smini computed column specification ayar� yapmakt�.
								*/


--9. Yunanistan�dan gelen Finlandiyal� turistin gezdi�i yerler nerelerdir? +++

			select t.Ad,t.Soyad,t.GeldigiUlke,t.Uyruk,tur.TurAdi 
			from turist t	join Satis s on s.TuristId =t.TuristId
							join Tur tur on s.TurId =tur.TurId
			where t.GeldigiUlke='greek' and t.Uyruk ='finnish'

								--!!! ACIKLAMA
								/*
								bu sorguda turist tablosu ve tur tablosuna ihtiyac�m var
								2 tane ko�ul ile sorgulama yaparak  
								Yunanistan�dan gelen Finlandiyal� turistin gezdi�i yerleri buldum
								*/
							

--10. Dolmabah�e Saray��na en son giden turistler ve rehberi listeleyin. +++

			select top 1 concat (t.Ad,' ',t.Soyad) as Turist,tur.TurAdi,concat (r.Ad,' ',r.Soyad) as Rehber,tur.TurTarihi 
			from turist t		join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
								join Rehber r on r.RehberId=s.RehberId
			where TurAdi like '%Dolmabah�e%' order by tur.TurTarihi desc

				-- !!! ACIKLAMA
				/* bu sorguda turist tablosu Rehber tablosu ve Tur tablosu ihtiyac�m var 
					birde bu toblolar�n ba�lant� yeri olan sat�s tablosunu joinledim extradan
					sonra bu c�kan tablodan ko�ul olarak turad�nda Dolmabahce varm� onu ekledim
				
				*/

		--FATURA ��LEMLER� 

			select * from turist 
			--turist yas kriterlerinde 60 yas uzeri bulunmad��� i�in test ama�l� 30 yas denedim

		select	trst.Ad+trst.Soyad as AdSoyad, concat (fatura,year(FaturaTarihi),MONTH(FaturaTarihi),day(FaturaTarihi),FaturaId) as Faturano,
				f.FaturaTarihi,t.TurAdi,
				sum(Ucret)*trst.indirim	 as Tutar
		from Fatura f	join Satis s on f.SatisId=s.SatisId 
						join  (select *,
									case
										when Yas >30 then 0.85  -- yas kr�terin� test amacl� 30 yapt�m
										when yas <30 then 1
										else 1
									end as indirim	
								from Turist
							   ) trst on trst.TuristId=s.TuristId
						join (	select TurId, TurAdi,BolgeId1 as BolgeId from tur union all
											select TurId, TurAdi,BolgeId2 as BolgeId from tur union all
											select tur�d, TurAdi,BolgeId3 as BolgeId from tur
							 ) t on t.TurId =s.TurId
						join GidilecekYer g on g.BolgeId =t.BolgeId
		where FaturaId=2-- istenilen fatura talep ko�ulu
		group by	trst.Ad+trst.Soyad,t.TurAdi,f.FaturaTarihi,trst.indirim ,
					concat (fatura,year(FaturaTarihi),MONTH(FaturaTarihi),day(FaturaTarihi),FaturaId)
		

		-- Searched Case When


select *, 
		case
			when Yas >30 then 0.85
			when yas <30 then 1
			else 1
		end as indirim	
from Turist
