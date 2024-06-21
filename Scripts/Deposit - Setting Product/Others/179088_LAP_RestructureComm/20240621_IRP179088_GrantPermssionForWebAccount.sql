/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20240201@Johnson
	Task: grant permission for web account [redmine:#179088]
	DB: DBCUST/CUSTDB
*/

grant select on Dep_CustSettingMode to wsv_lap,svc_tig,wsv_nap
GO
grant select on Dep_CustDiscountSetting_Member to wsv_lap,svc_tig,wsv_nap
go
grant select on Dep_CustDiscountGroupSetting_Member to wsv_lap,svc_tig,wsv_nap
go
grant select on Dep_ProductSettingDetail to wsv_lap,svc_tig,wsv_nap
go
grant select on Dep_ProductSetting to wsv_lap,svc_tig,wsv_nap
go
/*
-------------------------------------------------------
--grant on DBLOG.bodb_Licensee
USE bodb_Licensee
GO
GRANT SELECT ON LicenseeGroupDiscount TO wsv_lap

-------------------------------------------------------
--grant on DBEXT.bodb_Licensee
USE bodb_Licensee
GO
GRANT SELECT ON LicenseeGroupDiscount TO wsv_lap
GO
GRANT SELECT ON LicenseeCustDiscount TO wsv_lap
GO
*/