/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-10-25
	Task: Drop tables: CustInfoMini | CustSubMini & CustSubMini_Del_Inhouse | CustInfoMini_Del_Inhouse tables [Redmine: #206823] 
	DB: DBCUST-CustDB
*/

USE CustDB

GO

IF OBJECT_ID ('CustInfoMini_DEL', 'U') IS NOT NULL  
   DROP TABLE CustInfoMini_DEL;  

IF OBJECT_ID ('CustSubMini_DEL', 'U') IS NOT NULL  
   DROP TABLE CustSubMini_DEL;  

IF OBJECT_ID ('CustSubMini_Del_Inhouse_DEL', 'U') IS NOT NULL  
   DROP TABLE CustSubMini_Del_Inhouse_DEL;  

IF OBJECT_ID ('CustInfoMini_Del_Inhouse_DEL', 'U') IS NOT NULL   
   DROP TABLE CustInfoMini_Del_Inhouse_DEL;  