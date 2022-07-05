/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/

/*
	Creator:	20220616@Robert
	Task:	CWL - Enhance Currency Win Limit Setting page #168458
	Database:	DBLOG.bodb_CustomerLog
	
	Revisions:
		- 20220616@Robert:	CWL - Enhance Currency Win Limit Setting page #168458
		
	Parameter's Explaination:
		- @Example:			
		
	Developer's Notes:		
*/



DECLARE 
	@ActionName VARCHAR(200);
SELECT 
	  @ActionName = 'Add win limit control currency setting';
INSERT INTO dbo.LogAction
   (
	  ActionID, 
	  SPName, 
	  ActionNameEN, 
	  ActionNameCH, 
	  ActionNameCS, 
	  ActionNameJP, 
	  ActionNameIT, 
	  ActionNameTH, 
	  ActionNameKO, 
	  ActionNameVI, 
	  ActionNameCN, 
	  IsInternal
   )
	  SELECT 
		    31209 ActionID, 
		    'NAP_CWL_Initialize_Settings' SPName, 
		    @ActionName ActionNameEN, 
		    @ActionName ActionNameCH, 
		    @ActionName ActionNameCS, 
		    @ActionName ActionNameJP, 
		    @ActionName ActionNameIT, 
		    @ActionName ActionNameTH, 
		    @ActionName ActionNameKO, 
		    @ActionName ActionNameVI, 
		    @ActionName ActionNameCN, 
		    0 IsInternal
	  UNION ALL
	  SELECT 
		    31210 ActionID, 
		    'NAP_CWL_Update_Settings' SPName, 
		    @ActionName ActionNameEN, 
		    @ActionName ActionNameCH, 
		    @ActionName ActionNameCS, 
		    @ActionName ActionNameJP, 
		    @ActionName ActionNameIT, 
		    @ActionName ActionNameTH, 
		    @ActionName ActionNameKO, 
		    @ActionName ActionNameVI, 
		    @ActionName ActionNameCN, 
		    0 IsInternal;

