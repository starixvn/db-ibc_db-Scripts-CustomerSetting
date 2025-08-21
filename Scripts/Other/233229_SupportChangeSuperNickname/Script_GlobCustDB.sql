/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250716@Helios
	Task: Support Change Super Nickname
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250716@Helios: Support Change Super Nickname [RedmineID: #233229]
*/
-- 1. Create temp table to store Username and CustID
IF OBJECT_ID('tempdb..#tmpUser') IS NOT NULL 
    DROP TABLE #tmpUser;

CREATE TABLE #tmpUser (
    Username NVARCHAR(50) PRIMARY KEY,
    CustID INT
);

-- 2. Insert Username data into temp table, get CustID from main table
INSERT INTO #tmpUser (Username, CustID)
SELECT Username, CustID
FROM dbo.CustInfoMini WITH (NOLOCK)
WHERE Username IN (
    'DZA6','DZAA','DZAT','DZBQ','DZBY','DZDH','DZDQ','DZDR','DZDS','DZE8','DZE9','DZEA','DZF6','DZFB','DZFD','DZFi','DZFL','DZFM','DZFR','DZGC','DZGD','DZGE','DZGF','DZGG','DZGH','DZGY','DZHF','DZHG','DZH6','DZH7','DZH8','DZH9','DZHA','DZHD','DZHE',
    'FP72','FP77','FPA8','FPAS','FPAT','FPBQ','FPBR','FPEZ','FPC9','FPCJ','FPCM','FPCP','FPCT',
    'FPDY','FPDZ','FPE4','FPE6','FPED','FPEH','FPET','FPEU','FPEV','FPEW','FPF5','FPF1','FPF7','FPF8',
    'FD85','FP09','FP3M','FP50','FP52',
    'J09','J10F','J10Z','J1Z','J3L','J4B','J5W','J5Y','J62','J79','J80','J8F','J11L','J11M','J11Q','J11S','J11T','J15F','J15P','J15R','J15S','J15T','J11U',
    'J13J','J13K','J13V','J14A','J14B','J14C','J14L','J14P','J14Q','J14W','J14Y','J14Z','J16C','J16F',
    'J16S','J16V','J17D','J17W','J18D','J18E','J18F','J18G','J18R','J18T','J18V','J19A','J19B','J19C','J19D','J19J','J19L','J19Y','J19Z','J20A','J20B','J20C','J20D','J20E','J20F','J20G','J20H','J20i','J20J','J20K','J20L','J20M','J20N','J20P','J20Q','J21H','J21i','J21L','J21Q','J21Z','J22C','J22D','J22N','J22U','J23K','J23L','J23M',
    'J23X','J23Y','J24B','J24C','J24D','J24E','J24F','J24G','J24K','J24L','J24M','J24N','J24P','J24U','J24V','J24W','J24Z','J25A','J25B','J25C','J25D','J25E',
    'J25H','J25i','J25J','J25K','J25L','J25M','J25Q','J25R','J25V','J25W',
    'J25Z','J26A','J26B','J26C','J26E','J26F','J26H','J26J','J26L','J26M','J26N','J26Q','J26R','J26S','J26T','J26U','J26Y','J26Z','J27A','J27B','J27C','J27D',
    'J27E','J27F','J27G','J27H','J27i','J27J','J27K','J27L','J27M','J27N','J27P','J27Q','J27R','J27S','J26W','J26X','J24S','J24T','J22G','J20S','J20T','J20U','J18N',
    'N04','N18','N20','N22','N26','N29','N30','N31','N42','N43','N44','N50','N56','N57','N60','N61','N64','N68','N69','N71','N72','N73','N74','N75','N80','N81','N82','N84','N85','N86','N87','N88','N89'
);

-- 3. Check how many rows will be updated : expected 200 customers affected
-- SELECT COUNT(1) AS RowWillBeUpdated FROM #tmpUser

-- 4. Proceed to update using INNER JOIN on CustID (optimal for clustered index)
IF NOT EXISTS (SELECT 1 FROM #tmpUser)
BEGIN
    PRINT 'No rows to update.';
    RETURN;
END
ELSE
BEGIN
    UPDATE t
    SET t.Username2 = NULL,
        t.RepUpdateTime = [dbo].[f_GetDateTime2]()
    FROM dbo.CustInfoMini t WITH (UPDLOCK, ROWLOCK)
    INNER JOIN #tmpUser u ON t.CustID = u.CustID;
END
