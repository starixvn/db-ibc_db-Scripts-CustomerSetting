/*
	Created by: Eden
	Date: 2019-08-13
	Task: Kick Out Online Users
	DB: DBCUST/NAP_UserControl
*/ 
-------------------------------------------------
USE NAP_UserControl

DELETE
FROM  [dbo].[eaOn_User] WITH(ROWLOCK)
WHERE iskickedout = 0 