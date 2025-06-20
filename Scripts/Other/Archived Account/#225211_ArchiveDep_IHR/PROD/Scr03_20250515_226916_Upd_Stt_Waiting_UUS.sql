/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: 20250515@Tacy
	Task: archive members UUS - Update stt='Waiting' [#226916]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE Dep_Customer_Archived WITH (ROWLOCK, UPDLOCK)
SET [Status] ='waiting'
	,RepUpdateTime=dbo.f_GetDateTime2()
where CustID in (45784682
				,45784716
				,45986990
				,45987023
				,45987200
				,63885524
				,64008503)	-- SW site
GO