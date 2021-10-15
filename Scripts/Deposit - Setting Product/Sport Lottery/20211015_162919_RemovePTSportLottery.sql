/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211015
	Task:  Sports Lottery - Treat the product as a part of sportbook for licensees [Redmine: 162919]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @productID SMALLINT,@sportType SMALLINT
SET @productID = 63 
SET @sportType = 169
--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @productID AND D.ProductSettingID = 86

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @sportType  AND D.ProductSettingID = 86

