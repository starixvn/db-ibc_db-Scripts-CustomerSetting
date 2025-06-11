/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]   
	DB: DBCUST/AgencyCashService
*/

SET NOCOUNT ON;

DECLARE @Site	VARCHAR(20) = '222227'

DECLARE @AgentList TABLE (AgentID INT)

INSERT INTO @AgentList (AgentID)
VALUES
-- SIT
(24974518),
(24981287),
(24981575),
(25016643),
(25016644),
(25016645),
(25016660),
(25016661),
(25016662),
(25016663),
(25016664),
(25016665);

IF NOT EXISTS (SELECT TOP 1 1 FROM CustDB.dbo.Customer vcsc WITH(NOLOCK)
		   INNER JOIN @AgentList al ON vcsc.custid = al.AgentID
		   --WHERE vcsc.site = @Site 
		   )
BEGIN
	SELECT N'AgentID input validate' AS ErrMsg
	RETURN
END

------------------------------START INIT---------------------------------------
IF NOT EXISTS (SELECT TOP 1 1 
		   FROM CashAgentProviderConfig c WITH (NOLOCK) 
		   INNER JOIN @AgentList al ON c.AgentID = al.AgentID
		   WHERE ProviderID IN (1,2))
BEGIN
	INSERT INTO CashAgentProviderConfig 
	(
		  AgentID
		, ProviderID
		, ProviderStatus
		, ChannelContact
		, RepUpdateTime
	)

	SELECT AgentID , 1 , 0 ,  N'{"Tele": "https://t.me/+OaxFOV0pRmq5ZTY1"}', SYSDATETIME () FROM @AgentList
	--UNION ALL
	--SELECT AgentID , 2 , 0 ,  N'{"Tele": "https://t.me/+OaxFOV0pRmq5ZTY1"}', SYSDATETIME () FROM @AgentList
END

IF NOT EXISTS (SELECT TOP 1 1 FROM CashAgentBankAccountLimit c WITH (NOLOCK) INNER JOIN @AgentList al ON c.AgentID = al.AgentID )
BEGIN
	INSERT INTO CashAgentBankAccountLimit 
	(
		AgentID
	    , MinPerDeposit
	    , MaxPerDeposit
	    , MinPerWithdrawal
	    , MaxPerWithdrawal
	    , RepUpdateTime
	)
	SELECT AgentID , 0 , 0 , 0 , 0 , SYSDATETIME () FROM @AgentList
END

IF NOT EXISTS (SELECT TOP 1 1 FROM CashDomainManagement c WITH (NOLOCK) INNER JOIN @AgentList al ON c.AgentID = al.AgentID )
BEGIN
	INSERT INTO CashDomainManagement 
	(
		AgentId
	    , DomainId
	    , SubDomainPrefix
	    , RepUpdateTime
	)	
	SELECT 
	    a.AgentID,
	    d.DomainID,
	    'simplec-' + CAST(AgentID AS VARCHAR) AS SubDomainPrefix,
	    SYSDATETIME ()
	FROM @AgentList a
	CROSS APPLY (
	    SELECT TOP 2  DomainID FROM CustDB.dbo.DomainManagement dm WITH (NOLOCK) 
	    WHERE dm.System = 'Member'
	    --AND dm.OfferType = 1
	    ORDER BY DomainID
	) d;
END

IF NOT EXISTS (SELECT TOP 1 1 FROM CashAgentManagement c WITH (NOLOCK) INNER JOIN @AgentList al ON c.AgentID = al.AgentID )
BEGIN
	INSERT INTO CashAgentManagement 
	(
		AgentId
	    , SettingInfo
	    , Mobile
	    , Contact
	    , Announcement
	    , DailyWithdrawalCount
	    , StartTime
	    , TrialEndTime
	    , RepUpdateTime
	)
	SELECT AgentID , 3 , NULL , N'[{"type":"line","value":""},{"type":"tele","value":""}]' , NULL , 1 , GETDATE () ,  DATEADD(DAY, 13, GETDATE ()) AS trialEndTime , SYSDATETIME () FROM @AgentList
END


/*IGNORE  
--SELECT * FROM dbo.CashAgentBankAccount;
--SELECT * FROM dbo.CashMemberBankAccount;
--SELECT * FROM dbo.CashPaymentProviderAPIConfig;
--SELECT * FROM dbo.CashAgentPaymentMethod;

SELECT * FROM dbo.CashAgentBankAccountLimit;
SELECT * FROM dbo.CashAgentManagement;
SELECT * FROM dbo.CashAgentProviderConfig;
SELECT * FROM dbo.CashDomainManagement;


SELECT * FROM dbo.CashPaymentMethod;
SELECT * FROM dbo.CashPaymentProvider;
SELECT * FROM dbo.CashBankConfig;
SELECT * FROM dbo.CashBankList;
SELECT * FROM dbo.CashPaymentProviderInfo;
SELECT * FROM dbo.CashProviderConfig;
SELECT * FROM dbo.CashSiteConfig;

*/