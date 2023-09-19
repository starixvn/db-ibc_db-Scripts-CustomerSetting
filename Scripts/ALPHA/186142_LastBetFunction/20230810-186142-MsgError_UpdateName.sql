﻿/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230810@Tacy
	Task: Update Language - error message [#186142]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE MsgError WITH (ROWLOCK, UPDLOCK)
SET  MsgNameCT=N'此篩選不可使用'
	,MsgNameCS=N'此筛选不可使用'
	,MsgNameVI=N'Bộ lọc này không khả dụng'
WHERE MsgID=90026
GO