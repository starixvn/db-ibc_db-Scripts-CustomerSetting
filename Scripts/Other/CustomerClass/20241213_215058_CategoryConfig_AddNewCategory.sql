/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241213
	Task: Add new category  [Redmine:#215058] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

-- Init new category
INSERT INTO CategoryConfig 
	  ([CategoryID], [CategoryName], [OfferDeposit], [CustomerClass], [CategoryNameCS], [HiddenSite])
	  SELECT 21800,		'Bot Login Pattern',			1,		300,		N'机械玩家',			1
UNION SELECT 26800,		'Bot Login Pattern (Losing)',	1,		3000,		N'机械玩家 (输钱)',	1
GO