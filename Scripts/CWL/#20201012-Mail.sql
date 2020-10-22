
/*<info serverAlias="DBMMS-bodb_MMS"></info>*/
/*
	Creator:	20201012@Robert
	Task:	update email domain name from @starixsoft.com to @starixvn.com
	Database:	DBMMS.bodb_MMS
	
	Revisions:
		- 20201012@Robert:	update email domain name from @starixsoft.com to @starixvn.com
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

UPDATE e
  SET 
      e.EmailAddress = REPLACE(e.EmailAddress, '@starixsoft.com', '@starixvn.com')
FROM [dbo].[Email] e
WHERE EmailAddress LIKE '%@starixsoft.com';