/*<info serverAlias="DBONUSER-ON_USER"></info>*/
/*
	Created: 20230105@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for users
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBONUSER/ON_USER
*/
CREATE TABLE #RobotUsers ([custid] INT NOT NULL, IsFinished BIT DEFAULT(0))
CREATE TABLE #RobotUsers_batch ([custid] INT NOT NULL)

INSERT INTO #RobotUsers
SELECT custid
FROM RobotUsers WITH (NOLOCK)
WHERE Site='789y'

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #On_User_batch

	UPDATE TOP (5000) t
	SET t.IsFinished=1
	OUTPUT inserted.custid	 INTO #RobotUsers_batch (custid)
	FROM #RobotUsers t
	 
	IF @@ROWCOUNT=0
		BREAK;

	UPDATE a
	SET a.Site=c.site
	FROM RobotUsers a WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #RobotUsers_batch t on a.custid=t.custid
	INNER JOIN DBCust.CustDB.dbo.Customer c WITH (NOLOCK) ON c.CustID=a.custid

	WAITFOR DELAY '00:00:0.100'
END