/*
    Created: Tiara
    Date: 2020-01-13
    Task : Insert data to VRBettypeGroup table for New VR Soccer
    DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO [dbo].[VRBettypeGroup]  ([GroupID], [GroupName], [SportType]) VALUES (6,'Handicap',1)
INSERT INTO [dbo].[VRBettypeGroup]  ([GroupID], [GroupName], [SportType]) VALUES (7,'Odd/Even',1)
INSERT INTO [dbo].[VRBettypeGroup]  ([GroupID], [GroupName], [SportType]) VALUES (8,'Over/Under',1)