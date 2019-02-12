/*
	CreatedDate: 20181120@Elodie
	Task: Initial data for eaGroupConfiguration table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

DELETE FROM eaGroupConfiguration
GO

INSERT INTO eaGroupConfiguration(ProductId, GroupId, IsShow)
SELECT ProductId, GroupId, 0
FROM bodb02.dbo.Products p WITH (NOLOCK)
	CROSS JOIN dbo.eaGroup g WITH (NOLOCK)

--Offer all group
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
WHERE ProductId IN (1,6,3,5,8,12,21,22,24,28)	

--Offer Racing
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId = 2
	AND g.GroupName IN ('ACCDDD','ACCIN','ACCINDO','ACCMKK','ACCMMK','ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99',
						'ACCUUS','ACCXT','ACCYNG','INDO2','INDO56','INDO56B','INDOBS','INDOWIN','MKK99','ACCYEN',
						'ACCNTD','ACCYEN789','ACCYEN889','ACCIRR','ACCUSD','ACCUT','ACCYEN668','ACCYEN888','ACCUT2','ACCUSDOTH')

--Offer Live CS
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId = 4
	AND g.GroupName IN ('ACCDDD','ACCIN','ACCINDO','ACCMKK','ACCMMK','ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99','ACCUUS',
						'ACCXT','ACCYNG','INDO2','INDO56','INDO56B','INDOBS','INDOWIN','MKK99','ACCYEN','ACCNTD','ACCYEN789',
						'ACCYEN889','ACCIRR','ACCUSD','ACCUT','ACCYEN668','ACCYEN888','ACCUT2','ACCUSDOTH')	 

--Offer Colossus Bets
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId = 15
	AND g.GroupName IN ('ACCDDD','ACCIN','ACCINDO','ACCMKK','ACCMMK','ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99','ACCUUS',
						'ACCXT','ACCYNG','INDO2','INDO56','INDO56B','INDOBS','INDOWIN','MKK99')	 

--Offer NG2
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId = 23
	AND g.GroupName IN ('ACCUUS','ACCYEN','ACCYEN789','ACCYEN889','ACCYEN668','ACCNTD','ACCIRR','ACCUSD','ACCUT','ACCYEN888',
						'ACCUT2','ACCUSDOTH','TH999','ACCTESTK68','TH001','TH002','TH003')	 

--Offer Lucky 3, Bullfighting
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId IN (26, 30)
	AND g.GroupName IN ('ACCUUS')	 

--Offer PokerGames
UPDATE gc
SET IsShow = 1
FROM eaGroupConfiguration gc WITH (ROWLOCK) 
	INNER JOIN dbo.eaGroup g WITH (NOLOCK) ON g.GroupID = gc.GroupID
WHERE gc.ProductId = 33
	AND g.GroupName IN ('ACCUUS','ACCYEN','ACCYEN789','ACCYEN889','ACCUSD','ACCUT','ACCYEN668','ACCYEN888','ACCUT2','ACCUSDOTH','ACCTEST')	

--SELECT * FROM eaGroupConfiguration WITH (NOLOCK)