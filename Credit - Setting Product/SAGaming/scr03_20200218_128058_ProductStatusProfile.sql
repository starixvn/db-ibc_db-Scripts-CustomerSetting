/*
	Created: 20200218@Tiara
	Task: Insert Product Status Profile for SA Gaming [Redmine: 128058]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype = 244 AND P.Bettype = 3001

INSERT INTO [dbo].[ProductStatusProfile]([Sporttype],[Bettype],[bitmapOrder]) VALUES (244,3001,20)

