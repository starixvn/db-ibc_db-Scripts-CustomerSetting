/*
	Created by: Winnie
	Created Date: 20171103
	Description: DCS - Deposit - Add new table Dep_CustDiscountSetting_Agent RedmineID: #83334
	Database: DBCUST/CustDB
		
*/

USE CUSTDB
GO

INSERT INTO [dbo].[Dep_CustDiscountSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
SELECT c.custid,221,8001,0.05
FROM custinfo c WITH(NOLOCK)
INNER JOIN dep_custsuper d WITH(NOLOCK) ON c.srecommend=d.custid
WHERE d.site IN('12Bet', 'alog')
AND c.roleid IN(2,3,4)
AND d.currency IN(20,61,3)

GO

