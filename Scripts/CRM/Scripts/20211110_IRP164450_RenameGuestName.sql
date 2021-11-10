/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20211110@Johnson
	Task: rename guest customers in crm
	DB: DBCRM/bodb_CRM
*/

;WITH T as (
	SELECT 'Undefined-Member' as UserName, 'unidentified-Member' NewName
	UNION SELECT 'Undefined-SMA', 'unidentified-SMA'
)
UPDATE c
SET c.username = t.NewName
FROM crmCustomer c WITH(ROWLOCK)
	INNER JOIN T ON c.username = t.username
GO

;WITH T as (
	SELECT 'Undefined-Member' as UserName, 'unidentified-Member' NewName
	UNION SELECT 'Undefined-SMA', 'unidentified-SMA'
)
UPDATE c
SET c.username = t.NewName
FROM crmCustomerSearch c WITH(ROWLOCK)
	INNER JOIN T ON c.username = t.username