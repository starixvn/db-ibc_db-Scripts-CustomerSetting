/*
	Creator:	20191008@Robert
	Task:	Fix data of currency 0 [121652]

	Database:	DBCUST.CustDB
	
	Revisions:
		- 20191008@Robert:	Fix data of currency 0 [121652]  - [Redmine: #121652]
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE c
	  SET 
		 c.currency = 20
FROM Customer c WITH (ROWLOCK, UPDLOCK)
WHERE c.currency = 0;

UPDATE c
	  SET 
		 c.currency = 20
FROM custInfo c WITH (ROWLOCK, UPDLOCK)
WHERE c.currency = 0;