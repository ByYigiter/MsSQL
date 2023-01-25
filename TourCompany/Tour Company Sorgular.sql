--Raporlar

--1. En çok gezilen yer/yerler neresidir? +++

		select top 1 BolgeId1,g.GidilecekYer,sum(GidilenYerler) as [Ziyaret Edilme Sayisi] 
		from (			select BolgeId1, count(*) as GidilenYerler from Tur group by BolgeId1  union all
						select BolgeId2, count(*) as GidilenYerler from Tur group by BolgeId2 union  all
						select BolgeId3, count(*) as GidilenYerler from Tur  group by BolgeId3 )
		as toplamSayı 
						join GidilecekYer g on g.BolgeId=toplamSayı.BolgeId1	
		where toplamSayı.BolgeId1 is not null 
		group by  toplamSayı.BolgeId1,g.GidilecekYer 
		order by [Ziyaret Edilme Sayisi] desc

		--select * from tur
				
				-- !!! ACIKLAMA 
				-- bu sorguda tur tablosunda 3 bolumde yer alan gidilecek yerleri 1 tablo yapmak için union all ile birleştirme yaptım
				-- sonra bana bolgeid nin isimlerini almak için GidilecekYer ile join işlemi yaptım
				-- bu sorgunun son kısmında da bolgeıd olarak gruplama yaptım ve gidilenyerlerin sum ile toplama işlemi ile toplam ziyaret sayısıni aldım
				-- en son [Ziyaret Edilme Sayisi] nı desc olarak sıralama yaptım ve top 1 ile en fazla olanı buldum
 	
