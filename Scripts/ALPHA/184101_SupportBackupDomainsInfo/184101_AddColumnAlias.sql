/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
 Created: 20230308@Helios
 Task : Add Column AliasDomain
 DB: DBCUST/CustDB  
  
     
 Revisions:     
  - 20230222@Helios: Create new table DomainList  [Redmine: #184101] 
  - 20230308@Helios: Add Column AliasDomain [Redmine: #184101] 
 Parameter's Explanation:  
*/


use CustDB

ALTER TABLE Age_DomainList  ADD Alias VARCHAR(20) NULL
GO