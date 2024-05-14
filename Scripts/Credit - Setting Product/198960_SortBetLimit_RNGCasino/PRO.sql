/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date : 2024/05/14
	Task: Unify Live Casino & RNG slot/RNG Casino - Updated Sort BetLimit [#198960]
		https://nexdev.net/issues/198960
	DB: DBCust/CustDB
*/

UPDATE a 
	SET a.Child_DisplayOrder = CASE 
							 WHEN SportType =  241 THEN 5 
							 WHEN SportType =  176 THEN 10 
							 WHEN SportType =  242 THEN 15 
							 WHEN SportType =  225 THEN 20 
							 WHEN SportType =  170 THEN 25 
							 WHEN SportType =  159 THEN 30 
							 WHEN SportType =  243 THEN 35 
							 WHEN SportType =  211 THEN 40 
							 WHEN SportType =  239 THEN 45 
							 WHEN SportType =  244 THEN 50 
							 WHEN SportType =  228 THEN 55 
							 WHEN SportType =  233 THEN 60 
							 WHEN SportType =  208 THEN 100 
							 WHEN SportType =  200 THEN 200 
					   END
FROM ProductSettingDetail a WITH (ROWLOCK , UPDLOCK)
WHERE ProductID IN ( 41 , 53)
AND SettingType  IN (7,17)



UPDATE a 
	SET a.Child_DisplayOrder = CASE 
							 WHEN SportType =  241 THEN 5 
							 WHEN SportType =  176 THEN 10 
							 WHEN SportType =  242 THEN 15 
							 WHEN SportType =  225 THEN 20 
							 WHEN SportType =  170 THEN 25 
							 WHEN SportType =  159 THEN 30 
							 WHEN SportType =  243 THEN 35 
							 WHEN SportType =  211 THEN 40 
							 WHEN SportType =  239 THEN 45 
							 WHEN SportType =  244 THEN 50 
							 WHEN SportType =  228 THEN 55 
							 WHEN SportType =  233 THEN 60 
							 WHEN SportType =  208 THEN 100 
							 WHEN SportType =  200 THEN 200 
					   END
FROM ProductSettingProfile a WITH (ROWLOCK , UPDLOCK)
WHERE ProductID IN ( 41 , 53)
AND SettingType  IN (7,17)