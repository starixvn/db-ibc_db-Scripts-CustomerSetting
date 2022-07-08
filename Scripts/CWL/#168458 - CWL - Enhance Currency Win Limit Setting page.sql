
/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/

/*
	Created by: Robert@20220708
	Task: Insert LogAction for Currency Win Limit Setting page  [Redmine:# 168458]	
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog];
GO

DECLARE 
	@tmpAction TABLE
				  (
	ActionID     INT, 
	ActionName   NVARCHAR(256), 
	SPName       VARCHAR(50), 
	IsInternal   BIT, 
	ActionTypeId INT, 
	Level        TINYINT
				  );
INSERT INTO @tmpAction
   (
	  ActionID, 
	  ActionName, 
	  SPName, 
	  IsInternal, 
	  ActionTypeId, 
	  Level
   )
	  SELECT 
		    31211, 
		    'Insert games into a product by Admin', 
		    'NAP_Winlimit_GameGroupSettingIns', 
		    0, 
		    0, 
		    NULL;
	

DELETE l
FROM dbo.LogAction l
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID;

INSERT INTO dbo.LogAction
   (
	  ActionID, 
	  SPName, 
	  ActionTypeID, 
	  ActionNameEN, 
	  ActionNameCH, 
	  ActionNameCS, 
	  ActionNameJP, 
	  ActionNameTH, 
	  ActionNameKO, 
	  IsInternal, 
	  ActionNameVI, 
	  ActionNameCN
   )
	  SELECT 
		    ActionID, 
		    SPName, 
		    ActionTypeID, 
		    ActionName, 
		    ActionName, 
		    ActionName, 
		    ActionName, 
		    ActionName, 
		    ActionName, 
		    IsInternal, 
		    ActionName, 
		    ActionName
	  FROM @tmpAction t
	  WHERE NOT EXISTS
				   (
					  SELECT 
						    1
					  FROM LogAction
					  WHERE ActionID = t.ActionID
				    );

