/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created by: Luke
    Date: 2023/05/17
	Task:  Initial data for status lock Basketball [redmine : #187460]
	DB: DBCUST/CustDB

    Revisions: 

	Param's Explanation:  

*/

	DELETE v
	FROM dbo.VRCustLockStatus v WITH (ROWLOCK)
	WHERE Type = 3

    
