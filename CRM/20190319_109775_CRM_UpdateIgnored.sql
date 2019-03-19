/*	Created: Winnie
	Date: 20190319
	Task: Get Inform Headline
	DB: DBCRM/bodb_CRM
	Revisions:	
		-20190319@Winnie: CRM - Enhance Inform Headline RedmineID:#109775	
*/

UPDATE crmCustomer WITH(ROWLOCK,UPDLOCK) SET Ignored=0 WHERE UserName IN('et668','et789')