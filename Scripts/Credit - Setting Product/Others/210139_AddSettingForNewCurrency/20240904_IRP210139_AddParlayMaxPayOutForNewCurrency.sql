/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240904@Johnson
	Task: Add Parlay Max Payout for new currency BRL [redmine: #210139]
	DB: DBCUST/CustDB
*/

DECLARE @Currency INT = 82--BRL
		
INSERT INTO [dbo].[MaxPayoutGlobalSetting]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SingleMatchParlay]
           ,[Combo2]
           ,[Combo35]
           ,[ComboOver6]
           ,[SettingStatus]
           ,[RepUpdateTime])
SELECT 1,9, @currency, 1000, 1000, 1000, 1000, 0, NULL 
UNION SELECT 99,9, @currency, 1000, 1000, 1000, 1000, 0, NULL

