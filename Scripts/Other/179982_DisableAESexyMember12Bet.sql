/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20221101
	Task: [AE Sexy] - Disable the setting for a 12Bet member [Redmine: 179982]
	DB: DBCUST/CustDB
*/

DECLARE @SportType INT = 243, @BetType INT=3101,@CustID	INT = 55610835 -- N'12BETINH0191760'
		,@BitOrder INT

SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype AND Bettype  = @BetType

UPDATE c 
SET  c.bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,1))
FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
WHERE c.CustID = @CustID
