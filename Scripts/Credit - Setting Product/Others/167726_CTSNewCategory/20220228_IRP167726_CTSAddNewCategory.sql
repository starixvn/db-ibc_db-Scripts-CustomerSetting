/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220228@Johnson
	Task: Add new category for customer class [Redmine: #167726]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[CategoryConfig]
           ([CategoryID]
           ,[CategoryName]
           ,[OfferDeposit]
           ,[CategoryNameCS]
           ,[CustomerClass])
SELECT 163, N'Bad Robot User',1,N'非正常机械玩家',131
UNION SELECT 164, N'Good Robot User',1, N'正常机械玩家', 132