--2. Ağustos ayında en çok çalışan rehber/rehberler kimdir/kimlerdir? +++
		

		select top 1  r.Ad +' '+r.Soyad as [Austos'ta en fazla calisan] ,count (*) as Calisma_Sayisi   
		from rehber r join satis s on r.RehberId= s.RehberId
					  join Tur t on s.TurId= t.TurId
		where DATENAME(MONTH,t.TurTarihi)='august'
		group by r.Ad +' '+r.Soyad
		order by Calisma_Sayisi desc

				--!!! ACIKLAMA
				-- bu soruda Satis, Rehber ve Tur tablolarını join ile bağlantı kurdum
				--sonra rehber isim soyisim olarak bir grup yaptım bu gruptan bize rehberlerin hangi turlara rehber olarak katıldığı bilgsi gelir
				-- bende  rehber ile grup yaparak turların sayılarını count ile aldım sonra koşulu August olanlar diye filtreleme yaptım
				-- en sonda ters sıralama ile top 1 i aldım 


--3. Kadın turistlerin gezdiği yerleri, toplam ziyaret edilme sayılarıyla beraber listeleyin +++
		-- 1 adım 
			-- bu kısımda kadın turistler kimler ve hangi tura katılmışlar bolge isimleri neler liste olarak gormek için yapılan sorgu
			select t.Ad,t.Soyad,t.Cinsiyet,tur.TurAdi,g1.GidilecekYer as [1 yer],g2.GidilecekYer as [2. yer]
			from Turist t join Satis s on t.TuristId =s.TuristId
								join Tur tur on s.TurId=tur.TurId
								join GidilecekYer g1 on g1.BolgeId =tur.BolgeId1
								join GidilecekYer g2 on g2.BolgeId =tur.BolgeId2
			where Cinsiyet='Kadın' 

			--2 adım
			/* bu sorguda bir geçici tablo oluşturdum bu tabloda bolgeid, turid ve bolgeye gitmesayısı olarak 3 column ekledim
			oluşturduğum tablo ile turist,satış ve gidilecekyer tablolorını join işlemi yaptım
			koşul ile fitreleme yaptımce en son gidilecekyere gore bir gruplama yaparak bolgelere(gidilecekyer)ziyaret sayılarını sum ile buldum
			buradaki ziyaret sayıları Kadınların ziyaret ettikleri sayıdır
			
			*/

				select t.Cinsiyet,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Ziyaret sayilari] from turist t 
								join Satis s on s.TuristId =t.TuristId
								join ( 		select  newTablo.BolgeId1,COUNT(*) as gitmeSayisi,TurId from (
													select TurId, TurAdi,BolgeId1,TurTarihi from tur union
													select TurId, TurAdi,BolgeId2,TurTarihi from tur union
													select turıd, TurAdi,BolgeId3,TurTarihi from tur)
											as newTablo
											where BolgeId1 is not null
											group by newTablo.BolgeId1,TurId ) tsayisi on tsayisi.TurId=s.TurId
								join GidilecekYer g on g.BolgeId=tsayisi.BolgeId1

				where t.Cinsiyet='Kadın'
				group by g.GidilecekYer,t.Cinsiyet

				-- 3 adım burada 1 soruda elde ettiğimiz toplam ziyaret sayılarını sutun olarak ekleme yaptım
					-- hem toplam zıyaret hem de kadınların ziyaret sayılarını ayrı columnlarda 2 sorguyu join yaparak gösterdim
					
				select new1.Cinsiyet,new1.GidilecekYer,new1.[Kadınların Ziyaret sayilari],new2.[Toplam Ziyaret Edilme Sayisi] 
				from ( select t.Cinsiyet,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Kadınların Ziyaret sayilari] 
						from turist t	join Satis s on s.TuristId =t.TuristId
										join ( 	select  new1.BolgeId1,COUNT(*) as gitmeSayisi,TurId 
												from (	select TurId, TurAdi,BolgeId1,TurTarihi from tur union
														select TurId, TurAdi,BolgeId2,TurTarihi from tur union
														select turıd, TurAdi,BolgeId3,TurTarihi from tur  )
												as new1
												where BolgeId1 is not null
												group by new1.BolgeId1,TurId 
											  ) tsayisi on tsayisi.TurId=s.TurId
										join GidilecekYer g on g.BolgeId=tsayisi.BolgeId1
				where t.Cinsiyet='Kadın'
				group by g.GidilecekYer,t.Cinsiyet
					 ) as new1 			
					join (	select  BolgeId1,g.GidilecekYer,sum(GidilenYerler) as [Toplam Ziyaret Edilme Sayisi] 
							from (	select BolgeId1, count(*) as GidilenYerler from Tur group by BolgeId1  union all
									select BolgeId2, count(*) as GidilenYerler from Tur group by BolgeId2 union  all
									select BolgeId3, count(*) as GidilenYerler from Tur  group by BolgeId3 
								 ) as toplamSayı 
							join GidilecekYer g on g.BolgeId=toplamSayı.BolgeId1	
							where toplamSayı.BolgeId1 is not null 
							group by  toplamSayı.BolgeId1,g.GidilecekYer 
						) as new2 on new2.GidilecekYer= new1.GidilecekYer
		

--4. İngiltere’den gelip de Kız Kulesi’ni gezen turistler kimlerdir? +++
		
					select t.Ad,t.Soyad,t.GeldigiUlke,tur.TurAdi from turist t	
								join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
					where GeldigiUlke='English' and TurAdi  like '%kız kulesi%'

					--!!! ACIKLAMA
					/* bu sorguda turist satis tur tablolorını join işlemmi yaptım sonra 2 koşul ile filtreleme yaparak turist bilgilerini aldım
					
					*/


--5. Gezilen yerler hangi yılda kaç defa gezilmiştir? +++
		
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
			-- bir unıon işlemi ile bolgeid(1,2,3) olan kısımları alt alta olacak şekilde geçici bir tablo oluştururuz sorgu ile 
			--oluşan tablo ile gidilecekyer tablosunu join işlemi yaptim 
			-- en son yıllara gore  gidilecekyeri birlikte grup işlemi yaptım buradan count keywordu bize zıyaret sayısını verir

			
		

		


