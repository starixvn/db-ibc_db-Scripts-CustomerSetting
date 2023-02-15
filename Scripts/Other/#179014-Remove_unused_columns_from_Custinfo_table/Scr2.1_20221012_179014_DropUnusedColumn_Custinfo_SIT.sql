/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20221012@Eden
	Task: DROP unsused columns on Custinfo tables - SIT ( rename first) [#179014]
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
ALTER TABLE dbo.custinfo DROP COLUMN DEL_maxpermatch          
									,DEL_MaxPerMatch1MP       
									,DEL_maxpermatch2         
									,DEL_maxpermatch3         
									,DEL_maxpermatch5         
									,DEL_maxpermatch8         
									,DEL_maxpermatch10        
									,DEL_maxpermatch11        
									,DEL_maxpermatch12        
									,DEL_maxpermatch99        
									,DEL_MaxPerMatch99MP      
									,DEL_maxpermatch161       
									,DEL_MaxPerBall161        
									,DEL_maxpermatch164       
									,DEL_HideGoldDeluxe       
									,DEL_DisableGoldDeluxe    
									,DEL_DisableCasino        
									,DEL_SyncCasino 
GO


