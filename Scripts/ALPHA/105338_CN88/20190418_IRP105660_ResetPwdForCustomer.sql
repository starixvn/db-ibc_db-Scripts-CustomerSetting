/*
	Created: Johnson@20190418
	DB: DBCUST/CustDB
	Task: reset pwd for customer cn88
*/

UPDATE TOP (1) c
SET userpwd = '56E8A2D78170E87C928E480797CC73'
FROM customer c WITH (UPDLOCK,ROWLOCK)
WHERE c.username = 'HLTest14'


select userpwd,* from customer (NOLOCK) where username = 'HLTest14'
