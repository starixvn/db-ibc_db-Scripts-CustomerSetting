
    
/*
    Created by: Luke
    Date: 2023/05/17
	Task: Delete data for status lock Basketball [redmine : #185991]
	DB: DBCUST/CustDB

    Revisions: 

	Param's Explanation:  

*/

	DELETE v
	FROM dbo.VRCustLockStatus v WITH (ROWLOCK)
	WHERE Type = 3

    
