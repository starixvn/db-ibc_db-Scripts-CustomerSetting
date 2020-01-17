/*
	Created: Johnson
	Date: 2020-01-15
	Task: update robotdate for IBO members	
	DB: DBONUSER/ON_USER 
*/
--update robotdate for these customers

UPDATE RobotUsers WITH(UPDLOCK,ROWLOCK)
SET RobotDate = LastChangeTime
WHERE custid IN (1,2,xxx)

