/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]  
	DB: DBCUST/AgencyCashService
*/

--*************************BankList*************************
IF EXISTS (SELECT TOP 1 1 FROM CashBankList cbl WITH (NOLOCK))
BEGIN
	DELETE FROM CashBankList
END


INSERT INTO CashBankList (BankCode, BankName, TransTypeList, DepositMode, RepUpdateTime) VALUES
    ('KKR',  N'Kasikornbank (K-Bank)',                  '1,2,3',      '{"sourceType": "SMS", "mappingType": [1, 2]}',      SYSDATETIME()),
    ('UOB',  N'United Overseas Bank (UOB ibanking)',    '1,3',        '{}',                                                SYSDATETIME()),
    ('TMB',  N'TMBThanachart Bank (TMB Internet Banking)', '1,3',    '{}',                                                 SYSDATETIME()),
    ('SCB',  N'Siam Commercial Bank (SCB Easy Net)',    '1,2,3',      '{"sourceType": "SMS", "mappingType": [1, 2]}',      SYSDATETIME()),
    ('KTB',  N'Krung Thai Bank (KTB netbank)',          '1,2,3',      '{"sourceType": "APP", "mappingType": [1, 2]}',      SYSDATETIME()),
    ('KNK',  N'Kiatnakin Bank',                         '1,2,3',      '{"sourceType":"SMS", "mappingType": [1]}',          SYSDATETIME()),
    ('GSB',  N'Gov. Savings Bank (GSB Internet Banking)', '1,2,3',    '{"sourceType": "APP", "mappingType": [1]}',         SYSDATETIME()),
    ('CIMBT', N'CIMB Thai (CIMB Clicks)',               '1,3',        '{}',                                                SYSDATETIME()),
    ('BOA',  N'Bank of Ayudhya - Krungsri Bank',        '1,2,3',      '{"sourceType": "SMS", "mappingType": [1]}',         SYSDATETIME()),
    ('BBL',  N'Bangkok Bank (Bualuang iBanking)',       '1,2,3',      '{"sourceType": "APP", "mappingType": [1]}',         SYSDATETIME()),
    ('TBank', N'Thanachart Bank (TBank)',               '1,3',        '{}',                                                SYSDATETIME()),
    ('BAAC', N'BANK FOR AGRICULTURE AND AGRICULTURAL CO-OPERATIVES', '1,3', '{}',                                          SYSDATETIME()),
    ('BNP',  N'BNP Paribas',                            '1,3',        '{}',                                                SYSDATETIME()),
    ('BOC',  N'Bank Of China',                          '1,3',        '{}',                                                SYSDATETIME()),
    ('CITI', N'Citibank',                               '1,3',        '{}',                                                SYSDATETIME()),
    ('DBK',  N'Deutsche Bank',                          '1,3',        '{}',                                                SYSDATETIME()),
    ('GHB',  N'Government Housing Bank',                '1,3',        '{}',                                                SYSDATETIME()),
    ('HSBC', N'Hong Kong and Shanghai Banking Corporation', '1,3',    '{}',                                                SYSDATETIME()),
    ('IBT',  N'ISLAMIC BANK OF THAILAND',               '1,3',        '{}',                                                SYSDATETIME()),
    ('LHB',  N'Land and Houses Bank',                   '1,3',        '{}',                                                SYSDATETIME()),
    ('MICB', N'MEGA INTERNATIONAL COMMERCIAL BANK',     '1,3',        '{}',                                                SYSDATETIME()),
    ('SCBT', N'Standard Chartered Bank Thai',           '1,3',        '{}',                                                SYSDATETIME()),
    ('SMBC', N'Bank Sumitomo',                          '1,3',        '{}',                                                SYSDATETIME()),
    ('TCRB', N'THE THAI CREDIT RETAIL BANK',            '1,3',        '{}',                                                SYSDATETIME()),
    ('TISCO', N'Tisco Bank',                            '1,3',        '{}',                                                SYSDATETIME()),
    ('TTB',  N'TMBThanachart Bank',                     '1,2,3',      '{"sourceType": "APP", "mappingType": [1, 2]}',      SYSDATETIME()),
    ('UOBT', N'United Overseas Bank(Thailand)',         '1,3',        '{}',                                                SYSDATETIME());
GO


