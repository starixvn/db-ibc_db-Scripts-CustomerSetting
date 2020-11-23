/*
	Created: 20201109@Tina
	Task: Hide product profile for Big Gaming
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 239



--SELECT * FROM ProductSettingDetail S WITH (NOLOCK) where SportType = 239




