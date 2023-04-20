/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2024/04/20
	Task: Additional Setting SportNonOfferedSiteCurrency For PP - Pragmatic [RM:#181686]
	DB: DBCUST/CUSTDB

	Revisions:
		- Initial Script [RM:#181686]
*/ 


use CustDB

DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @New_BetType = 7000
	,  @SportType = 248


--SELECT * 
UPDATE c SET BetType = @New_BetType
FROM SportNonOfferedSiteCurrency c WITH (ROWLOCK ,UPDLOCK)
WHERE SportType = @SportType  AND BetType = @Old_BetType