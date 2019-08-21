/*
	Created by: Eden
	Date: 20190821
	Task: Rename Primary Key name for BetRestriction Tables [Redmine:#117727]	
	DB: DBCUST/CustDB, DBACC/bodb02
*/

DECLARE @PK_BetRestriction_Currency VARCHAR(100),
		@PK_BetRestriction_Customer VARCHAR(100),
		@PK_BetRestriction_Setting	VARCHAR(100),
		@PK_BetRestriction_Site		VARCHAR(100)

SELECT  @PK_BetRestriction_Currency = CASE WHEN OBJECT_NAME(i.OBJECT_ID) =  'BetRestriction_Currency' THEN i.name  ELSE @PK_BetRestriction_Currency END,
		@PK_BetRestriction_Customer = CASE WHEN OBJECT_NAME(i.OBJECT_ID) =  'BetRestriction_Customer' THEN i.name  ELSE @PK_BetRestriction_Customer END,
		@PK_BetRestriction_Setting  = CASE WHEN OBJECT_NAME(i.OBJECT_ID) =  'BetRestriction_Setting' THEN i.name  ELSE @PK_BetRestriction_Setting END,	
		@PK_BetRestriction_Site     = CASE WHEN OBJECT_NAME(i.OBJECT_ID) =  'BetRestriction_Site' THEN i.name  ELSE @PK_BetRestriction_Site END		
FROM    sys.indexes AS i  WITH(NOLOCK)
WHERE   i.is_primary_key = 1
		AND OBJECT_NAME(i.OBJECT_ID) IN (   'BetRestriction_Currency',
											'BetRestriction_Customer',
											'BetRestriction_Setting',
											'BetRestriction_Site' )


exec sp_rename @PK_BetRestriction_Currency,'PK_BetRestriction_Currency'
exec sp_rename @PK_BetRestriction_Customer,'PK_BetRestriction_Customer'
exec sp_rename @PK_BetRestriction_Setting,'PK_BetRestriction_Setting'
exec sp_rename @PK_BetRestriction_Site,'PK_BetRestriction_Site'

