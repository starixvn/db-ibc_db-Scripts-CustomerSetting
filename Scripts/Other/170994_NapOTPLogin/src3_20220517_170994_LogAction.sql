﻿/*<info serverAlias="DBNAP-bodb_NAPLog"></info>*/
/*
	Created: 20220517@Winfred
	Task: Insert log action OTP Login requried for VPNs users [RM#170994]
	DB: DBNAP/bodb_NAPLog
*/
USE [bodb_NAPLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName,  ActionTypeId,IsInternal)
SELECT	500, 'Insert new OTP Login', 'NAP_Admin_OTPIns', 6, 0  UNION ALL
SELECT	501, 'Update new OTP Login', 'NAP_Admin_OTPUpd', 6, 0

DELETE l FROM dbo.NAPLog_Action l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.NAPLog_Action (ActionID,SPName,ActionTypeID,IsInternal,ActionName,Items)
SELECT ActionID,SPName,ActionTypeID,IsInternal,ActionName,'<root><xml path="r" /></root>' AS Items
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM NAPLog_Action WHERE ActionID = t.ActionID)

--SELECT * FROM NAPLog_Action (NOLOCK) WHERE ActionID BETWEEN 500 AND 501