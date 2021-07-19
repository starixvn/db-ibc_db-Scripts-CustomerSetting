/*
	Created: 20190826@Elodie	
	Task: Initial data test for problem account 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @CustId INT, @SetBit1 INT, @Pos TINYINT, @RoleId TINYINT, @ReasonId TINYINT
CREATE TABLE #CustList (CustId INT, roleId TINYINT, IsFinished BIT DEFAULT(0))
CREATE TABLE #DownlineCust (CustID INT PRIMARY KEY, RoleID TINYINT)

SELECT @ReasonId = 1

INSERT INTO #CustList (CustId, roleId)
SELECT CustId, roleId
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.roleid = 4 AND ci.username IN ('supertestshcn8801', 'superbobcn88')

INSERT INTO #CustList (CustId, roleId)
SELECT CustId, roleId
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.roleid = 3 AND ci.username IN ('SupertestCN88KL0102', 'SuperRita0101', 'supertestshcn880100', 'supertestCN88Felix01')

INSERT INTO #CustList (CustId, roleId)
SELECT CustId, roleId
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.roleid = 2 AND ci.username IN ('SuperTestCNL0102', 'bobsuper0101', 'Supertestte330000','SuperTestCNL8802')

INSERT INTO #CustList (CustId, roleId)
SELECT CustId, roleId
FROM dbo.Customer ci WITH (NOLOCK)
WHERE ci.roleid = 1 AND custid IN (24971823)

WHILE (1=1)
BEGIN
	UPDATE TOP (1) #CustList
	SET isfinished = 1,
		@CustId = custid,
		@RoleId = roleId
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	IF @RoleID = 4 --Super			
	BEGIN
		INSERT INTO #DownlineCust (CustID, RoleID)
		SELECT custid, roleid
		FROM custInfo c WITH(NOLOCK)
		WHERE srecommend = @CustID AND c.custid <> @CustId
	END
	ELSE IF @RoleID = 3 --Master
	BEGIN
		INSERT INTO #DownlineCust (CustID, RoleID)
		SELECT custid, roleid
		FROM custInfo c WITH(NOLOCK)
		WHERE mrecommend = @CustID AND c.custid <> @CustId
	END
	ELSE IF @RoleID = 2 --Agent
	BEGIN
		INSERT INTO #DownlineCust (CustID, RoleID)
		SELECT custid, roleid
		FROM custInfo c WITH(NOLOCK)
		WHERE recommend = @CustID AND c.custid <> @CustId
	END	

	SELECT	@Pos = CASE @RoleId WHEN 4 THEN 3
									WHEN 3 THEN 2
									WHEN 2 THEN 1
									WHEN 1 THEN 0 END					
			
	SELECT @SetBit1 = POWER(2, @Pos)								

	IF @RoleId <> 1
	BEGIN
		INSERT INTO dbo.CS_ProblemAccount (CustId, ProblemStatus, ReasonId, Comment, MaxBet, MaxPerEvent, CreatedDate, IsReviewed, IsAbnormalMember)
		SELECT @CustId, @SetBit1, @ReasonId, '', 1000, 5000, GETDATE(), 0, 0
		WHERE NOT EXISTS (SELECT 1 FROM CS_ProblemAccount WHERE CustId = @CustId)

		UPDATE pa 
		SET pa.ProblemStatus = ProblemStatus | @SetBit1,
			pa.ReasonId = @ReasonId,
			pa.Comment = ''
		FROM dbo.CS_ProblemAccount pa WITH (ROWLOCK)
		WHERE CustId = @CustId	

		INSERT INTO dbo.CS_ProblemAccount (CustId, ProblemStatus, ReasonId, Comment, MaxBet, MaxPerEvent, CreatedDate, IsReviewed, IsAbnormalMember)
		SELECT CustId, @SetBit1, NULL, NULL, NULL, NULL, GETDATE(), 0, 0
		FROM #DownlineCust t
		WHERE NOT EXISTS (SELECT 1 FROM CS_ProblemAccount WHERE CustId = t.CustId)

		UPDATE pa 		
		SET pa.ProblemStatus = ProblemStatus | @SetBit1
		FROM dbo.CS_ProblemAccount pa WITH (ROWLOCK)
			INNER JOIN #DownlineCust t ON t.CustID = pa.CustId

		DELETE #DownlineCust
	END
	ELSE
	BEGIN
		INSERT INTO dbo.CS_ProblemAccount (CustId, ProblemStatus, ReasonId, Comment, MaxBet, MaxPerEvent, CreatedDate, IsReviewed, IsAbnormalMember)
		SELECT @CustId, @SetBit1, NULL, '', 1000, 5000, GETDATE(), 0, 1
		WHERE NOT EXISTS (SELECT 1 FROM CS_ProblemAccount WHERE CustId = @CustId)

		UPDATE pa 
		SET pa.ProblemStatus = ProblemStatus | @SetBit1
		FROM dbo.CS_ProblemAccount pa WITH (ROWLOCK)
		WHERE CustId = @CustId	
	END
END

DROP TABLE #CustList
DROP TABLE #DownlineCust