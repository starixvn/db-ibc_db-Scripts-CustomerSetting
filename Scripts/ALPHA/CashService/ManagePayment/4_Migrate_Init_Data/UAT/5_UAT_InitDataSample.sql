/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]   
	DB: DBCUST/AgencyCashService
*/

SET NOCOUNT ON;

DECLARE @Site	VARCHAR(20) = '222227'

DECLARE @AgentList TABLE (UserName VARCHAR(30) , AgentID INT) 

INSERT INTO @AgentList ( UserName , AgentID)
VALUES
-- UAT 
--('SUPERTESTSH277I10000', 0),
--('SUPERTESTTE070000', 0),
--('SUPERTESTTE070001', 0),
--('SUPERTESTTE070100', 0),
--('SupertestTE070101', 0),
--('SUPERTESTTE070200', 0),
--('SUPERTESTTE080000', 0),
--('Supertestte080101', 0),
--('SUPERTESTTE080100', 0),
--('SUPERTESTTE080102', 0),
--('SUPERTESTTE080103', 0);
--PRO
('SUPERTESTAC010101', 0),
('SUPERTESTAC010102', 0),
('SUPERTESTAC010103', 0),
('SUPERTESTAC010104', 0),
('SUPERTESTAC010105', 0);


UPDATE al SET al.AgentID = c.custid
FROM @AgentList al
INNER JOIN CustDB.dbo.Customer c WITH (NOLOCK) ON al.UserName = c.username


IF NOT EXISTS (SELECT TOP 1 1 FROM @AgentList)
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

	SELECT AgentID , 1 , 1 ,  N'{"Tele": "https://t.me/+XxIV3WPg3gc3NTM1"}', SYSDATETIME () FROM @AgentList
	--UNION ALL
	--SELECT AgentID , 2 , 0 ,  N'{"Tele": "https://t.me/+XxIV3WPg3gc3NTM1"}', SYSDATETIME () FROM @AgentList
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
	    SELECT TOP 2  DomainID FROM GlobCustDB.dbo.DomainManagement dm WITH (NOLOCK) 
	    WHERE dm.System = 'Member'
	    AND dm.OfferType = 1
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


--SELECT * FROM @AgentList
--SELECT * FROM CashAgentProviderConfig	WITH (NOLOCK)
--SELECT * FROM CashAgentBankAccountLimit	WITH (NOLOCK)
--SELECT * FROM CashDomainManagement		WITH (NOLOCK)
--SELECT * FROM CashAgentManagement		WITH (NOLOCK)


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