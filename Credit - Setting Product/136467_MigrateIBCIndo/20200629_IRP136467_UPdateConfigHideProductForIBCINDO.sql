/*
	Created: 20200629@Johnson
	Task: update Hide & Disabled for BBIN & SA Gaming for IBCIndo
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
SELECT 241,	3300, 0, 487, 1, 1, 1
UNION SELECT 244, 3001,	0, 487, 1, 1, 1		   
		   