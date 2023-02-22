/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
 Created: 20230222@Helios
 Task : Create new table DomainList
 DB: DBCUST/CustDB  
  
     
 Revisions:     
  - 20230222@Helios: Create new table DomainList  
 Parameter's Explanation:  
*/


USE CustDB
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Age_DomainList]') AND type in (N'U'))
DROP TABLE [dbo].[Age_DomainList]
GO
CREATE TABLE [dbo].[Age_DomainList](
	SiteLabel varchar(50) NOT NULL ,
	Domain varchar(100) NOT NULL
) 
GO

CREATE CLUSTERED INDEX [IX_AGE_DomainList_SiteLabel] ON [dbo].[Age_DomainList]
(
	SiteLabel ASC 
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
