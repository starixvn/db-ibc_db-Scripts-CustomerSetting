/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Grant Per [wsv_nap] [223896]  
	DB: DBCUST-AgencyCashService
*/

-- Switch context to the target database
USE [AgencyCashService];
GO

-- Create a database user mapped to the existing SQL login (if not already created)
CREATE USER [wsv_nap] FOR LOGIN [wsv_nap];
GO

-- Grant basic connect permission to allow login to the database
GRANT CONNECT TO [wsv_nap];

-- Grant SELECT permission on all accessible objects (unless otherwise restricted by schema)
GRANT SELECT TO [wsv_nap];
GO

---- Grant basic connect permission to allow login to the database
--GRANT CONNECT TO [wsv_alp];

---- Grant SELECT permission on all accessible objects (unless otherwise restricted by schema)
--GRANT SELECT TO [wsv_alp];
--GO