--6. 2’den fazla tura rehberlik eden rehberlerin en çok tanıttıkları yerler nelerdir? +++
			select * from Rehber --rehber id lerini gormek için
			select RehberId,TurId from Satis -- hangi rehber hangi tura rehberlik etmiş gormek için
			select * from tur --tur da gidilen yerleri gormek için

			--!!! ACIKLAMA 
			-- 1 adımda yeni bir tablo ile rehber tablosuna benzer ama rehberlerin katıldıkları rehberlik yapma sayılarını da yazan column ekleyerek bir tablo oluşturdum 
				select * from(
								select r.rehberId, r.Ad+r.Soyad as FullName,count(s.TurId) as RehberlikSayisi 
								from satis s join Rehber r on s.RehberId=r.RehberId
											 join Tur tur on tur.TurId=s.TurId	
								group by r.RehberId,r.Ad +r.Soyad 
							 ) 	as newRehber
			--2 adım 
			/*  bu adımda gidilecekyer tablosundan gidilecek yerin adini, satış tablosu ile newrehber tablosundan rehberid ve rehberlikSAyısını almak için joinleme işlemi yaptım
				olusan sorgu çıktısından koşul ile filtreleme işlemi yaparız sonra elimizdekı çıktıyi gruplama(gidilecekyer) ile yaptığımızda rehberlerin gittikeri yerlerin 
				sayısını alırız en sonda buyukten-kucuge sıralama ile en fazla olan değeri alrak sonuc elde ederiz
			
			*/
				select top 1  g.GidilecekYer,count(*) as [Tanıttıklar yerin sayısı]
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
				order by [Tanıttıklar yerin sayısı] desc  
						

			



								
		
		
--7. İtalyan turistler en çok nereyi gezmiştir? +++
		-- 1 adım --> italyan turist sorgusunda kimse yok 
			select * from Turist where Uyruk ='Italy'

		-- 2 adım --> bende sorguyu English şeklinde test ettim
		 -- bu adımda ingilz turistleri ve katıldıkları turadlarnı listeledim
			select t.Ad,t.Soyad,t.Uyruk,tur.TurAdi from turist t 
								join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
			where Uyruk='english' 

		-- 3 adım 
		/*
		 bu adımda ihtiyacım olan satıs,turist,tur,gidilecekyer ve yeni bir tsayısı adında tablo oluşturarak tabloları join yaptım
		 tsayısı ==> bu tablo da 3 tane column oluşturdum bunlar turid, o turda gidilen bolgeler ve gitme sayıları--
		tsayısı tablosunu olluşturmak için içiçe subquery sorgu ile ulaştım iç sorguda ismini toplamsayı2 ismini verdim bu oluşacak tablo sutunları
		turid, turadi,bolgeid dir burada 3 tane bolgeid(1,2,3) bunları toplamsayı2 tablosunda altalta listelemek istedim sonra bunları grup yapabilirim  
		şimdi elimde turid de gidilen bolgelerin gidilme sayıları var o zaman koşul ile ingiliz turistleri filtrelerim
		sonra gidilecekyerleri gruoplandırırım (bu gruplandırma bolgeid ilede olur) bu şekilde grup yaptığimda count ile gidilecekyerlerin gruplandırma sayılarını elde ederim
		*/
			select top 1 t.Uyruk,g.GidilecekYer,sum(tsayisi.gitmeSayisi) as[Ziyaret sayilari] 
			from turist t 	join Satis s on s.TuristId =t.TuristId
							join Tur tur on tur.TurId =s.TurId
							join ( 	select  toplamsayi2.BolgeId,COUNT(*) as gitmeSayisi,TurId 
									from (	select TurId, TurAdi,BolgeId1 as BolgeId from tur union all
											select TurId, TurAdi,BolgeId2 as BolgeId from tur union all
											select turıd, TurAdi,BolgeId3 as BolgeId from tur
										 )	
									as toplamsayi2
									where BolgeId is not null
									group by toplamsayi2.BolgeId,TurId 
								 ) 
							as tsayisi on tsayisi.TurId=tur.TurId
							join GidilecekYer g on g.BolgeId=tsayisi.BolgeId
			where t.Uyruk='english' -- burası istenen query de Italy olmalı
			group by g.GidilecekYer,t.Uyruk
			order by [Ziyaret sayilari] desc


