/*
	Created: 20181001@Winnie
	Task: Insert product profile for Esports
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

UPDATE ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE Sporttype=43



INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]  )
SELECT 
			43
           ,1
           ,exchangeid
           ,0
           ,0        
FROM exchange WITH(NOLOCK)
WHERE exchangeid<>20
   

