/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha -Support QC Init for test - [223896]   
	DB: DBCUST/AgencyCashService
*/

INSERT INTO CashMemberBankAccount 
	(
		CustId
	    , BankId
	    , AccountNumber
	    , BankAccountAgentID
	    , RepUpdateTime
	    , IsActive
	)
SELECT  25016856 , 2 , 1728463937 , 28 , SYSDATETIME () , 1
UNION ALL
SELECT  25016858 , 2 , 1728435363 , 28 , SYSDATETIME () , 1
UNION ALL
SELECT  25016864 , 2 , 1728423454 , 28 , SYSDATETIME () , 1
