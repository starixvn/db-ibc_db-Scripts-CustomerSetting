/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240216@Eden
	Task: Create log action: Bet Limit for 3rd Products [#RedmineID:#204358]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE
FROM LogAction WITH(ROWLOCK,UPDLOCK)
WHERE ActionID IN (220044,220045,220046,220047)

DELETE
FROM LogActionDetail WITH(ROWLOCK,UPDLOCK)
WHERE ActionID IN (220044,220045,220046,220047)

INSERT INTO LogAction (
	 ActionID
	,ActionTypeID
	,SPName
	,ActionNameEN
	,ActionNameCH
	,ActionNameCS
	,ActionNameJP
	,ActionNameIT
	,ActionNameTH
	,ActionNameKO
	,XsltContent
	,IsInternal
	,ActionNameVI
	,ActionNameCN
)
SELECT ActionID = CASE		WHEN ActionID = 220031 THEN 220044 
							WHEN ActionID = 220032 THEN 220045 
							WHEN ActionID = 220033 THEN 220046 
							WHEN ActionID = 220034 THEN 220047 
					END
	,ActionTypeID
	,SPName = 'Acc_CustSetting_BetSetting_154_Upd'
	,ActionNameEN
	,ActionNameCH
	,ActionNameCS
	,ActionNameJP
	,ActionNameIT
	,ActionNameTH
	,ActionNameKO
	,XsltContent
	,IsInternal
	,ActionNameVI
	,ActionNameCN
FROM LogAction WITH(NOLOCK)
WHERE ActionID IN (220031,220032,220033,220034)

INSERT INTO LogActionDetail(ActionID,ProductID,Level)
SELECT  ActionID = CASE		WHEN ActionID = 220031 THEN 220044 
							WHEN ActionID = 220032 THEN 220045 
							WHEN ActionID = 220033 THEN 220046 
							WHEN ActionID = 220034 THEN 220047 
					END
		,ProductID
		,Level
FROM LogActionDetail WITH(NOLOCK)
WHERE ActionID IN (220031,220032,220033,220034)

SELECT * 
FROM LogAction WITH(NOLOCK)
WHERE ActionID IN (220044,220045,220046,220047)

SELECT * 
FROM LogActionDetail WITH(NOLOCK)
WHERE ActionID IN (220044,220045,220046,220047)