/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Add Collumn [223896]   
	DB: DBCUST/AgencyCashService
*/

ALTER TABLE CashMemberBankAccount
ADD IsActive BIT NOT NULL 
    CONSTRAINT DF_CashMemberBankAccount_IsActive DEFAULT (1); 


