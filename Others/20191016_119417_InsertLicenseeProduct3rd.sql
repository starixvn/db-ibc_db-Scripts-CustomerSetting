 /*
	Created: Winnie
	Date: 2019/10/16
	Task: Deposit - Non Peak Hours Promotion
	Redmine: https://nexdev.net/issues/119417
	DB: DBCUST/bodb_Licensee
 */
DECLARE @ProductID INT
SELECT @ProductID=ProductID FROM Product3rd WITH(NOLOCK) WHERE ProductName='NPH Promotion'

INSERT INTO [bodb_Licensee].[dbo].[LicenseeProduct3rd]
           ([LicenseeID]
           ,[ProductID]
           ,[Comm]
           ,[Winloss]
           ,[EffectiveDate])
SELECT a.LicenseeID,@ProductID,0,1,GETDATE()
FROM Licensees a WITH(NOLOCK)
WHERE NOT EXISTS(SELECT TOP 1 1 FROM [LicenseeProduct3rd] b WITH(NOLOCK) WHERE b.LicenseeID=a.LicenseeID AND b.ProductID=@ProductID)
	AND isDeposit = 1