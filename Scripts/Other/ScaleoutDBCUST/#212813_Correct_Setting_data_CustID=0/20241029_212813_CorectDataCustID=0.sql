/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20241029
	Task: Correct data CustID = 0 [Redmine: #212813]  
	DB: DBCUST-CustDB
*/
USE [CustDB]
GO
DECLARE @custid INT = 0

DELETE CustMaster WITH(ROWLOCK) WHERE custid = @custid
	
DELETE CustLoginInfo WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustLoginInfoSub WITH(ROWLOCK) WHERE custid = @custid	

DELETE dbo.CustDirectAccount WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.Acc_CustAllowList WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.Acc_CustDirect WITH(ROWLOCK) WHERE custid = @custid	

DELETE dbo.custAccount WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustGroupHeadline WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustNoComm WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustOTP WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustOTPDetail WITH(ROWLOCK) WHERE custid = @custid	
DELETE dbo.CustRequestGame WITH(ROWLOCK) WHERE custid = @custid	
	

--DCS table
DELETE dbo.CustProductStatus WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustPTSetting3rd_Agent WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustSettingMode3rd WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustStakeLevel_Agent WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustWinLossLimit_Agent WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustBetSetting3rd_Agent WITH(ROWLOCK) WHERE custid = @custid
DELETE dbo.CustDiscount3rd_Agent WITH(ROWLOCK) WHERE custid = @custid	

DELETE dbo.BetSetting3rd_Agent WITH(ROWLOCK) 
OUTPUT deleted.CustID, deleted.Sporttype, deleted.BetType, dbo.f_GetDateTime2() 
INTO BetSetting3rd_Agent_Del_Inhouse(CustID,Sporttype,Bettype,RepUpdateTime)
WHERE custid = @custid

DELETE BetSetting_Agent WITH (ROWLOCK)
OUTPUT DELETED.[CustID],DELETED.[Sporttype],DELETED.[Bettype],dbo.f_GetDateTime2()
INTO [BetSetting_Agent_Del_InHouse]([CustID],[Sporttype],[Bettype],[RepUpdateTime])
WHERE custID = @custid
	
DELETE c
OUTPUT deleted.custid, deleted.seqNo, [dbo].[f_GetDateTime2]() 
INTO CustVirtualSetting_Del_Inhouse(custid,seqNo,RepUpdateTime)
FROM CustVirtualSetting c WITH(ROWLOCK) 
WHERE custid = @custid

DELETE custinfo WITH(ROWLOCK) WHERE custid = @custid
DELETE customer WITH(ROWLOCK) WHERE custid = @custid	