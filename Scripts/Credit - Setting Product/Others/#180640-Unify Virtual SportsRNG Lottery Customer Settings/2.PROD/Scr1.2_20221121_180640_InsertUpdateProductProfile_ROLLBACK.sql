/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Edit some setting of VS and RNG Lottery - ROLLBACK [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
	DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE ProductID IN(5,44)

	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	)
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	FROM ProductSettingDetail_BU_180640 WITH(NOLOCK)
	WHERE ProductID IN(5,44)

	--> Update ProductStatusProfile of VS, Lottery
	UPDATE a
	SET a.Sporttype = 180
	FROM ProductStatusProfile a WITH(ROWLOCK) 
	WHERE bitmapOrder = 10

	UPDATE a
	SET a.Bettype = 1021
	FROM ProductStatusProfile a WITH(ROWLOCK) 
	WHERE bitmapOrder = 11
	
	--Insert temp bitmap order to test Status ( will be delete when remove)
	IF NOT EXISTS( 
					SELECT 1 
					FROM ProductStatusProfile WITH(NOLOCK) 
					WHERE bitmapOrder IN(2,3)
				)
		INSERT INTO ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
		SELECT 220,1024,3 UNION ALL
		SELECT 9908,1201, 2
	

/*
SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 5 

SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 44 

SELECT * FROM ProductStatusProfile WITH(NOLOCK) ORDER BY bitmapOrder

*/