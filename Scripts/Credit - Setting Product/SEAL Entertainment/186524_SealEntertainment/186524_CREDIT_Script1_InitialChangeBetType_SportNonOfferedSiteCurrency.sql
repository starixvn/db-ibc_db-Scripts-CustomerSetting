/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/04/20
	Task: Seal Entertainment - Project Team [RM:#186524]
	DB: DBCUST/CUSTDB

	Revisions:
		- Initial Script Update BetType Seal [RM:#186524]
*/

use CustDB

DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 8900
	,  @New_BetType = 8999
	,  @SportType = 156


--SELECT * 
UPDATE c SET BetType = @New_BetType
FROM SportNonOfferedSiteCurrency c WITH (ROWLOCK ,UPDLOCK)
WHERE SportType = @SportType  AND BetType = @Old_BetType