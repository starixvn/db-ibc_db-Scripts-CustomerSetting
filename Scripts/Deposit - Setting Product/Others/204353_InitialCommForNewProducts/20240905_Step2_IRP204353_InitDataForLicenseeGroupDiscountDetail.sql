/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20240905@Johnson
	Task: Init data LicenseeGroupDiscountDetail for new products [redmine: #204353]
	DB: DBCUST/bodb_Licensee
*/

USE [bodb_Licensee]
GO

--3k rows
INSERT INTO [dbo].[LicenseeGroupDiscountDetail]
           ([GroupDiscountID]
           ,[Licenseeid]
           ,[SportType]
           ,[BetType]
           ,[Discount])
SELECT GroupDiscountID, Licenseeid, t.SportType, t.BetType, 0 as Discount
FROM LicenseeGroupDiscount WITH(NOLOCK)
	CROSS APPLY (SELECT 156 SportType,	8900 BetType
				UNION SELECT 216,	10000
				UNION SELECT 227,	7601
				UNION SELECT 228,	10300
				UNION SELECT 229,	10450
				UNION SELECT 230,	11100
				UNION SELECT 146,	11300
				)t

