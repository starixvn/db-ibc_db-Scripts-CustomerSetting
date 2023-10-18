
/*<info serverAlias="DBMMS-bodb_MMS"></info>*/

/*
	Creator:	20231018@Robert
	Task:	update email domain name from @starixvn.com to @starixsoft.com
	Database:	DBMMS.bodb_MMS
	
	Revisions:
		- 20231018@Robert:	update email domain name from @starixvn.com to @starixsoft.com
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE e
  SET 
	 e.EmailAddress = REPLACE(e.EmailAddress, '@starixvn.com', '@starixsoft.com')
FROM [dbo].[Email] e
WHERE 
	 EmailAddress LIKE '%@starixvn.com';

