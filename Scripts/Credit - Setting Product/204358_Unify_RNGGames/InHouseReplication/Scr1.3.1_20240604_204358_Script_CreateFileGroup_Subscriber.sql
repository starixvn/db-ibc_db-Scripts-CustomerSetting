/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Eden@20240604
	Task: Create new FILE GROUP to store bet setting for 3rd products - Credit [Redmine: #204358]   
	DB: DBACC-bodb02,DBTP-bodb02
*/

ALTER DATABASE bodb02 ADD FILEGROUP BetSetting3rd_table

ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_table_01'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_table_01.ndf'    
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]

ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_table_02'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_table_02.ndf'   
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]
 
ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_table_03'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_table_03.ndf'   
	, SIZE = 4096MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_table]
 
 
--index
ALTER DATABASE bodb02 ADD FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_index_01'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_index_01.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_index_02'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_index_02.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]
 
ALTER DATABASE bodb02  
ADD FILE (NAME = N'BetSetting3rd_index_03'
	, FILENAME = N'/mnt/DiskG/bodb02/BetSetting3rd_index_03.ndf'   
	, SIZE = 2048MB
	, MAXSIZE = UNLIMITED, FILEGROWTH = 128MB) TO FILEGROUP [BetSetting3rd_index]


/*
USE bodb02
GO
SELECT * FROM sys.filegroups where name IN ('BetSetting3rd_table','BetSetting3rd_index')
SELECT * FROM sys.database_files where name like 'BetSetting3rd_table_0%'
SELECT * FROM sys.database_files where name like 'BetSetting3rd_index_0%'

ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_table_01 ;  
GO  

ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_table_02 ;  
GO  

ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_table_03 ;  
GO  

ALTER DATABASE bodb02
REMOVE FILEGROUP BetSetting3rd_table ;  
GO 
 
ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_index_01 ;  
GO 
 
ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_index_02 ;  
GO  
     
ALTER DATABASE bodb02
REMOVE FILE BetSetting3rd_index_03 ;  
GO  

ALTER DATABASE bodb02
REMOVE FILEGROUP BetSetting3rd_index ;  
GO 
*/