/*
	Created: 20190625@Winnie
	Task: DCS Deposit for CardClub - [Redmine:#115322]
		Insert Master Data:
	DB: Run at DBCust.CustDB
*/  
USE [CustDB]
Go
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES 
	--Status
	(24,33,4,0,1,1)
	-- PT
	,(25,33,1,0,2,1)
	-- Stakelevel group
	,(26,33,7,0,3,1)
GO
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES 
	(24,165,1901,0,0,1)
	,(25,165,1901,0,0,1)
	,(26,165,1901,0,0,1)
GO

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (165,1901,9)
GO


INSERT INTO [dbo].[GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
SELECT 10,	165,	1901,	'Level 1',	1

select * from [Dep_ProductSetting] where productID=22

select * from gamegroup




