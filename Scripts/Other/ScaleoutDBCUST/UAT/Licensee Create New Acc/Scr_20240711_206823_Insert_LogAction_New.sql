/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20240216@Eden
	Task: Create log action [#RedmineID:#204358]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 

DELETE FROM LogAction WITH(ROWLOCK,UPDLOCK) WHERE  ActionID IN (271000,271001,271003,271004)
--Insert data
DECLARE @Log TABLE ( 
		  ActionID INT
		, ActionNameEN NVARCHAR(256)
		, SPName VARCHAR(50)
	)
DECLARE @ActionTypeID INT = NULL, @IsInternal BIT = 0

INSERT INTO @Log (ActionID, SPName, ActionNameEN)
SELECT 271000,'API_CustomerIns_Member','Create New Licensee Member' UNION ALL
SELECT 271001,'API_CustomerReactive_Insert','Reactive Archive Member by IT Admin'
INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameIT,ActionNameCN)
SELECT ActionID, SPName, @ActionTypeID, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, ActionNameEN, @IsInternal, ActionNameEN, ActionNameEN, ActionNameEN
FROM @Log

INSERT INTO LogAction (ActionID,ActionTypeID,SPName,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,XsltContent,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID = CASE		WHEN ActionID = 2214		THEN 271003 --Create Licensee
							WHEN ActionID = 2216		THEN 271004 --Create Currency for Licensee
					END
	,ActionTypeID
	,SPName = 'API_SiteBuilder_Licensee_Insert'
	,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameIT,ActionNameTH,ActionNameKO,XsltContent,IsInternal,ActionNameVI,ActionNameCN
FROM LogAction WITH(NOLOCK)
WHERE ActionID IN(2214,2216)

SELECT * FROM LogAction (NOLOCK)  WHERE ActionID IN (271000,271001,271003,271004)
GO