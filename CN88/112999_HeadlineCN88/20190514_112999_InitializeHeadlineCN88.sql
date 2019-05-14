/*
	Created: 20190514@Elodie
	DB: DBCUST/CustDB
	Task: Add data for GroupHeadline CN88
*/
USE CustDB
GO
DECLARE @GroupHeadlineId INT, @CustId INT, @i INT = 1, @Max INT
CREATE TABLE #HeadlineList (ID INT IDENTITY(1,1), CustId INT)
SELECT @GroupHeadlineId = MAX(groupid) + 1 FROM custaccount WITH(NOLOCK)

INSERT INTO #HeadlineList (CustId)
SELECT custid
FROM dbo.customer WITH (NOLOCK)
WHERE roleid = 0 AND site = 'CN88'

--Delete data
DELETE gh 
FROM CustGroupHeadline gh WITH (ROWLOCK)
	INNER JOIN #HeadlineList h ON h.CustId = gh.CustID

DELETE ca 
FROM custAccount ca WITH (ROWLOCK)
	INNER JOIN #HeadlineList h ON h.CustId = ca.CustID

DELETE ca 
FROM custAccount ca WITH (ROWLOCK)
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = ca.custid
	INNER JOIN #HeadlineList h ON h.CustId = s.UplineId

SELECT @Max = MAX(ID) FROM #HeadlineList

WHILE (@i<=@Max)
BEGIN
	SELECT @CustId = custid FROM #HeadlineList WHERE ID = @i

	INSERT INTO dbo.CustGroupHeadline (CustID, GroupID, HeadlineType, OwnerName, OwnerID)
	SELECT @custid, @GroupHeadlineId, 0, NULL, NULL	 

	INSERT INTO dbo.custAccount (custid, creditgrade, installmentdate, installmentamount, preagreeamount, accountremark, accountremarkdate,groupid,isgroupheadline,checker)
	VALUES (@custid, N'A', N'1', 0, 0, '', CURRENT_TIMESTAMP, @GroupHeadlineId,1,0)

	INSERT INTO dbo.custAccount (custid, creditgrade, installmentdate, installmentamount, preagreeamount, accountremark, accountremarkdate,groupid,isgroupheadline,checker)
	SELECT s.custid, ca.creditgrade, ca.installmentdate, ca.installmentamount, ca.preagreeamount, ca.accountremark, ca.accountremarkdate, @GroupHeadlineId,0,0
	FROM dbo.CustSuper s WITH (NOLOCK)
		CROSS JOIN dbo.custAccount ca WITH (NOLOCK)
	WHERE s.UplineId = @CustId
		AND ca.custid = @CustId AND ca.IsGroupHeadLine = 1

	SELECT @i = @i + 1
	SELECT @GroupHeadlineId = @GroupHeadlineId + 1
END

SELECT gh.* 
FROM CustGroupHeadline gh WITH (ROWLOCK)
	INNER JOIN #HeadlineList h ON h.CustId = gh.CustID

SELECT ca.*
FROM custAccount ca WITH (ROWLOCK)
	INNER JOIN #HeadlineList h ON h.CustId = ca.CustID

SELECT ca.*
FROM custAccount ca WITH (ROWLOCK)
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = ca.custid
	INNER JOIN #HeadlineList h ON h.CustId = s.UplineId

DROP TABLE #HeadlineList