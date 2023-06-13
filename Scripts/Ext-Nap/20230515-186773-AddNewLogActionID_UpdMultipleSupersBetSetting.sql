/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230515@Tacy
	Task: Insert new ActionID on table LogAction & LogActionDetail on UAT [redmine:#186773]
		https://nexdev.net/issues/186773
	DB: DBLOG.bodb_CustomerLog
*/
--LogAction
INSERT INTO LogAction ([ActionID], [ActionTypeID], [SPName], [ActionNameEN], [ActionNameCH], [ActionNameCS], [ActionNameJP], [ActionNameTH], [ActionNameKO], [IsInternal], [ActionNameVI])
VALUES
(220035,3,'Acc_CustomerUpd_BetSetting_xtest','Indirectly update Multiple Sportsbook Bet Setting for Super','Indirectly update Multiple Sportsbook Bet Setting for Super','Indirectly update Multiple Sportsbook Bet Setting for Super','Indirectly update Multiple Sportsbook Bet Setting for Super','Indirectly update Multiple Sportsbook Bet Setting for Super','Indirectly update Multiple Sportsbook Bet Setting for Super',0,'Indirectly update Multiple Sportsbook Bet Setting for Super'),
(220036,3,'Acc_CustomerUpd_BetSetting_xtest','Update Multiple Sportsbook Bet Setting for Super','Update Multiple Sportsbook Bet Setting for Super','Update Multiple Sportsbook Bet Setting for Super','Update Multiple Sportsbook Bet Setting for Super','Update Multiple Sportsbook Bet Setting for Super','Update Multiple Sportsbook Bet Setting for Super',0,'Update Multiple Sportsbook Bet Setting for Super')

--LogActionDetail
INSERT INTO LogActionDetail (ActionID, ProductID, Level)
SELECT 220035,1,4
UNION
SELECT 220036,1,4