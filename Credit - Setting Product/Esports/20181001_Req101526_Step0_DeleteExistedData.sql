/*
	Created: Winnie
	Task: Check if existed data RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20180920
*/ 
DECLARE @Sporttype INT=43
--SELECT TOP 1 CustID FROM [dbo].[CustBetSetting3rd_Agent] WITH(NOLOCK) WHERE SportType=@Sporttype
--SELECT TOP 1 CustID FROM [dbo].CustBetSetting3rd_Member WITH(NOLOCK) WHERE SportType=@Sporttype
--SELECT TOP 1 CustID FROM [dbo].CustPTSetting3rd_Member WITH(NOLOCK) WHERE SportType=@Sporttype
--SELECT TOP 1 CustID FROM [dbo].CustPTSetting3rd_Agent WITH(NOLOCK) WHERE SportType=@Sporttype

DELETE FROM [dbo].[CustBetSetting3rd_Agent] WITH(NOLOCK) WHERE SportType=@Sporttype
DELETE FROM [dbo].CustBetSetting3rd_Member WITH(NOLOCK) WHERE SportType=@Sporttype
DELETE FROM [dbo].CustPTSetting3rd_Member WITH(NOLOCK) WHERE SportType=@Sporttype
DELETE FROM [dbo].CustPTSetting3rd_Agent WITH(NOLOCK) WHERE SportType=@Sporttype