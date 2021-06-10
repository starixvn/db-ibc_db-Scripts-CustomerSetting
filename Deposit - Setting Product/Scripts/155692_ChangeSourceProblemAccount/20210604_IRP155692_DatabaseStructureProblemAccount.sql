/*
	Created: 20210604@Johnson
	Task: Database structure for new source Problem account
	DB: DBCust/CustDB
*/

--setup this table into pub CustDB_CustSetting
CREATE TABLE [dbo].[Dep_CustCategoryHistory](
	[LogID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL ,
	[custid] [int] NOT NULL,
	[CategoryID] [smallint] NULL,
	[CustomerClass] [smallint] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Dep_CustCategoryHistory] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]

GO

ALTER TABLE CategoryConfig ADD OfferDeposit BIT
GO

ALTER TABLE CategoryConfig ADD CustomerClass SMALLINT
GO

ALTER TABLE CategoryConfig ADD CategoryNameCS NVARCHAR(100)
GO

---------------------------------------------------------
--init data
;WITH t AS (
SELECT 8 as Class, 52 as ID, 1 OfferDeposit, N'群组投注' as Name--Group Betting
UNION SELECT 10, 53, 1, N'出货群组'--Hedging
UNION SELECT 9, 54, 1, N'打水套利'--Arbitrage
UNION SELECT 10, 55, 1, N'内定赛事'--Fixed Game
UNION SELECT 11, 56, 0, NULL--AB Bet
UNION SELECT 13, 57, 1, N'机器人投注'--Robot Betting
UNION SELECT 9, 58, 1, N'灌水投注'--Irrigation Bet
UNION SELECT 10, 59, 1, N'系统计算投注'--System Formula Bet
UNION SELECT 11, 60, 1, N'赏金猎人'--Bonus Hunter
UNION SELECT 13, 61, 1, N'机械用户'--Robot User
UNION SELECT 12, 162, 1, N'资讯单'--Info Bet
)
UPDATE c
SET c.OfferDeposit = t.OfferDeposit,
	c.CustomerClass = t.Class,
	c.CategoryNameCS = t.Name
FROM CategoryConfig c WITH(ROWLOCK)
	INNER JOIN t ON c.CategoryID = t.ID