--8. Kapalı Çarşı’yı gezen en yaşlı turist kimdir? +++

			select top 1 t.Ad,t.Soyad,t.Yas,tur.TurAdi 
			from turist t	join Satis s on s.TuristId =t.TuristId
							join Tur tur on s.TurId =tur.TurId
			where TurAdi like '%Kapalıçarşı%'
			order by yas desc

								--!!!
								/*
								bu sorguda tur adında  Kapalıçarşı bolge ismi olan yerleri secerek
								turistleri buldum sonra yas column'a gore desc sıralama yaptım 1 datayı aldım
								Not sıralama yaş değil doğum tarihine görede yazılabilir 
								amacım sutun kısmini computed column specification ayarı yapmaktı.
								*/


--9. Yunanistan’dan gelen Finlandiyalı turistin gezdiği yerler nerelerdir? +++

			select t.Ad,t.Soyad,t.GeldigiUlke,t.Uyruk,tur.TurAdi 
			from turist t	join Satis s on s.TuristId =t.TuristId
							join Tur tur on s.TurId =tur.TurId
			where t.GeldigiUlke='greek' and t.Uyruk ='finnish'

								--!!! ACIKLAMA
								/*
								bu sorguda turist tablosu ve tur tablosuna ihtiyacım var
								2 tane koşul ile sorgulama yaparak  
								Yunanistan’dan gelen Finlandiyalı turistin gezdiği yerleri buldum
								*/
							

--10. Dolmabahçe Sarayı’na en son giden turistler ve rehberi listeleyin. +++

			select top 1 concat (t.Ad,' ',t.Soyad) as Turist,tur.TurAdi,concat (r.Ad,' ',r.Soyad) as Rehber,tur.TurTarihi 
			from turist t		join Satis s on s.TuristId =t.TuristId
								join Tur tur on s.TurId =tur.TurId
								join Rehber r on r.RehberId=s.RehberId
			where TurAdi like '%Dolmabahçe%' order by tur.TurTarihi desc

				-- !!! ACIKLAMA
				/* bu sorguda turist tablosu Rehber tablosu ve Tur tablosu ihtiyacım var 
					birde bu tobloların bağlantı yeri olan satıs tablosunu joinledim extradan
					sonra bu cıkan tablodan koşul olarak turadında Dolmabahce varmı onu ekledim
				
				*/

		--FATURA İŞLEMLERİ 

			select * from turist 
			--turist yas kriterlerinde 60 yas uzeri bulunmadığı için test amaçlı 30 yas denedim

		select	trst.Ad+trst.Soyad as AdSoyad, concat (fatura,year(FaturaTarihi),MONTH(FaturaTarihi),day(FaturaTarihi),FaturaId) as Faturano,
				f.FaturaTarihi,t.TurAdi,
				sum(Ucret)*trst.indirim	 as Tutar
		from Fatura f	join Satis s on f.SatisId=s.SatisId 
						join  (select *,
									case
										when Yas >30 then 0.85  -- yas krıterinı test amaclı 30 yaptım
										when yas <30 then 1
										else 1
									end as indirim	
								from Turist
							   ) trst on trst.TuristId=s.TuristId
						join (	select TurId, TurAdi,BolgeId1 as BolgeId from tur union all
											select TurId, TurAdi,BolgeId2 as BolgeId from tur union all
											select turıd, TurAdi,BolgeId3 as BolgeId from tur
							 ) t on t.TurId =s.TurId
						join GidilecekYer g on g.BolgeId =t.BolgeId
		where FaturaId=2-- istenilen fatura talep koşulu
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
