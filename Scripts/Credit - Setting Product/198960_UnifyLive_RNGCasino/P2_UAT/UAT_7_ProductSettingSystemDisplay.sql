/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 2024012@Helios
	Task: Unify Live Casino & RNG slot/RNG Casino - Initial ProductSettingSystemDisplay [#198960] 
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	/*
		SystemID = 5 : External NAP					- Use for updating Bet Setting on External NAP
		SystemID = 9 : 789y External NAP (Bet Setting only)	- Use for updating Bet Setting on External NAP


	*/


	IF NOT EXISTS (SELECT 1 FROM ProductSettingSystemDisplay WITH (NOLOCK) WHERE ProductID IN (41,53) AND SettingType = 21)
	BEGIN
		 INSERT INTO ProductSettingSystemDisplay 
			(
				SystemID
			    , ProductID
			    , SettingType
			    , DisplayMode
			)
		-- Product Status:
			     SELECT 5 ,   41 ,   21 ,   3 
		 UNION ALL SELECT 6 ,   41 ,   21 ,   3 
		 UNION ALL SELECT 7 ,   41 ,   21 ,   3 
		 UNION ALL SELECT 8 ,   41 ,   21 ,   3 
		 UNION ALL SELECT 9 ,   41 ,   21 ,   3 
		 UNION ALL SELECT 5 ,   53 ,   21 ,   3 
		 UNION ALL SELECT 6 ,   53 ,   21 ,   3 
		 UNION ALL SELECT 7 ,   53 ,   21 ,   3 
		 UNION ALL SELECT 8 ,   53 ,   21 ,   3 
		 UNION ALL SELECT 9 ,   53 ,   21 ,   3

		 -- Position Taking:
		 UNION ALL SELECT 5 , 53 , 18 , 3 
		 UNION ALL SELECT 9,  53 , 18 , 3

		 -- Commission:
		 UNION ALL SELECT 5 , 53 , 19 , 3
		 UNION ALL SELECT 9 , 53 , 19 , 3
		 
		 -- Win Loss Limit:
		 UNION ALL SELECT 5 , 53 , 22 , 3
		 UNION ALL SELECT 9 , 53 , 22 , 3 

	END
	