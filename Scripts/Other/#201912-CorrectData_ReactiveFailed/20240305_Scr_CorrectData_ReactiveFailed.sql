/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20240305
	Task: Delete all setting of licensee members who reactivation was failed [#201912]
	DB: DBCUST/CustDB
	
*/
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_19]    
AS
BEGIN
    IF dbo.f_CheckRepTable('custinfo') = 0 RETURN

    CREATE TABLE #LstCustID(CustID INT)

	INSERT INTO #LstCustID(CustID)
	SELECT custid
	FROM custinfo WITH(NOLOCK)
	WHERE custid in(
		 48010734--khmerIN01674
		,49161360--X2DynamicTB05975
		,54641257--livv88swRMB0126792
		,54782539--ug396IN01168181
		,54796004--Happy8INH0168197
		,55370378--ALogTB01235346
		,55853147--khmerINH0111299
		,56587474--368CashIN011591484
		,58503576--W88CVINH201385
		,61516743--W88CVINH2013402
		,62380116--AlogINR01100313
		,65716034--ZhiFeng208TB02920
		,65731593--ZhiFeng208TB021068
		,66816468--allwincityRMB015401
		,67341431--ZhiFeng208TB024327
		,69293610--Pay4dIN011745242
		,69307358--IDNSPORTIN011392
		,69352862--IDNSPORTIN014424
		,70384151--IDNSPORTIN0124625
		,72483570--JDYGamingRMB01322051
		,73469866--Pay4dIN012059615
		,73510193--IDNSPORTIN0162372
		,75144688--ZhiFeng208TB0210092
		,75888216--998betTB01102480
		,76003700--X2DynamicTB21318
		,76701172--BGCVRMB20153540
		,78742672--HBPTTB036234
		,80574863--DiamondINH0184614
		,81536995--368CashIN012527976
		,82425130--ZhiFeng208TB0214097
	)

	IF OBJECT_ID('DepositCustomer') IS NOT NULL 
		DELETE DepositCustomer	WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)

	IF dbo.f_CheckRepTable('CustVirtualSetting') = 1 DELETE CustVirtualSetting WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 1 DELETE Dep_CustBetSetting_Member WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 1 DELETE Dep_CustDiscountSetting_Member WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustProductSetting') = 1 DELETE Dep_CustProductSetting WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 1 DELETE Dep_CustProductStatus WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 1 DELETE Dep_CustPTSetting_Member WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustSetting_AGCasino') = 1 DELETE Dep_CustSetting_AGCasino WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustSettingGame') = 1 DELETE Dep_CustSettingGame WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 1 DELETE Dep_CustSettingMode WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 1 DELETE Dep_CustStakeLevel_Member WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 1 DELETE Dep_CustBetSettingGame_Member WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('Customer') = 1 DELETE Customer WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
	IF dbo.f_CheckRepTable('custInfo') = 1 DELETE custInfo WITH(ROWLOCK,UPDLOCK) WHERE CustID IN (SELECT CustID FROM #LstCustID)
END
GO
EXEC [Acc_CustomerInfo_Execrep_19]