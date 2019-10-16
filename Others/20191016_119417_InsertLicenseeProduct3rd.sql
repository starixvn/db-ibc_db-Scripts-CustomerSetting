 /*
	Created: Winnie
	Date: 2019/10/16
	Task: Deposit - Non Peak Hours Promotion
	Redmine: https://nexdev.net/issues/119417
	DB: DBLIC/bodb_Licensee
 */


INSERT INTO [bodb_Licensee].[dbo].[LicenseeProduct3rd]
           ([LicenseeID]
           ,[ProductID]
           ,[Comm]
           ,[Winloss]
           ,[EffectiveDate])
SELECT LicenseeID,37,0,1,GETDATE()
FROM Licensees WITH(NOLOCK)