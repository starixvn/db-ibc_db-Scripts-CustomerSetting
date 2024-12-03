/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240627@Johnson
	Task: Scale out dbcust for deposit settings [redmine: #207025]
	DB: DBCustRepl-ReplCustDB
*/ 
-----------------------------------------------
--[DATA]
ALTER DATABASE ReplCustDB ADD FILEGROUP [DATA] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Data01', FILENAME = N'/mnt/DiskG/ReplCustDB/DATA_01.NDF' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'Data02', FILENAME = N'/mnt/DiskG/ReplCustDB/DATA_02.NDF' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'Data03', FILENAME = N'/mnt/DiskG/ReplCustDB/DATA_03.NDF' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [DATA]
GO

-----------------------------------------------
--[Dep_CustBetSetting_Agent_table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustBetSetting_Agent_table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustBetSetting_Agent_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustBetSetting_Agent_table_01.NDF' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustBetSetting_Agent_table]
GO

-----------------------------------------------
--[Dep_CustBetSetting_Member_table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustBetSetting_Member_table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustBetSetting_Member_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustBetSetting_Member_table_01.NDF' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustBetSetting_Member_table]
GO

-----------------------------------------------
--[table_customer]
ALTER DATABASE ReplCustDB ADD FILEGROUP [table_customer] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'table_customer_01', FILENAME = N'/mnt/DiskG/ReplCustDB/table_customer_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'table_customer_02', FILENAME = N'/mnt/DiskG/ReplCustDB/table_customer_02.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'table_customer_03', FILENAME = N'/mnt/DiskG/ReplCustDB/table_customer_03.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'table_customer_04', FILENAME = N'/mnt/DiskG/ReplCustDB/table_customer_04.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [table_customer]
GO

-----------------------------------------------
--[Dep_CustDiscount_Member_Table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustDiscount_Member_Table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustDiscount_Member_Table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustDiscount_Member_Table_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustDiscount_Member_Table]
GO

-----------------------------------------------
--[Dep_CustDiscountSetting_Agent_table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustDiscountSetting_Agent_table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustDiscountSetting_Agent_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustDiscountSetting_Agent_table_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustDiscountSetting_Agent_table]
GO

-----------------------------------------------
--[Dep_CustPTSetting_table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustPTSetting_table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustPTSetting_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustPTSetting_table_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustPTSetting_table]
GO

-----------------------------------------------
--[Dep_CustSettingGame_Table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustSettingGame_Table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustSettingGame_Table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustSettingGame_Table_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustSettingGame_Table]
GO

-----------------------------------------------
--[Dep_CustSettingGame_Table]
ALTER DATABASE ReplCustDB ADD FILEGROUP [Dep_CustStakeLevel_table] 
GO
ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'Dep_CustStakeLevel_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/Dep_CustStakeLevel_table_01.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [Dep_CustStakeLevel_table]
GO