/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]  
	DB: DBCUST/AgencyCashService
*/

--*************************PaymentProvider*************************

SET NOCOUNT ON;

INSERT INTO CashPaymentProvider 
(
	  ProviderName
	, RepUpdateTime
)
SELECT N'U2Pay',SYSDATETIME ()
--UNION ALL
--SELECT N'ThaiPay',SYSDATETIME ()



--*************************PaymentMethod*************************

INSERT INTO CashPaymentMethod 
(
	  MethodName
	, RepUpdateTime
)
VALUES
    (N'ATM'			, SYSDATETIME()),
    (N'Internet Banking', SYSDATETIME()),
    (N'PromptPay'		, SYSDATETIME()),
    (N'THAI QR'		, SYSDATETIME()),
    (N'truemoney'		, SYSDATETIME()),
    (N'Bank Transfer'	, SYSDATETIME());



--*************************CashPaymentProviderInfo*************************

INSERT INTO CashPaymentProviderInfo
	(
		ProviderID
	    , PaymentMethodID
	    , TransactionType
	    , FeeRate
	    , MinAmountTrans
	    , MaxAmountTrans
	    , RepUpdateTime
	)
SELECT 
    p.ProviderID,
    pm.PaymentMethodID,
    CASE
	WHEN pm.PaymentMethodID = 6 THEN 2
	ELSE 1
    END AS TransactionType,
    CASE
	WHEN pm.PaymentMethodID IN (1,2,3,4) THEN 1.5
	WHEN pm.PaymentMethodID = 5 THEN 2
	ELSE 0
    END AS FeeRate,
    100 AS MinAmountTrans,
    5000 AS MaxAmountTrans,
    --pm.MethodName,
    SYSDATETIME ()
FROM dbo.CashPaymentProvider p WITH (NOLOCK)
CROSS APPLY (
    SELECT 
        pm.PaymentMethodID,
        pm.MethodName,
        pm.RepUpdateTime
    FROM dbo.CashPaymentMethod pm WITH (NOLOCK)
) pm
ORDER BY P.ProviderID




DECLARE @Site	NVARCHAR(50) = '222227'
,	@SiteID	INT

--*************************CashProviderConfig*************************
SELECT @SiteID = (SELECT SiteId FROM CustDB.dbo.Site s WITH (NOLOCK) WHERE s.site =  @Site)


INSERT INTO CashProviderConfig 
	(
		SiteID
	    , ProviderID
	    , RepUpdateTime
	)
SELECT @SiteID , 1 , SYSDATETIME ()
--UNION ALL
--SELECT @SiteID , 2 , SYSDATETIME ()

INSERT INTO CashSiteConfig 
	(
		SiteId
	    , CountryCode
	    , RepUpdateTime
	)
SELECT @SiteID , 66 , SYSDATETIME ()

--*************************BankList*************************

INSERT INTO CashBankList (BankCode, BankName, TransTypeList, DepositMode) VALUES
('KKR', N'Kasikornbank (K-Bank)', '1,3', '{}'),
('UOB', N'United Overseas Bank (UOB ibanking)', '1,3', '{}'),
('TMB', N'TMBThanachart Bank (TMB Internet Banking)', '1,3', '{}'),
('SCB', N'Siam Commercial Bank (SCB Easy Net)', '1,3', '{}'),
('KTB', N'Krung Thai Bank (KTB netbank)', '1,3', '{}'),
('KNK', N'Kiatnakin Bank', '1,3', '{}'),
('GSB', N'Gov. Savings Bank (GSB Internet Banking)', '1,3', '{}'),
('CIMBT', N'CIMB Thai (CIMB Clicks)', '1,3', '{}'),
('BOA', N'Bank of Ayudhya - Krungsri Bank', '1,3', '{}'),
('BBL', N'Bangkok Bank (Bualuang iBanking)', '1,3', '{}'),
('TBank', N'Thanachart Bank (TBank)', '1,3', '{}'),
('BAAC', N'BANK FOR AGRICULTURE AND AGRICULTURAL CO-OPERATIVES', '1,3', '{}'),
('BNP', N'BNP Paribas', '1,3', '{}'),
('BOC', N'Bank Of China', '1,3', '{}'),
('CITI', N'Citibank', '1,3', '{}'),
('DBK', N'Deutsche Bank', '1,3', '{}'),
('GHB', N'Government Housing Bank', '1,3', '{}'),
('HSBC', N'Hong Kong and Shanghai Banking Corporation', '1,3', '{}'),
('IBT', N'ISLAMIC BANK OF THAILAND', '1,3', '{}'),
('LHB', N'Land and Houses Bank', '1,3', '{}'),
('MICB', N'MEGA INTERNATIONAL COMMERCIAL BANK', '1,3', '{}'),
('SCBT', N'Standard Chartered Bank Thai', '1,3', '{}'),
('SMBC', N'Bank Sumitomo', '1,3', '{}'),
('TCRB', N'THE THAI CREDIT RETAIL BANK', '1,3', '{}'),
('TISCO', N'Tisco Bank', '1,3', '{}'),
('TTB', N'TMBThanachart Bank', '1,3', '{}')

INSERT INTO CashBankConfig 
	(
		SiteId
	    , BankId
	    , RepUpdateTime
	)
SELECT @SiteID , cbl.BankID , SYSDATETIME () FROM CashBankList cbl