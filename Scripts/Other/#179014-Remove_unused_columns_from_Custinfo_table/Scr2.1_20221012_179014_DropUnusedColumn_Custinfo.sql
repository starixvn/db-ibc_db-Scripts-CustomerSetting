/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20221012@Eden
	Task: DROP unsused columns on Custinfo tables [#179014]
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
--Drop Constraint of unused Columns
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_DisableCasino --DisableCasino
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_SyncCasino --SyncCasino
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_DisableGoldDeluxe --DisableGoldDeluxe
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_HideGoldDeluxe --HideGoldDeluxe
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_MaxPerBall161 --MaxPerBall161
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_maxpermatch161 --maxpermatch161
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_CustInfo_maxpermatch164 --maxpermatch164
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_MaxPerMatch99MP --MaxPerMatch99MP
GO
--Drop unused Columns
ALTER TABLE dbo.custinfo DROP COLUMN maxpermatch          
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


