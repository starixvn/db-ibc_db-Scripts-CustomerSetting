/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220112@Eden
	Task: drop create function (because of incompatible object type) [#RedmineID:#171831]
		- strSplit (DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST/DBPOL-NAP_UserControl)
		- strSplit_str (DBCUST-CustDB)
		- Lrf_f_StringSplit (DBCUST-bodb_Licensee)
	DB: DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST-NAP_UserControl
*/
USE CustDB
GO
EXEC sp_rename 'strSplit','strSplit_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit](@string [nvarchar](MAX), @splitter [char](1))
RETURNS TABLE
AS
/*
		Created: Helen
		Date: 2018-03-13
		Task: Split string
		DB: DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST-NAP_UserControl
		
		Revisions:
			- 20180808@Helen: DB05.DBPOLICY migration - Move to DBCUST [Redmine:99462]
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
	 
RETURN
	WITH TMP AS(
	 SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS id, 
		value AS val 
	 FROM string_split(@String,@splitter) 
	 )
	 SELECT id, id as [rank],val FROM tmp
GO
------------
EXEC sp_rename 'strSplit_str','strSplit_str_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit_str](@string [nvarchar](4000), @splitter [char](1))
RETURNS TABLE
AS
/*
		Created: 20220517@Eden
		Task: strSplit_str
		DB: DBCUST-CustDB
		
		Revisions:
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
RETURN
	 SELECT value AS val 
	 FROM string_split(@String,@splitter) 
GO
------------
/*
EXEC sp_rename 'strSplit_Key','strSplit_Key_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit_Key]( @string nvarchar( 4000), @splitter char( 1) )
RETURNS TABLE
AS
/*
		Created: 20220517@Eden
		Task: strSplit_Key
		DB: DBCUST-CustDB
		
		Revisions:
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
RETURN
	 SELECT DISTINCT value AS val 
	 FROM string_split(@String,@splitter) 
GO
*/
------------
USE bodb_Licensee
GO
EXEC sp_rename 'strSplit','strSplit_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit](@string [nvarchar](MAX), @splitter [char](1))
RETURNS TABLE
AS
/*
		Created: Helen
		Date: 2018-03-13
		Task: Split string
		DB: DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST-NAP_UserControl
		
		Revisions:
			- 20180808@Helen: DB05.DBPOLICY migration - Move to DBCUST [Redmine:99462]
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
	 
RETURN
	WITH TMP AS(
	 SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS id, 
		value AS val 
	 FROM string_split(@String,@splitter) 
	 )
	 SELECT id, id as [rank],val FROM tmp
GO
-----
EXEC sp_rename 'Lrf_f_StringSplit','Lrf_f_StringSplit_BU171831'
GO
CREATE FUNCTION  [dbo].[Lrf_f_StringSplit] ( @string NVARCHAR( MAX), @splitter CHAR( 1) )
RETURNS TABLE
AS
/*
	Created: 20180924@Elodie
	Task : Create String Split function that can work with string over 4000 characters
	Original: Lrf_f_StringSplit
	DB: DBCUST/bodb_Licensee

	Revisions:	
		- 20180924@Elodie: Migrate bodb_Licensee to DBCUST [Redmine:#99855]
		- 20210816@Sophia: add DBBAL [Redmine: #154300]
		- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
*/
RETURN
	WITH TMP AS(
	 SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS id, 
		value AS val 
	 FROM string_split(@String,@splitter) 
	 )
	 SELECT id, id as [rank],val FROM tmp
GO

------------
USE NAP_UserControl
GO
EXEC sp_rename 'strSplit','strSplit_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit](@string [nvarchar](MAX), @splitter [char](1))
RETURNS TABLE
AS
/*
		Created: Helen
		Date: 2018-03-13
		Task: Split string
		DB: DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST-NAP_UserControl
		
		Revisions:
			- 20180808@Helen: DB05.DBPOLICY migration - Move to DBCUST [Redmine:99462]
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
	 
RETURN
	WITH TMP AS(
	 SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS id, 
		value AS val 
	 FROM string_split(@String,@splitter) 
	 )
	 SELECT id, id as [rank],val FROM tmp
GO
------------
USE IPDB
GO
EXEC sp_rename 'strSplit','strSplit_BU171831'
GO
CREATE FUNCTION [dbo].[strSplit](@string [nvarchar](MAX), @splitter [char](1))
RETURNS TABLE
AS
/*
		Created: Helen
		Date: 2018-03-13
		Task: Split string
		DB: DBCUST-bodb_Licensee,DBCUST-IPDB,DBCUST-CustDB,DBCUST-NAP_UserControl
		
		Revisions:
			- 20180808@Helen: DB05.DBPOLICY migration - Move to DBCUST [Redmine:99462]
			- 20220517@Eden: DBCUST - modify sp syntax to adapt with the SQL Server upgrade to 2019 [Redmine: #171831]  
		Parameter's Explanation:
*/
	 
RETURN
	WITH TMP AS(
	 SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS id, 
		value AS val 
	 FROM string_split(@String,@splitter) 
	 )
	 SELECT id, id as [rank],val FROM tmp
GO