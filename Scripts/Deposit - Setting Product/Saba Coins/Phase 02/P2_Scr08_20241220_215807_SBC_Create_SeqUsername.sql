/*<info serverAlias="DBGlob-GlobCustDB"></info>*/

/*
	Created: 20241219@Tacy  
	Task : Gen Username for SBC site [Redmine: #215807]
	DB:  DBGlob-GlobCustDB
*/
USE GlobCustDB
GO

SELECT Max_CustID=MAX(CustID)
FROM CustInfoMini WITH (NOLOCK)
GO

CREATE SEQUENCE dbo.SeqUsername
AS int
START WITH 1 --REPLACE Max_CustID
INCREMENT BY 1 ;

--Grant permission to execute NEXT VALUE FOR
GRANT UPDATE ON OBJECT::dbo.SeqUsername TO [asv_cust];