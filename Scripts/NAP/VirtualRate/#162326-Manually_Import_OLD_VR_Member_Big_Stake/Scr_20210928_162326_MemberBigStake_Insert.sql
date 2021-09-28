/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210928
	Task: Insert members into VRMemberBigStake [Redmine: #162326]   
	DB: DBCUST/CUSTDB 
*/
USE [CustDB]
GO

DECLARE @Inserted_Cust TABLE (CustID INT, Type TINYINT, Islog BIT DEFAULT 0)

CREATE TABLE #TblCust (CustID INT, Type TINYINT)

INSERT INTO #TblCust(CustID,Type)
SELECT c.custid, p.Type
FROM Customer c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.f_GetVRBigStakeConfig(NULL) p ON p.site = c.site
	LEFT JOIN VRMemberBigStake v WITH(NOLOCK) ON v.custid = c.custid AND v.Type = p.Type
	INNER JOIN CustVirtualSetting cvs WITH(NOLOCK)
		ON cvs.custid = ci.custid
	INNER JOIN  ProfileVirtualSetting pvs WITH(NOLOCK)
		ON  cvs.seqNo = pvs.seqNo
WHERE c.roleid = 1
	AND v.CustID IS NULL
	AND c.creatdate > = p.ReleasedDate
	AND c.creatdate <= GETDATE() - 3
	AND pvs.isActive = 1
	AND pvs.sporttype = 1 AND pvs.bettype = 1 AND pvs.islive = 1
	AND c.currency <> 20

DECLARE @custID INT, @Type TINYINT, @LogData_member VARCHAR(MAX) --log each member

--Insert members to queue
WHILE 0 = 0
BEGIN
	DELETE FROM @Inserted_Cust

	DELETE TOP(10000) t
	OUTPUT deleted.CustID,deleted.Type INTO @Inserted_Cust(CustID,Type)
	FROM #TblCust t

	IF @@ROWCOUNT = 0 
		BREAK

	INSERT INTO VRMemberBigStake(CustID,Type,Status)
	SELECT t.custid, t.Type, 0 AS Status
	FROM @Inserted_Cust t
		LEFT JOIN VRMemberBigStake v WITH(NOLOCK) ON v.custid = t.custid AND v.Type = t.Type
	WHERE v.CustID IS NULL

	--Log for each member if not White list
	BEGIN
		WHILE 1 = 1
		BEGIN
			UPDATE TOP(1) c
			SET c.islog = 1,
				@custID = c.CustID,
				@Type = c.Type
			FROM @Inserted_Cust c
			WHERE Islog = 0

			IF @@ROWCOUNT = 0 BREAK;

			SELECT @LogData_member = '<R '
								+ 'Type="'
										+ CASE	WHEN @Type = 1 THEN 'Sportsbook except Basketball and Esports' 
												ELSE space(1) 
											END+ '" '
								+ ' />'
	
			EXEC dbo.Acc_WriteLog_UserLog_RunSP_Wrapper
				@UserId				= 0,
				@custID				= @custID,
				@ActionId			= 836,
				@TrackingValue		= @LogData_member
		END
	END
END

DROP TABLE #TblCust