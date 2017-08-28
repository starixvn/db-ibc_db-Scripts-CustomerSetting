/*
	Created: Elodie
	Date: 20170801
	Task: Change Lottery MinPT of Super for 'SRRMB','SKWRMB','SRARMB','SRH','SRHK','SRMA','SRHKA','SRJ','SRKH','SRHH','SRK','SRHD','SRMC','SRQ','SRHC' line
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT
CREATE TABLE #CustList (CustID INT, MaxPT TINYINT)

SELECT @Sporttype = 220

INSERT INTO #CustList (CustID, MaxPT)
select ci.CustID, cs.SuperPT
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.custid
WHERE cs.SportType = @Sporttype
	AND cs.MinPT <> cs.SuperPT
	AND username IN ('MRTB','MKWRM','SRRMB','SKWRMB','SRARMB','SRH','SRHK','SRMA','SRHKA','SRJ','SRKH','SRHH','SRK','SRHD','SRMC','SRQ','SRHC')
	AND ci.roleid = 4

INSERT INTO #CustList (CustID, MaxPT)
select ci.CustID, cs.MasterPT
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON cs.CustID = ci.custid
WHERE cs.SportType = @Sporttype
	AND cs.MinPT <> cs.MasterPT
	AND username IN ('MRTB','MKWRM','SRRMB','SKWRMB','SRARMB','SRH','SRHK','SRMA','SRHKA','SRJ','SRKH','SRHH','SRK','SRHD','SRMC','SRQ','SRHC')
	AND ci.roleid = 3

UPDATE cs
SET cs.MinPT = s.MaxPT
FROM dbo.CustPTSetting3rd_Agent cs WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #CustList s ON s.CustID = cs.CustID
WHERE cs.SportType = @Sporttype

