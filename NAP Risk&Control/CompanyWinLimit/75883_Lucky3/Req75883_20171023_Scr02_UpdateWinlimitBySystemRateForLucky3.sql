
/*
	Created: Johnson
	Date: 2017-10-23
	Task: Apply CWL for Lucky 3
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO

UPDATE PSD
	SET MaxWinLimit = CASE WHEN psd.ExchangeID = 20 THEN MaxWinLimit_RM ELSE ROUND(MaxWinLimit_RM / e.actualrate,2) END
 FROM dbo.WinLimit_ProductSettingDetail PSD WITH(ROWLOCK, UPDLOCK)         
	INNER JOIN dbo.Exchange e WITH (NOLOCK)  ON e.ExchangeId = psd.ExchangeID
WHERE PSD.MaxWinLimit_RM IS NOT NULL AND PSD.ProductID = 26


