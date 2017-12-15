/*
	Created: Elodie
	Date: 20171201
	Task: Change BullFighting MinPT of Super for 'DADR' line
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
CREATE TABLE #CustList (CustID INT, MaxPT TINYINT)

SELECT @Sporttype = 207

INSERT INTO #CustList (CustID, MaxPT)
select ci.CustID, cs.SuperPT
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.custid
WHERE cs.SportType = @Sporttype
	AND cs.MinPT <> cs.SuperPT
	AND username IN ('DADR')
	AND ci.roleid = 4

UPDATE cs
SET cs.MinPT = s.MaxPT
FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #CustList s ON s.CustID = cs.CustID
WHERE cs.SportType = @Sporttype

