/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: Eden@20240604
	Task: Create new FILE GROUP to store bet setting for 3rd products - Credit [Redmine: #204358]   
	DB: DBCUST-ReplCustDB
*/

--index
ALTER DATABASE ReplCustDB ADD FILEGROUP BetSetting3rd_table

ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_table_01'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_table_01.ndf'    
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]

ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_table_02'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_table_02.ndf'   
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]
 
ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_table_03'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_table_03.ndf'   
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]
 
 
--index
ALTER DATABASE ReplCustDB ADD FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_index_01'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_index_01.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_index_02'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_index_02.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE ReplCustDB    
ADD FILE (NAME = N'BetSetting3rd_index_03'
	, FILENAME = N'/mnt/DiskG/ReplCustDB/BetSetting3rd_index_03.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]

/*
USE ReplCustDB
GO
SELECT * FROM sys.filegroups where name IN ('BetSetting3rd_table','BetSetting3rd_index')
SELECT * FROM sys.database_files where name like 'BetSetting3rd_table_0%'
SELECT * FROM sys.database_files where name like 'BetSetting3rd_index_0%'

ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_table_01 ;  
GO  

ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_table_02 ;  
GO  

ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_table_03 ;  
GO  

ALTER DATABASE ReplCustDB  
REMOVE FILEGROUP BetSetting3rd_table ;  
GO 
 
ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_index_01 ;  
GO 
 
ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_index_02 ;  
GO  
     
ALTER DATABASE ReplCustDB  
REMOVE FILE BetSetting3rd_index_03 ;  
GO  

ALTER DATABASE ReplCustDB  
REMOVE FILEGROUP BetSetting3rd_index ;  
GO 
*/