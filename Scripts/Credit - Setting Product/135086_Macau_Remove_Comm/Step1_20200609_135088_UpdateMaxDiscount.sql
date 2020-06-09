/*
	Created: Helen@20200609
	Task: Macau Games - Remove commission - https://nexdev.net/issues/135086
	DB: DBCUST/CustDB
	
	Note: Run UM (plan at 07/01/2020)
*/ 
USE CustDB
GO
UPDATE psd 
	SET MaxDiscount = 0
FROM ProductSettingDetail psd WITH (ROWLOCK)
WHERE psd.SettingType = 3
	 AND psd.sporttype = 212 
	 AND psd.bettype = 4001 
	 AND psd.ProductID = 22