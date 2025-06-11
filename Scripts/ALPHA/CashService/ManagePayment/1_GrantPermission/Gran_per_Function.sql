/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]   
	DB: DBCUST-CustDB
*/

-- Grant Permission Function
GRANT VIEW DEFINITION ON OBJECT::dbo.f_GetSubUsername TO wsv_CashService;
GRANT EXECUTE  ON OBJECT::dbo.f_GetSubUsername TO wsv_CashService;
GRANT SELECT ON dbo.custSub TO wsv_CashService;