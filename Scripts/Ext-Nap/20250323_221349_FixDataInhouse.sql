/*<info serverAlias="DBCUST-CustDB"></info>*/
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250323@Elodie
	Task: Fix Data [Redmine:#221349]
	DB: DBCUST.CustDB
*/
USE CustDB
GO
DECLARE @CustID INT = 220860312, @RoleID TINYINT = 4, @ExistingCustid INT = 219693456, @currency INT = 16,
	@GroupName VARCHAR(MAX) = 'ACCYEN789'

INSERT INTO dbo.Acc_CustGroup (CustID, RoleID, GroupName, RepUpdateTime)
SELECT a.CustId, a.RoleID, a.GroupName, dbo.f_GetDateTime2()
FROM (SELECT @CustID CustId, @RoleID RoleID, GroupName
	FROM Acc_CustGroup WITH(NOLOCK)
	WHERE custid = @ExistingCustid
		AND GroupName IN (SELECT f.[value] AS GroupName FROM STRING_SPLIT(@GroupName, ',') AS f )
	UNION 
	SELECT @CustID, @RoleID, CASE WHEN @currency = 20 THEN 'ACCUUS2' ELSE 'ACCUSD' END) a



	