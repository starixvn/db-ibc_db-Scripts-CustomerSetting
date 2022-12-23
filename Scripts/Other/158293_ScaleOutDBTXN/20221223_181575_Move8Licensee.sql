/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20221223
	Task: Update data table Site, Dep_CustSuper [RedmineID:#181575]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = 0
FROM Site s WITH (ROWLOCK)
WHERE site IN ('ZFRT152','ZFRT166SW','4300','aws03','MTechCV','Fabbet','GSCFTWCV','Betway')


UPDATE cs
SET cs.SiteDBGroupID = 0
FROM Dep_CustSuper cs WITH (ROWLOCK)
WHERE site IN ('ZFRT152','ZFRT166SW','4300','aws03','MTechCV','Fabbet','GSCFTWCV','Betway')









