/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Edit some setting of VS and RNG Lottery - ROLLBACK [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
	DELETE FROM ProductSettingDetail WITH(ROWLOCK) WHERE ProductID IN(44)

	INSERT INTO ProductSettingDetail(SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	)
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel
							,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder,SubType
	FROM ProductSettingDetail_BU_179711 WITH(NOLOCK)
	WHERE ProductID IN(44)

/*
SELECT *
FROM ProductSettingDetail p WITH(NOLOCK) 
WHERE productid = 44 
*/