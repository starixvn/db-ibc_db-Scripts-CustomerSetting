/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220405
	Task:  fix Max Loss Limit setting for FGG [RedmineID:#165684]
	DB: DBCust/CustDB
*/
--step 1: run at @DBCust/CustDB

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('LossLimit_GlobalSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN

	
	CREATE TABLE #tblCust (custid INT, LossLimit MONEY PRIMARY KEY (custid))
	DECLARE @tmpCust TABLE (custid INT, LossLimit MONEY PRIMARY KEY (custid))
	
	--116321 rows affected
	INSERT INTO #tblCust(custid,LossLimit)
	SELECT cs.custid, g.MinLossLimit
		FROM  CustWinLossLimit_Member cs WITH(NOLOCK) 
		INNER JOIN custinfo ci WITH (NOLOCK) on cs.custid = ci.custid
		INNER JOIN LossLimit_GlobalSetting g WITH(NOLOCK) ON g.ProductId = 64 
															AND g.ExchangeId = ci.currency
	WHERE cs.sporttype = 176
		AND cs.MaxLossLimit < g.MinLossLimit
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, DELETED.LossLimit
		INTO @tmpCust 
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0 
			BREAK;
			
		UPDATE cs
		SET cs.MaxLossLimit = t.LossLimit
		FROM CustWinLossLimit_Member cs WITH(ROWLOCK) 
			INNER JOIN @tmpCust t ON cs.custid = t.custid 
									AND cs.sporttype = 176
		
		DELETE @tmpCust
	END
	
	--25060 rows affected
	INSERT INTO #tblCust(custid,LossLimit)
	SELECT cs.custid, g.MinLossLimit
		FROM  CustWinLossLimit_Agent cs WITH(NOLOCK) 
		INNER JOIN custinfo ci WITH (NOLOCK) on cs.custid = ci.custid
		INNER JOIN LossLimit_GlobalSetting g WITH(NOLOCK) ON g.ProductId = 64 
															AND g.ExchangeId = ci.currency
	WHERE cs.sporttype = 176
		AND cs.MaxLossLimit < g.MinLossLimit
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid, DELETED.LossLimit
		INTO @tmpCust
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0 
			BREAK;
			
		UPDATE cs
		SET cs.MaxLossLimit = t.LossLimit
		FROM CustWinLossLimit_Agent cs WITH(ROWLOCK) 
			INNER JOIN @tmpCust t ON cs.custid = t.custid 
									AND cs.sporttype = 176
		
		DELETE @tmpCust
	END
END
GO
------------------------------------------------

--step 2: run at DBCust/CustDB ONLY
EXEC Acc_DynamicCustSetting3rd_09
GO

--step 3: fix data line test auto for QC
select * from CustDirectAccount (nolock) 
where CustID in (select CustID 
from custInfo (nolock) where srecommend=21984259 and roleid<4)

DELETE CustDirectAccount WITH(rowlock) 
WHERE custid IN (21984381,22037048)

