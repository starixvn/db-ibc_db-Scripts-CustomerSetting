/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240108@Eden
	Task: Create log action for Create New accounts function[#RedmineID:#193083]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 
--NEW LOG ACTION FOR CREATE NEW CUSTOMER

DELETE
FROM LogAction WITH(ROWLOCK,UPDLOCK)
WHERE ActionID IN (
	 263000,263001,263002,263003 --PT
	,262000,262001,262002,262003 --BS
	,261000,261001,261002,261003 --Comm
	)

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
SELECT ActionID = CASE -- PT
					WHEN ActionID = 400 THEN 263000 
					WHEN ActionID = 401 THEN 263001 
					WHEN ActionID = 402 THEN 263002
					WHEN ActionID = 403 THEN 263003
					--BS
					WHEN ActionID = 300 THEN 262000 
					WHEN ActionID = 301 THEN 262001 
					WHEN ActionID = 302 THEN 262002
					WHEN ActionID = 303 THEN 262003
					--Comm
					WHEN ActionID = 200 THEN 261000 
					WHEN ActionID = 201 THEN 261001 
					WHEN ActionID = 202 THEN 261002
					WHEN ActionID = 203 THEN 261003
				END
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
FROM LogAction WITH(NOLOCK)
WHERE ActionID IN(400,401,402,403, 200,201,202,203, 300,301,302,303)

SELECT * 
FROM LogAction WITH(NOLOCK) 
WHERE ActionID IN (
	 263000,263001,263002,263003 --PT
	,262000,262001,262002,262003 --BS
	,261000,261001,261002,261003 --Comm
	)

