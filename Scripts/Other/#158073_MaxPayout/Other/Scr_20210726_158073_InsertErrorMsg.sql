/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20212607
	Task: Insert new Error Message [Redmine: #154048]   
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO
DELETE FROM MsgError WITH(ROWLOCK) WHERE MsgID BETWEEN 10059 AND 10067
DECLARE @MsgError TABLE(
 MsgID	int
,MsgGroupID	int
,MsgNameEN	nvarchar(500)
,MsgNameCT	nvarchar(500)
,MsgNameCS	nvarchar(500)
,MsgNameTH	nvarchar(500)
,MsgNameVI	nvarchar(500)
)

INSERT INTO @MsgError(MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameTH
	,MsgNameVI
	)
SELECT 10059
,2
,N'Wrong Max Payout Per Match'
,N'Wrong Max Payout Per Match'
,N'Wrong Max Payout Per Match'
,N'Wrong Max Payout Per Match'
,N'Wrong Max Payout Per Match'
UNION ALL
SELECT 10060
,2
,N'Max Per Match must be less than or equal to Max Payout Per Match'
,N'Max Per Match must be less than or equal to Max Payout Per Match'
,N'Max Per Match must be less than or equal to Max Payout Per Match'
,N'Max Per Match must be less than or equal to Max Payout Per Match'
,N'Max Per Match must be less than or equal to Max Payout Per Match'
UNION ALL
SELECT 10061
,2
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
UNION ALL
SELECT 10062
,2
,N'Min Bet must be equal to or greater than Upline''s Min Bet'
,N'Min Bet must be equal to or greater than Upline''s Min Bet'
,N'Min Bet must be equal to or greater than Upline''s Min Bet'
,N'Min Bet must be equal to or greater than Upline''s Min Bet'
,N'Min Bet must be equal to or greater than Upline''s Min Bet'
UNION ALL
SELECT 10063
,2
,N'Max Bet must be equal to or less than Upline''s Max Bet'
,N'Max Bet must be equal to or less than Upline''s Max Bet'
,N'Max Bet must be equal to or less than Upline''s Max Bet'
,N'Max Bet must be equal to or less than Upline''s Max Bet'
,N'Max Bet must be equal to or less than Upline''s Max Bet'
UNION ALL
SELECT 10064
,2
,N'Max Per Match  must be equal to or less than Upline''s Max Per Match'
,N'Max Per Match  must be equal to or less than Upline''s Max Per Match'
,N'Max Per Match  must be equal to or less than Upline''s Max Per Match'
,N'Max Per Match  must be equal to or less than Upline''s Max Per Match'
,N'Max Per Match  must be equal to or less than Upline''s Max Per Match'
UNION ALL
SELECT 10065
,2
,N'Max Payout Per Match must be equal to or less than Upline''s Max Payout Per Match'
,N'Max Payout Per Match must be equal to or less than Upline''s Max Payout Per Match'
,N'Max Payout Per Match must be equal to or less than Upline''s Max Payout Per Match'
,N'Max Payout Per Match must be equal to or less than Upline''s Max Payout Per Match'
,N'Max Payout Per Match must be equal to or less than Upline''s Max Payout Per Match'
UNION ALL
SELECT 10066
,2
,N'Max Per Ball must be equal to or less than Upline''s Max Per Ball'
,N'Max Per Ball must be equal to or less than Upline''s Max Per Ball'
,N'Max Per Ball must be equal to or less than Upline''s Max Per Ball'
,N'Max Per Ball must be equal to or less than Upline''s Max Per Ball'
,N'Max Per Ball must be equal to or less than Upline''s Max Per Ball'
UNION ALL
SELECT 10067
,2
,N'Min bet must be less than or equal to max bet and max bet must be less than or equal to max per match'
,N'Min bet must be less than or equal to max bet and max bet must be less than or equal to max per match'
,N'Min bet must be less than or equal to max bet and max bet must be less than or equal to max per match'
,N'Min bet must be less than or equal to max bet and max bet must be less than or equal to max per match'
,N'Min bet must be less than or equal to max bet and max bet must be less than or equal to max per match'


INSERT INTO MsgError(
	 MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameJP
	,MsgNameTH
	,MsgNameKO
	,MsgNameES
	,MsgNameVI
	,IsActive
	,MsgNameCN
	)
SELECT MsgID
	,MsgGroupID
	,MsgNameEN
	,MsgNameCT
	,MsgNameCS
	,MsgNameEN
	,MsgNameTH
	,MsgNameEN
	,MsgNameEN
	,MsgNameVI
	,1
	,NULL
FROM @MsgError

SELECT * FROM MsgError WTTH(NOLOCK) WHERE MsgID BETWEEN 10059 AND 10067
