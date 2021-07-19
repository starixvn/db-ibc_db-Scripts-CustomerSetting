/*
    Created: Tiara
    Date: 2020-02-17
    Task : Insert data to VRSettingHierarchy table for New VR Soccer on UAT
    DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (154,1,-1,-1,-1,0,1,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (330,1,11,-1,-1,154,177,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (331,1,11,6,-1,330,178,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (332,1,11,6,1,331,179,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (333,1,11,6,7,331,180,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (334,1,11,6,17,331,181,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (335,1,11,7,-1,330,182,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (336,1,11,7,2,335,183,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (337,1,11,7,12,335,184,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (338,1,11,7,184,335,185,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (339,1,11,7,472,335,186,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (340,1,11,7,393,335,187,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (341,1,11,7,394,335,188,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (342,1,11,7,400,335,189,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (343,1,11,7,137,335,190,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (344,1,11,7,139,335,191,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (345,1,11,7,136,335,192,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (346,1,11,7,138,335,193,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (347,1,11,7,194,335,194,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (348,1,11,7,203,335,195,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (349,1,11,8,-1,330,196,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (350,1,11,8,3,349,197,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (351,1,11,8,8,349,198,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (352,1,11,8,461,349,199,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (353,1,11,8,462,349,200,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (354,1,11,8,482,349,201,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (355,1,11,8,483,349,202,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (356,1,11,8,463,349,203,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (357,1,11,8,464,349,204,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (358,1,11,8,484,349,205,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (359,1,11,8,485,349,206,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (360,1,11,8,386,349,207,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (361,1,11,8,387,349,208,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (362,1,11,8,388,349,209,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (363,1,11,8,389,349,210,NULL,NULL)
INSERT INTO [dbo].[VRSettingHierarchy]  ([LevelID], [SportType], [VRLeagueGroupID], [VRBettypeGroupID], [BetType], [ParentLevelID], [SortOrder], [BitmapOrderAutoSuspend], [VRAutoSuspendThreshold]) VALUES (364,1,11,8,18,349,211,NULL,NULL)