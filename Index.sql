CREATE CLUSTERED INDEX IX_PersonelNo
ON Personel
(
	PersonelNo
)

DROP INDEX IX_PersonelNo ON Personel

CREATE UNIQUE CLUSTERED INDEX IX_PersonelNo
ON Personel
(
	PersonelNo
)

CREATE NONCLUSTERED INDEX IX_DogumTarihi
ON Personel
(
	DogumTarihi
)

ALTER UNIQUE NONCLUSTERED INDEX IX_DogumTarihi -- NON-CLUSTERED unique olamaz
ON Personel
(
	DogumTarihi
)


CREATE NONCLUSTERED INDEX IX_AdSoyad
ON Personel
(
	Ad,
	Soyad
)

--SELECT * FROM Personel WHERE Mail =''

SELECT Mail FROM Personel WHERE Ad ='Edgar'

-- Key Lookup

-- Index Covering

CREATE NONCLUSTERED INDEX IX_AdSoyad
ON Personel
(
	Ad,
	Soyad
)
INCLUDE(Mail)


--Filtered Index
CREATE NONCLUSTERED INDEX IX_Sehir
ON Personel
(
	Sehir
)
WHERE Sehir = 'Ankara'