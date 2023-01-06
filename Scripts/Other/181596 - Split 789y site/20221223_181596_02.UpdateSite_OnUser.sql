/*<info serverAlias="DBONUSER-ON_USER"></info>*/
/*
	Created: 20221223@Tacy
	Task: Update new sites (yUT, y789, y889, yOther) for users
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBONUSER/ON_USER
*/
CREATE TABLE #On_User ([on_userid] INT NOT NULL, IsFinished BIT DEFAULT(0))
CREATE TABLE #On_User_batch ([on_userid] INT NOT NULL)

INSERT INTO #On_User
SELECT [on_userid]
FROM ON_USER WITH (NOLOCK)
WHERE Site='789y'

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #On_User_batch

	UPDATE TOP (5000) t
	SET t.IsFinished=1
	OUTPUT inserted.on_userid INTO #On_User_batch (on_userid)
	FROM #On_User t
	 
	IF @@ROWCOUNT=0
		BREAK;

	UPDATE a
	SET a.Site=c.site
	FROM ON_USER a WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #On_User_batch t on a.on_userid=t.on_userid
	INNER JOIN DBCust.CustDB.dbo.Customer c WITH (NOLOCK) ON c.CustID=a.custid

	WAITFOR DELAY '00:00:0.100'
END