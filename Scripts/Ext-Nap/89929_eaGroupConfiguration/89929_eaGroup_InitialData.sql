/*
	CreatedDate: 20181120@Elodie
	Task: Initial data for currency, code, site of eaGroup table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

DECLARE @GroupCurrency_tmp TABLE (GroupName VARCHAR(100), GroupId INT, Currency INT)
DECLARE @GroupSite_tmp TABLE (GroupName VARCHAR(100), GroupId INT, SiteId INT)
DECLARE @GroupCurrency TABLE (GroupName VARCHAR(100), GroupId INT, Currency VARCHAR(500), Code VARCHAR(500))
DECLARE @GroupSite TABLE (GroupName VARCHAR(100), GroupId INT, Site VARCHAR(500))

INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCOUNTING','ACCTEST')) g
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 43 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99')

INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCINDO', 'ACCIN','INDOBS','INDO2')) g	
WHERE exchangeid IN (22,33,34,47,15)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 16 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCYEN','ACCYEN789','ACCYEN889','ACCYEN668','ACCYEN888')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 17 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCNTD')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 77 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCDDD')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 40 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCIRR')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 20 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCUUS')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUSD')) g	
WHERE exchangeid IN (16,17,35,40,64)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUT','ACCUT2')) g	
WHERE exchangeid IN (64,17)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 70 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('MKK99','ACCMKK')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('INDO56','INDOWIN','INDO56B')) g	
WHERE exchangeid IN (22,33,34,15)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUSDOTH')) g	
WHERE exchangeid IN (16,17,40)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 69 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCMMK')

INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 72 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCYNG')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCTESTK68')) g	
WHERE exchangeid IN (74,20)
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 74 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('TH999')

INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 78
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('SQ88','THEU','899EU','789EU')
	
INSERT INTO @GroupCurrency_tmp (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 3
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('SQUS')		

-----------------------------------------------------------------------------------------------
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, SiteId 
FROM bodb02.dbo.site WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCOUNTING')) g

INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, SiteId 
FROM bodb02.dbo.site WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCTEST')) g
WHERE isLicensee = 0 AND isActive = 1

INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 22 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99')
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 11 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCINDO','ACCIN','INDOBS','INDO2','INDO56','INDOWIN','INDO56B','ACCDDD')
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 3 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCYEN','ACCYEN789','ACCYEN889','ACCYEN668','ACCNTD','ACCIRR','ACCUSD','ACCUT','ACCYEN888','ACCUT2','ACCUSDOTH')
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, SiteId 
FROM bodb02.dbo.site WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUUS')) g
WHERE siteid IN (1,184,147,257,294)
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 184 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('MKK99','ACCMKK')
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 188 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCMKK')	
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, SiteId 
FROM bodb02.dbo.site WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCYNG')) g
WHERE siteid IN (22,11)
	
INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 257 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCTESTK68','TH999')

INSERT INTO @GroupSite_tmp (GroupName, GroupId, SiteId)
SELECT GroupName, GroupId, 294 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('SQ88','THEU','899EU','789EU','SQUS')	

INSERT INTO @GroupSite (GroupName, GroupId, Site)
SELECT DISTINCT GroupName, GroupId, d.Site
FROM @GroupSite_tmp g1
CROSS APPLY ( SELECT  STUFF( (	SELECT ',' + Site
								FROM @GroupSite_tmp g2
									INNER JOIN bodb02.dbo.site s ON s.SiteId = g2.SiteId
								WHERE g2.GroupId = g1.GroupId AND g2.GroupName = g1.GroupName
								FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
							,1,1,''))  D ( Site )

INSERT INTO @GroupCurrency (GroupName, GroupId, Currency, Code)
SELECT DISTINCT GroupName, GroupId, d.Currency, C.Code
FROM @GroupCurrency_tmp g1
	CROSS APPLY ( SELECT  STUFF( (	SELECT ',' + e.Currency
									FROM @GroupCurrency_tmp g2
										INNER JOIN bodb02.dbo.Exchange e ON e.exchangeid = g2.Currency
									WHERE g2.GroupId = g1.GroupId AND g2.GroupName = g1.GroupName
									FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
								,1,1,''))  D ( Currency )
	CROSS APPLY ( SELECT  STUFF( (	SELECT DISTINCT ',' + e.Code
								FROM @GroupCurrency_tmp g2
									INNER JOIN bodb02.dbo.Exchange e ON e.exchangeid = g2.Currency
								WHERE g2.GroupId = g1.GroupId AND g2.GroupName = g1.GroupName
								FOR XML PATH(''), TYPE).value('.', 'varchar(max)')
							,1,1,''))  C ( Code )

SELECT * FROM @GroupCurrency
SELECT * FROM @GroupSite

UPDATE g
SET g.Currency = gc.Currency,
	g.CurrencyCode = gc.Code
FROM dbo.eaGroup g
	INNER JOIN @GroupCurrency gc ON g.groupId = gc.GroupId

UPDATE g
SET g.Site = gs.Site
FROM dbo.eaGroup g
	INNER JOIN @GroupSite gs ON g.groupId = gs.GroupId

SELECT * FROM dbo.eaGroup WITH (NOLOCK)