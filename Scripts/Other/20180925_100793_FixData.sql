/*
	Created by: Winnie
	Created Date: 20180925
	Description: fix data SIT
	Database: DBCUST/[CustDB]
		
*/
USE [CustDB]
GO

DELETE FROM [GameGroup]
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (1, 212, 4001, N'Level 1', 0)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (2, 212, 4001, N'Level 2', 0)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (3, 212, 4001, N'Level 1', 1)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (4, 212, 4001, N'Level 2', 1)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (5, 212, 4001, N'Level 3', 1)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (6, 248, 4101, N'Level 1', 0)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (7, 248, 4101, N'Level 2', 0)
INSERT [dbo].[GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit]) VALUES (8, 248, 4101, N'Level 1', 1)
