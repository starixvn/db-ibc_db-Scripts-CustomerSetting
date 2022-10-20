/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task: Macau Games - Prepare for log status [#RM:174513]
	DB: DBLOG/bodb_CustomerLog 
*/

USE bodb_CustomerLog
GO

DECLARE @tmpLogAction TABLE (ActionID INT)


UPDATE a
SET  a.ProductID = 53
OUTPUT DELETED.ActionID INTO @tmpLogAction(ActionID)
FROM dbo.LogActionDetail a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22 

UPDATE l 
SET  l.ActionNameEN = REPLACE(l.ActionNameEN,N'Macau Games',N'RNG Slot')
	,l.ActionNameCH = REPLACE(l.ActionNameCH,N'Macau Games',N'RNG Slot')
	,l.ActionNameCS = REPLACE(l.ActionNameCS,N'Macau Games',N'RNG Slot')
	,l.ActionNameJP = REPLACE(l.ActionNameJP,N'Macau Games',N'RNG Slot')
	,l.ActionNameIT = REPLACE(l.ActionNameIT,N'Macau Games',N'RNG Slot')
	,l.ActionNameTH = REPLACE(l.ActionNameTH,N'Macau Games',N'RNG Slot')
	,l.ActionNameKO = REPLACE(l.ActionNameKO,N'Macau Games',N'RNG Slot')
	,l.ActionNameVI = REPLACE(l.ActionNameVI,N'Macau Games',N'RNG Slot')
	,l.ActionNameCN = REPLACE(l.ActionNameCN,N'Macau Games',N'RNG Slot')
FROM LogAction l  WITH(UPDLOCK,ROWLOCK)
INNER JOIN @tmpLogAction t ON l.ActionID = t.ActionID