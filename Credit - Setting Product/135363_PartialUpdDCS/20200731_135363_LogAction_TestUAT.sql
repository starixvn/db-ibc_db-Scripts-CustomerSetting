/*<info serverAlias=DBLOG-bodb_CustomerLog ></info>*/
/*
    Created: Elodie
    Date: 20200731
    Task: Manage ProductLaunchSiteCurrency / Can See : #135363
    DB: DBLOG/bodb_CustomerLog
*/ 
USE bodb_CustomerLog
GO
UPDATE l
SET SPName = SPName + '_xtest'
FROM LogAction l
WHERE ActionID BETWEEN 448 AND 456

SELECT *
FROM LogAction l
WHERE ActionID BETWEEN 448 AND 456
					