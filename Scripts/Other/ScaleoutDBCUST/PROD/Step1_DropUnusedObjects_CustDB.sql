/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-09-26
	Task: Drop unused objects [Redmine: #206823]  
		Drop trigger of custome: Customer_delete | Customer_insert | Customer_update
		Drop trigger of custSub: CustSub_delete | CustSub_insert | CustSub_update
		Drop temp table: CustInfoMini_tmp / CustSubMini_tmp
	DB: DBCUST-CustDB
*/

/****** Object: Affected Table Customer Drop trigger, Script Date: 9/26/2024 9:34:35 AM ******/

IF OBJECT_ID ('Customer_delete', 'TR') IS NOT NULL  
   DROP TRIGGER Customer_delete;  

IF OBJECT_ID ('Customer_insert', 'TR') IS NOT NULL  
   DROP TRIGGER Customer_insert;  

IF OBJECT_ID ('Customer_update', 'TR') IS NOT NULL  
   DROP TRIGGER Customer_update;  




/****** Object: Affected Table CustSub Drop trigger, Script Date: 9/26/2024 9:34:35 AM ******/

IF OBJECT_ID ('CustSub_delete', 'TR') IS NOT NULL  
   DROP TRIGGER CustSub_delete;  

IF OBJECT_ID ('CustSub_insert', 'TR') IS NOT NULL  
   DROP TRIGGER CustSub_insert;  

IF OBJECT_ID ('CustSub_update', 'TR') IS NOT NULL  
   DROP TRIGGER CustSub_update;  



/****** Object: Affected temp table CustInfoMini_tmp , CustSubMini_tmp, Script Date: 9/26/2024 9:34:35 AM ******/

IF OBJECT_ID ('CustInfoMini_tmp', 'U') IS NOT NULL  
   DROP TABLE CustInfoMini_tmp;  

IF OBJECT_ID ('CustSubMini_tmp', 'U') IS NOT NULL  
   DROP TABLE CustSubMini_tmp;  