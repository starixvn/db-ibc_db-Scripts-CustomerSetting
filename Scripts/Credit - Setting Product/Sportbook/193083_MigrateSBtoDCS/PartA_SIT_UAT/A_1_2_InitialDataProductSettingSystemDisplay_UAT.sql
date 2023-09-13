/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Data ProductSettingSystemDisplay  [#193083] 
	DB: DBCust/CustDB 
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------4.ProductSettingSystemDisplay------------------------------------

	IF NOT EXISTS ( 
					SELECT 1
					FROM  ProductSettingSystemDisplay WITH (NOLOCK)
					WHERE ProductId = 1
	)
	
	--DisplayMode:
	--1 - Update
	--2 - Read Only
	--3 - Hidden

	INSERT INTO ProductSettingSystemDisplay (SystemID , ProductID , SettingType , DisplayMode)
	-- System Description: Alpla For Agents - SystemID = 2
		SELECT 2 , 1 , 13 , 3 
	-- System Description: Alpha For Interal Login - SystemID = 3
	UNION SELECT 3 , 1 , 13 , 3 
	-- System Description: External NAP - SystemID = 4
	UNION SELECT 4 , 1 , 13 , 3 
	-- System Description: Use for updating Bet Setting on External NAP - SystemID = 5
	UNION SELECT 5 , 1 , 13 , 3 
	UNION SELECT 5 , 1 , 25 , 3 
	UNION SELECT 5 , 1 , 28 , 3 
	-- System Description: 789y Alpla For Agents - SystemID = 6
	UNION SELECT 6 , 1 , 13 , 3 
	-- System Description: 789y Alpha For Interal Login - SystemID = 7
	UNION SELECT 7 , 1 , 13 , 3 
	-- System Description: 789y External NAP - SystemID = 8
	UNION SELECT 8 , 1 , 13 , 3 
	-- System Description: Use for updating Bet Setting on External NAP - SystemID = 9
	UNION SELECT 9 , 1 , 13 , 3 
	UNION SELECT 9 , 1 , 25 , 3 
	UNION SELECT 9 , 1 , 28 , 3 