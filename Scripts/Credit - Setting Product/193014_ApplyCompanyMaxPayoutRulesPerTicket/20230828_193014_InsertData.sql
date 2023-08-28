/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Luke@20230828
    Task: Add data for Winlimit_LevelSetting, Winlimit_ActionSetting [Redmine: #193014]
    DB: DBCUST/CustDB
*/ 

USE CustDB 
GO 

INSERT INTO Winlimit_LevelSetting(LevelID, LevelName, LevelOrder) VALUES
	(255, 'Max Payout', 255)

INSERT INTO Winlimit_ActionSetting(ActionID, ActionName) VALUES
	(255, 'Max Payout Notification')
