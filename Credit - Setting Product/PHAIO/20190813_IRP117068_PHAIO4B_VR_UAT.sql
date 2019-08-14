/*
	Created: Winnie
	Date: 2019-08-13
	Task: Insert [Sport_Bettype_Reference_VirtualRate] for PHAIO 4B
	DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

INSERT INTO [dbo].[Sport_Bettype_Reference_VirtualRate]
           ([SportType]
           ,[BetType]
           ,[SportTypeRefVirtualRate]
           ,[BetTypeRefVirtualRate]
           ,[isActive])
SELECT 1,	470,	1,	2,	0
UNION ALL
SELECT 1,	471,	1,	12, 0
UNION ALL
SELECT 1,	472,	1,	2,	0
UNION ALL
SELECT 1,	482,	1,	3,	0
UNION ALL
SELECT 1,	483,	1,	3,	0
UNION ALL
SELECT 1,	484,	1,	8,	0
UNION ALL
SELECT 1,	485,	1,	8,	0
