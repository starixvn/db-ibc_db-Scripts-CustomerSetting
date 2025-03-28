/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Helios
	Task: Database - Remove un-used tables of credit - Delete data reduntdant [#221908] 
	DB: DBCust/CustDB
*/

DECLARE @target     VARCHAR(20)

IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
SET @target = 'DBCUST'
ELSE
SET @target = 'REPLICATED'

PRINT 'Server Name : ' + @target

SELECT @target

EXEC dbo.[Acc_DynamicCustSetting3rd_16]  @target = @target
