/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data RefResource [223896]  
	DB: DBPRO-bodb02
*/


--*************************RefResource*************************
IF NOT EXISTS (SELECT TOP 1 1 FROM RefResource rr WHERE rr.RefId IN ('CashBankList','CashPaymentProvider','CashPaymentMethod','CashDepositAutoMode'))
BEGIN
	INSERT INTO RefResource 
	(
		RefId
	    , ResourceId
	    , Resource_en
	    , Resource_ch
	    , Resource_cs
	    , Resource_jp
	    , Resource_it
	    , Resource_th
	    , Resource_ko
	    , Resource_es
	    , Sort1
	    , Sort2
	    , Resource_el
	    , Resource_vn
	    , Resource_pl
	    , Resource_id
	    , Resource_hi
	    , Resource_mm
	    , Resource_fr
	    , Resource_ru
	    , Resource_pt
	    , Resource_de
	    , IsDeleted
	    , RepUpdateTime
	)
VALUES
        ('CashBankList',       '1',  0, N'Kasikornbank (K-Bank)',                     N'Kasikornbank (K-Bank)',                     N'Kasikornbank (K-Bank)',                     NULL, NULL, N'ธนาคารกสิกรไทย',                     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '2',  0, N'United Overseas Bank (UOB ibanking)',      N'United Overseas Bank (UOB ibanking)',      N'United Overseas Bank (UOB ibanking)',      NULL, NULL, N'ธนาคารยูโอบี',                       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '3',  0, N'TMBThanachart Bank (TMB Internet Banking)',N'TMBThanachart Bank (TMB Internet Banking)',N'TMBThanachart Bank (TMB Internet Banking)',NULL, NULL, N'ธนาคารทหารไทยธนชาต',               NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '4',  0, N'Siam Commercial Bank (SCB Easy Net)',      N'Siam Commercial Bank (SCB Easy Net)',      N'Siam Commercial Bank (SCB Easy Net)',      NULL, NULL, N'ธนาคารไทยพาณิชย์',                  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '5',  0, N'Krung Thai Bank (KTB netbank)',            N'Krung Thai Bank (KTB netbank)',            N'Krung Thai Bank (KTB netbank)',            NULL, NULL, N'ธนาคารกรุงไทย',                      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '6',  0, N'Kiatnakin Bank',                           N'Kiatnakin Bank',                           N'Kiatnakin Bank',                           NULL, NULL, N'ธนาคารเกียรตินาคินภัทร',            NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '7',  0, N'Gov. Savings Bank (GSB Internet Banking)', N'Gov. Savings Bank (GSB Internet Banking)', N'Gov. Savings Bank (GSB Internet Banking)', NULL, NULL, N'ธนาคารออมสิน',                       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '8',  0, N'CIMB Thai (CIMB Clicks)',                  N'CIMB Thai (CIMB Clicks)',                  N'CIMB Thai (CIMB Clicks)',                  NULL, NULL, N'ธนาคารซีไอเอ็มบีไทย',                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '9',  0, N'Bank of Ayudhya - Krungsri Bank',          N'Bank of Ayudhya - Krungsri Bank',          N'Bank of Ayudhya - Krungsri Bank',          NULL, NULL, N'ธนาคารกรุงศรีอยุธยา',                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '10', 0, N'Bangkok Bank (Bualuang iBanking)',         N'Bangkok Bank (Bualuang iBanking)',         N'Bangkok Bank (Bualuang iBanking)',         NULL, NULL, N'ธนาคารกรุงเทพ',                      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '11', 0, N'Thanachart Bank (TBank)',                  N'Thanachart Bank (TBank)',                  N'Thanachart Bank (TBank)',                  NULL, NULL, N'ธนาคารธนชาต',                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '12', 0, N'BANK FOR AGRICULTURE AND AGRICULTURAL COOPERATIVES', N'BANK FOR AGRICULTURE AND AGRICULTURAL COOPERATIVES', N'BANK FOR AGRICULTURE AND AGRICULTURAL COOPERATIVES', NULL, NULL, N'BANK FOR AGRICULTURE AND AGRICULTURAL CO-OPERATIVES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '13', 0, N'BNP Paribas',                              N'BNP Paribas',                              N'BNP Paribas',                              NULL, NULL, N'ธนาคารบีเอ็นพี พารีบาส์',            NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '14', 0, N'Bank Of China',                            N'Bank Of China',                            N'Bank Of China',                            NULL, NULL, N'Bank Of China',                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '15', 0, N'Citibank',                                 N'Citibank',                                 N'Citibank',                                 NULL, NULL, N'Citibank',                             NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '16', 0, N'Deutsche Bank',                            N'Deutsche Bank',                            N'Deutsche Bank',                            NULL, NULL, N'Deutsche Bank',                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '17', 0, N'Government Housing Bank',                  N'Government Housing Bank',                  N'Government Housing Bank',                  NULL, NULL, N'Government Housing Bank',              NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '18', 0, N'Hong Kong and Shanghai Banking Corporation', N'Hong Kong and Shanghai Banking Corporation', N'Hong Kong and Shanghai Banking Corporation', NULL, NULL, N'ธนาคารฮ่องกงและเซี่ยงไฮ้ จำกัด', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '19', 0, N'ISLAMIC BANK OF THAILAND',                 N'ISLAMIC BANK OF THAILAND',                 N'ISLAMIC BANK OF THAILAND',                 NULL, NULL, N'ISLAMIC BANK OF THAILAND',             NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '20', 0, N'Land and Houses Bank',                     N'Land and Houses Bank',                     N'Land and Houses Bank',                     NULL, NULL, N'Land and Houses Bank',                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '21', 0, N'MEGA INTERNATIONAL COMMERCIAL BANK',       N'MEGA INTERNATIONAL COMMERCIAL BANK',       N'MEGA INTERNATIONAL COMMERCIAL BANK',       NULL, NULL, N'ธนาคารเมกะ สากลพาณิชย์ จำกัด',      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '22', 0, N'Standard Chartered Bank Thai',             N'Standard Chartered Bank Thai',             N'Standard Chartered Bank Thai',             NULL, NULL, N'Standard Chartered Bank Thai',        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '23', 0, N'Bank Sumitomo',                            N'Bank Sumitomo',                            N'Bank Sumitomo',                            NULL, NULL, N'Bank Sumitomo',                        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '24', 0, N'THE THAI CREDIT RETAIL BANK',              N'THE THAI CREDIT RETAIL BANK',              N'THE THAI CREDIT RETAIL BANK',              NULL, NULL, N'THE THAI CREDIT RETAIL BANK',         NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '25', 0, N'Tisco Bank',                               N'Tisco Bank',                               N'Tisco Bank',                               NULL, NULL, N'ธนาคารทิสโก้ จำกัด',                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '26', 0, N'TMBThanachart Bank',                       N'TMBThanachart Bank',                       N'TMBThanachart Bank',                       NULL, NULL, N'ทีเอ็มบีธนชาต',                      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashBankList',       '27', 0, N'United Overseas Bank(Thailand)',           N'United Overseas Bank(Thailand)',           N'United Overseas Bank(Thailand)',           NULL, NULL, N'ธนาคารยูโอบี จำกัด',                 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashDepositAutoMode','APP',0, N'Bank In-App Notifications',                N'Bank In-App Notifications',                N'Bank In-App Notifications',                NULL, NULL, N'การแจ้งเตือนของแอปธนาคาร',          NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashDepositAutoMode','SMS',0, N'SMS',                                      N'SMS',                                      N'SMS',                                      NULL, NULL, N'SMS',                                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '1',  0, N'ATM',                                      N'ATM',                                      N'ATM',                                      NULL, NULL, N'ATM',                                NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '2',  0, N'Internet Banking',                         N'Internet Banking',                         N'Internet Banking',                         NULL, NULL, N'Internet Banking',                   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '3',  0, N'PromptPay',                                N'PromptPay',                                N'PromptPay',                                NULL, NULL, N'PromptPay',                           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '4',  0, N'THAI QR',                                  N'THAI QR',                                  N'THAI QR',                                  NULL, NULL, N'THAI QR',                             NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '5',  0, N'truemoney',                                N'truemoney',                                N'truemoney',                                NULL, NULL, N'truemoney',                           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentMethod',  '6',  0, N'Bank Transfer',                            N'Bank Transfer',                            N'Bank Transfer',                            NULL, NULL, N'Bank Transfer',                       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME()),
        ('CashPaymentProvider','1',  0, N'U2Pay',                                    N'U2Pay',                                    N'U2Pay',                                    NULL, NULL, N'U2Pay',                               NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0', SYSDATETIME());
END
