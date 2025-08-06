/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250801@Dave
	Task : add MsgError  [redmine:#233474]
	
*/
USE CustDB
GO

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN]
           ,[MsgNameIN]
		   ,[RepUpdateTime])
VALUES
 (50039, 6, 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	1, 
	N'Cannot reset Current win Amount. This member is not a Cash member.', 
	N'Cannot reset Current win Amount. This member is not a Cash member.',
	dbo.f_GetDateTime2()),
 (50040, 6, 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	1, 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	N'Cannot reset Accumulated win Amount. This member is not a Cash member.', 
	dbo.f_GetDateTime2()),
 (50041, 6, 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	1, 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	N'Cannot reset Current win Amount. This member has an auto-reset win/loss limit for this Product.', 
	dbo.f_GetDateTime2()),
 (50042, 6, 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	1, 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	N'Cannot reset Accumulated win Amount. This member has an auto-reset potential winning limit.', 
	dbo.f_GetDateTime2())