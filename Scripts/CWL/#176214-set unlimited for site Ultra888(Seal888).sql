
/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator:	20220803@Robert
	Task:	#176214 - CWL - Support to set unlimited for this site Ultra888(Seal888)
	Database:	DBCUST.CustDB
	
	Revisions:
		- 20220803@Robert:	#176214 - CWL - Support to set unlimited for this site Ultra888(Seal888)
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/

DECLARE 
	@SiteId INT;
SELECT 
	  @SiteId = s.siteid
FROM Site s(NOLOCK)
WHERE s.site LIKE '%Seal888%';

UPDATE w
  SET 
	 w.MaxWinLimit = 0, 
	 w.MaxWinLimit_RM = 0
FROM WinLimit_ProductSettingDetail w WITH(ROWLOCK, UPDLOCK)
WHERE 
	 w.SiteID = @SiteId;


