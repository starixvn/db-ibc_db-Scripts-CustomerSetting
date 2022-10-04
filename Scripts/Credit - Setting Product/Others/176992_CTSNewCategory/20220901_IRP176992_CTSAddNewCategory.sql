/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220901@Johnson
	Task: Add new category for customer class [Redmine: #167726]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[CategoryConfig]
           ([CategoryID]
           ,[CategoryName]
           ,[OfferDeposit]
           ,[CategoryNameCS]
           ,[CustomerClass])
SELECT 63 , N'System Detect Group Betting',1,N'系统侦测群组投注',3101
UNION SELECT 103, N'System Detect Group Betting (Losing)',1, N'系统侦测群组投注', 3201

