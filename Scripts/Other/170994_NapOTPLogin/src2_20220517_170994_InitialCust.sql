/*<info serverAlias="DBPOL-Nap_UserControl"></info>*/
/*
	Created: 20220517@Winfred
	Task : Insert exists customer  NAP OTP Login requried for VPN's users [redmine:#170994]
	DB: DBPOL/NAP_UserControl
*/

USE Nap_UserControl
GO

CREATE TABLE #CustBatch (CustId INT)
SELECT DISTINCT a.CustID, 0 AS IsFinished
INTO  #CustList
FROM CustDB.dbo.custInfo a WITH(NOLOCK)
WHERE a.roleid > 4 AND a.Enabled=1 AND a.username LIKE 'STARIX' + '%'

WHILE (1=1)
BEGIN
	UPDATE TOP (4000) t
	SET IsFinished = 1
	OUTPUT deleted.custid  INTO #CustBatch(CustId)
	FROM #CustList t
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK
	
	INSERT INTO AdminOTP(CustID,System,Modifier, ModifiedDate, Creator,CreatedDate)
	SELECT CustID, 'NAP' AS System, NULL AS Modifier, NULL AS ModifiedDate, 10278938 AS Creator, GETDATE() AS CreatedDate  --starixIT
	FROM #CustBatch c WITH(NOLOCK)

	DELETE FROM #CustBatch

	WAITFOR DELAY '00:00:02'
END

DROP TABLE #CustList
DROP TABLE #CustBatch

