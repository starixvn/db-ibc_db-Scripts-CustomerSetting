/*
	Created By: Elodie
	Created Date: 20210622
	Description: alter table to count new msg [RedmineID: #157191]	
	DB: DBMSG/bodb_Message
*/

USE [bodb_Message]
GO
ALTER TABLE MsgCustReadStatus ADD LastCutOff DATETIME NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_LastSeenNormalMsg DATETIME NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_LastSeenSpecialMsg DATETIME NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_LastSeenPersonalMsg DATETIME NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_cntNormal INT NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_cntSpecial INT NULL
GO
ALTER TABLE MsgCustReadStatus ADD Saved_cntPersonal INT NULL
GO