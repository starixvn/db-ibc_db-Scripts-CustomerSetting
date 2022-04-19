/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220329@Johnson
	Task: Add new category for customer class [Redmine: #170658]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[CategoryConfig]
           ([CategoryID]
           ,[CategoryName]
           ,[OfferDeposit]
           ,[CategoryNameCS]
           ,[CustomerClass])
SELECT 92, N'Group Betting (Probation)',1,N'群组投注 (观察中)',86
UNION SELECT 94, N'Arbitrage (Probation)',1, N'打水套利 (观察中）', 96
UNION SELECT 98, N'Irrigation Bet (Probation)',1, N'灌水投注 (观察中)', 96
UNION SELECT 95, N'Fixed Game (Probation)',1, N'内定赛事 (观察中)', 106
UNION SELECT 99, N'System Formula Bet (Probation)',1, N'机械/系统计算投注 (观察中）', 106
UNION SELECT 93, N'Hedging (Probation)',1, N'出货群组 (观察中）', 106
UNION SELECT 100, N'Bonus Hunter (Probation)',1, N'赏金猎人 (观察中）', 116
UNION SELECT 102, N'Info Bet (Probation)',1, N'资讯单投注 (观察中）', 126
