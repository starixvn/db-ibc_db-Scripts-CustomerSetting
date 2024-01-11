/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20231012
	Task: Archive table UserLog_UserControl
		https://nexdev.net/issues/192258
	DB: DBLOG-bodb_CustomerLog_Archive
*/ 
USE [bodb_CustomerLog_Archive]
GO

--RUNSP
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_20M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_20M11.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_20M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_20M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_20M12.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_20M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M01.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M02.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M03.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M04.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M05.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M06.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M07.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M08.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M09.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M10.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M11.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_21M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_21M12.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_21M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M01.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M02.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M03.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M04.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M05.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M06.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M07.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M08.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M09.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M10.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M11.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_22M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_22M12.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_22M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M01.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M02.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M03.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M04.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M05.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M06.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M07.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M08.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M09.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M10.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M11.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_23M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_23M12.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_23M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M01.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M02.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M03.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M04.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M05.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M06.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M07.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M08.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M09.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M10.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M11.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_24M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_24M12.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_24M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M01.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M02.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M03.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M04.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M05.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M06.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M07.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M08.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M09.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M10.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M11.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_25M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_25M12.ndf' , SIZE = 1025KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_25M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M01', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M01.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M01]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M02', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M02.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M02]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M03', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M03.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M03]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M04', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M04.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M04]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M05', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M05.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M05]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M06', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M06.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M06]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M07', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M07.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M07]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M08', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M08.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M08]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M09', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M09.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M09]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M10', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M10.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M10]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M11', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M11.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M11]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_26M12', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_26M12.ndf' , SIZE = 1026KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_26M12]
GO
ALTER DATABASE [bodb_CustomerLog_Archive] ADD FILE ( NAME = N'UserControl_MAX', FILENAME = N'N:\USER_DB\bodb_CustomerLog_Archive\UserControl\UserControl_MAX.ndf' , SIZE = 1024KB , FILEGROWTH = 32768KB ) TO FILEGROUP [UserControl_MAX]
GO
