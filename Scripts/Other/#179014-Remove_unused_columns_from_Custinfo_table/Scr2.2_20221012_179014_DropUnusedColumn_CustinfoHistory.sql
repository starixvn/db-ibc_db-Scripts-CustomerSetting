/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*	
	Created: 20221012@Eden
	Task: Drop unsused Columns of custinfo_history table [#179014]
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO

ALTER TABLE dbo.custinfo_history DROP COLUMN maxpermatch          
											,MaxPerMatch1MP       
											,maxpermatch2         
											,maxpermatch3         
											,maxpermatch5         
											,maxpermatch8         
											,maxpermatch10        
											,maxpermatch11        
											,maxpermatch12        
											,maxpermatch99        
											,MaxPerMatch99MP      
											,maxpermatch161       
											,MaxPerBall161        
											,maxpermatch164       
											,HideGoldDeluxe       
											,DisableGoldDeluxe    
											,DisableCasino        
											,SyncCasino 
GO