/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210519@Tina
	Task: Replace text VGaming to Vgaming [#RM:153938]
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

UPDATE LA
SET ActionNameEN = REPLACE(ActionNameEN,'VGaming','Vgaming'),
	ActionNameCH = REPLACE(ActionNameCH,'VGaming','Vgaming'),
	ActionNameCS = REPLACE(ActionNameCS,'VGaming','Vgaming'),
	ActionNameJP = REPLACE(ActionNameJP,'VGaming','Vgaming'),
	ActionNameTH = REPLACE(ActionNameTH,'VGaming','Vgaming'),
	ActionNameKO = REPLACE(ActionNameKO,'VGaming','Vgaming'),
	ActionNameVI = REPLACE(ActionNameVI,'VGaming','Vgaming')
FROM dbo.LogAction LA WITH (ROWLOCK,UPDLOCK)
WHERE ActionNameEN LIKE '%VGaming%'
	AND ActionID IN (60530, 60531, 65560, 65561, 65562 , 65563
				, 70590, 70591, 70592, 70593, 70594, 70595, 75620
				, 75621, 75622, 75623, 75624, 75625, 75626, 75627)

/*
SELECT *
FROM dbo.LogAction LA WITH (NOLOCK)
WHERE ActionNameEN LIKE '%Vgaming%'
	AND ActionID IN (60530, 60531, 65560, 65561, 65562 , 65563
				, 70590, 70591, 70592, 70593, 70594, 70595, 75620
				, 75621, 75622, 75623, 75624, 75625, 75626, 75627)
*/