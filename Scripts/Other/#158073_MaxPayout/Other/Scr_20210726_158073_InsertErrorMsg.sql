/*<info serverAlias=DBCUST-CUSTDB></info>*/
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
,N'單場最高派彩錯誤'
,N'单场最高派彩错误'
,N'ข้อผิดพลาดในการจ่ายเงินสูงสุดต่อคู่การแข่งขัน'
,N'Wrong Max Payout Per Match'
UNION ALL
SELECT 10060
,2
,N'Max Per Match must be less than or equal to Max Payout Per Match'
,N'單場限額必须少於或等於單場最高派彩限額'
,N'单场限额必须少于或等于单场最高派彩限额'
,N'ค่าเดิมพันสูงสุดต่อคู่การแข่งขันต้องน้อยกว่าหรือเท่ากับการจ่ายสูงสุดต่อคู่คู่การแข่งขัน'
,N'Max Per Match must be less than or equal to Max Payout Per Match'
UNION ALL
SELECT 10061
,2
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
,N'單粒球最高投注必須大於或等於最高投注且少於或等於單場限額'
,N'单粒球最高投注必须大于或等于最高投注且少于或等于单场限额'
,N'ค่าเดิมพันสูงสุดต่อบอลต้องมากกว่าหรือเท่ากับค่าเดิมพันสูงสุดและน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดต่อคู่การแข่งขัน'
,N'Max Per Ball must be greater than or equal to Max Bet and less than or equal to Max Per Match'
UNION ALL
SELECT 10062
,2
,N'Min Bet must be greater than or equal to Upline''s Min Bet'
,N'最低投注必須大於或等於上線的最低投注'
,N'最低投注必须大于或等于上线的最低投注'
,N'ค่าเดิมพันขั้นต่ำต้องมากกว่าหรือเท่ากับค่าเดิมพันขั้นต่ำของอัพไลน์'
,N'Min Bet must be greater than or equal to Upline''s Min Bet'
UNION ALL
SELECT 10063
,2
,N'Max Bet must be less than or equal to Upline''s Max Bet'
,N'最高投注必须少於或等於上線的最高投注'
,N'最高投注必须少于或等于上线的最高投注'
,N'ค่าเดิมพันสูงสุดต้องน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดของอัพไลน์'
,N'Max Bet must be less than or equal to Upline''s Max Bet'
UNION ALL
SELECT 10064
,2
,N'Max Per Match must be less than or equal to Upline''s Max Per Match'
,N'單場限額必须少於或等於上線的單場限額'
,N'单场限额必须少于或等于上线的单场限额'
,N'ค่าเดิมพันสูงสุดต่อคู่การแข่งขันต้องน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดต่อคู่การแข่งขันของอัพไลน์'
,N'Max Per Match must be less than or equal to Upline''s Max Per Match'
UNION ALL
SELECT 10065
,2
,N'Max Payout Per Match must be less than or equal to Upline''s Max Payout Per Match'
,N'單場最高派彩 必须少於或等於上線的單場最高派彩'
,N'单场最高派彩必须少于或等于上线的单场最高派彩'
,N'การจ่ายเงินสูงสุดต่อคู่การแข่งขันจะต้องน้อยกว่าหรือเท่ากับการจ่ายสูงสุดของอัพไลน์ต่อคู่การแข่งขัน'
,N'Max Payout Per Match must be less than or equal to Upline''s Max Payout Per Match'
UNION ALL
SELECT 10066
,2
,N'Max Per Ball must be less than or equal to Upline''s Max Per Ball'
,N'單粒球最高投注必须少於或等於上線的單粒球最高投注'
,N'单粒球最高投注必须少于或等于上线的单粒球最高投注'
,N'ค่าเดิมพันสูงสุดต่อบอลต้องน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดต่อบอลของอัพไลน์'
,N'Max Per Ball must be less than or equal to Upline''s Max Per Ball'
UNION ALL
SELECT 10067
,2
,N'Min Bet must be less than or equal to Max Bet and Max Bet must be less than or equal to Max Per Match'
,N'最低投注必须少於或等於 最高投注，最高投注必须少於或等於單場限額'
,N'最低投注必须少于或等于 最高投注，最高投注必须少于或等于单场限额'
,N'ค่าเดิมพันขั้นต่ำต้องน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดและค่าเดิมพันสูงสุดต้องน้อยกว่าหรือเท่ากับค่าเดิมพันสูงสุดต่อคู่การแข่งขัน'
,N'Min Bet must be less than or equal to Max Bet and Max Bet must be less than or equal to Max Per Match'

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
