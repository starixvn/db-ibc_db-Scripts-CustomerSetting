/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 23/05/2023
	Task: Remove Pub/Replicated of Table Age_CustProfilePicture AND Drop Old Table Age_CustProfilePicture [Redmine:#186502]	
	DB: Remove Old Structure of Table Age_CustProfilePicture on DBCUST and all replicated servers relate (DB05X , DB04X , DB06X , DBTP10C)
*/
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Age_CustProfilePicture]') AND type in (N'U'))
DROP TABLE [dbo].[Age_CustProfilePicture]
GO


