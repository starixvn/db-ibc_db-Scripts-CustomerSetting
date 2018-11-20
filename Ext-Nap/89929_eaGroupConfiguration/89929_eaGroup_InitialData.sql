/*
	CreatedDate: 20181120@Elodie
	Task: Initial data for currency, code, site of eaGroup table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

DECLARE @GroupCurrency TABLE (GroupName VARCHAR(100), GroupId INT, Currency INT)

INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCOUNTING','ACCTEST')) g
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 43 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCTHAI','ACCTHAI2','ACCTHAI56','ACCTHAI99')

INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCINDO', 'ACCIN','INDOBS','INDO2')) g	
WHERE exchangeid IN (22,33,34,47,15)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 16 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCYEN','ACCYEN789','ACCYEN889','ACCYEN668','ACCYEN888')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 17 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCNTD')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 77 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCDDD')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 40 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCIRR')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 20 
FROM dbo.eaGroup WITH (NOLOCK) 
WHERE GroupName IN ('ACCUUS')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUSD')) g	
WHERE exchangeid IN (16,17,35,40,64)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUT','ACCUT2')) g	
WHERE exchangeid IN (64,17)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 70 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('MKK99','ACCMKK')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('INDO56','INDOWIN','INDO56B')) g	
WHERE exchangeid IN (22,33,34,15)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCUSDOTH')) g	
WHERE exchangeid IN (16,17,40)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 69 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCMMK')

INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 72 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCYNG')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, ExchangeID 
FROM bodb02.dbo.Exchange WITH (NOLOCK)
	CROSS JOIN (SELECT GroupName, GroupId FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('ACCTESTK68')) g	
WHERE exchangeid IN (74,20)
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 74 
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('TH999')

INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 78
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('SQ88','THEU','899EU','789EU')
	
INSERT INTO @GroupCurrency (GroupName, GroupId, Currency)
SELECT GroupName, GroupId, 3
FROM dbo.eaGroup WITH (NOLOCK) WHERE GroupName IN ('SQUS')		