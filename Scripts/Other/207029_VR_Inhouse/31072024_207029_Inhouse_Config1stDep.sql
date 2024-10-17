/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 31072024
	Task:  Scale Out DBCUST - Apply In-house Replication for Virtual Rate Setting Config deploy 1sp dep   [RedmineID:#207029]
	DB: DBCust/CustDB
*/
USE CustDB
GO
IF EXISTS(
				SELECT 1
				FROM [dbo].Dep_UMConfig c WITH(NOLOCK)
				WHERE  c.FunctionType = 1
					AND c.ProductID = 0
					AND c.SettingType = 0
					AND c.LicenseeID = 0
			) -- Have UM 
			BEGIN
				UPDATE c
				SET BeginTime = '2024-10-14 03:40:00' , EndTime = '2024-10-14 03:45:00'
				FROM Dep_UMConfig c WITH(ROWLOCK)
				WHERE  c.FunctionType = 1
					AND c.ProductID = 0
					AND c.SettingType = 0
					AND c.LicenseeID = 0
			END
			ELSE
			BEGIN
				INSERT INTO Dep_UMConfig ([FunctionType],[ProductID],[SettingType],[LicenseeID],[BeginTime],[EndTime])
				VALUES (1, 0 , 0 , 0 , '2024-10-14 03:40:00' , '2024-10-14 03:45:00')
			END