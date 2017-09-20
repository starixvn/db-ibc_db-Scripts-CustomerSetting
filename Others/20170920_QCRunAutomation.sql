/*
Created: 20170920@Winnie
Task: QC run automation
DB: DBCUST.CUSTDB
Revisions:

*/
USE CustDB
GO
UPDATE Customer WITH(ROWLOCK,UPDLOCK)
	SET pwdexpiry=NULL
	WHERE srecommend IN(14771858,
					15323100,
					15744710,
					17996464,
					18002026,
					18524451,
					19000014,
					19295126,
					19562449,
					19562472,
					20269385,
					20660425,
					20786437,
					21305783,
					21984259,
					23715203,
					24338704
					)
			AND roleid IN(2,3,4)