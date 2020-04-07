/*	
	Creator: Elodie
	Date: 20200403
	Task: Update realProductID
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE p 
SET RealProductId = p.ProductID
FROM ProductSettingDetail p WITH (ROWLOCK)

UPDATE p 
SET RealProductId = 21
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 211

UPDATE p 
SET RealProductId = 45
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 243

UPDATE p 
SET RealProductId = 39
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 244

UPDATE p 
SET RealProductId = 28
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 220

UPDATE p 
SET RealProductId = 40
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 222

UPDATE p 
SET RealProductId = 47
FROM ProductSettingDetail p WITH (ROWLOCK)
WHERE p.SportType = 241

SELECT * FROM ProductSettingDetail WITH (NOLOCK)