/*
	Created: 20200218@Tiara
	Task: Insert Product Status Profile for SA Gaming and Sexy Gaming [Redmine: 128058]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 
-----------------------------------------------------------
USE CustDB
GO

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK)
WHERE P.Sporttype IN (243, 244) AND P.Bettype IN (3001, 3101)

INSERT INTO [dbo].[ProductStatusProfile]([Sporttype],[Bettype],[bitmapOrder]) VALUES (243,3101,22)
INSERT INTO [dbo].[ProductStatusProfile]([Sporttype],[Bettype],[bitmapOrder]) VALUES (244,3001,20)
