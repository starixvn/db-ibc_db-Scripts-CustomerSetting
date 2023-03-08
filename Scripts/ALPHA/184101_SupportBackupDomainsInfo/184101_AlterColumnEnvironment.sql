/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
 Created: 20230222@Helios
 Task : Add Column Environment
 DB: DBCUST/CustDB  
  
     
 Revisions:     
  - 20230308@Helios: Add Column Environment
 Parameter's Explanation:  
*/

use CustDB

ALTER TABLE Age_DomainList  ADD Environment varchar(3) NULL
GO
