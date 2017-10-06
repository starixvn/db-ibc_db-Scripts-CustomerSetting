/*
	Created: Johnson
	Date: 20171006
	Task: Enable GD for 12bet
	DB:DBCust/CustDB
*/
/*	
select custid,'--',username,* from dep_custsuper(nolock) where site='12bet'
and currency in (2, 3, 4, 6, 9, 12, 15, 61,13)

791080	--	12BETSuperUS$
791081	--	12BETSuperEURO
836203	--	12BETSuperTB
836212	--	12BETSuperGBP
836218	--	12BETSuperRM
836226	--	12BETSuperRMB
1015419	--	12BETSuperAUD
1813575	--	12BETSuperIN
6006409	--	12BETSuperINR

*/
--replace @custid with list id above
DECLARE @custid		INT = 3167631,--12BETINH
	@Disable	BIT = 0,	
	@EnableDownlines BIT = 1,
	@SystemID	TINYINT = 1,
	@UserID		INT = 15477075,--starix12
	@SubAccID	INT = 0, --Sub-AccountID
	@IP			VARCHAR(20)= '125.227.140.97',
	@Language	VARCHAR(2) = 'E',
	@ErrCode	INT = 0,
	@ErrMsg		VARCHAR(4000) = '' 
	
exec Acc_CustomerUpdDisableGoldDeluxe
	@custid		= @custid,
	@Disable	= @Disable,	
	@EnableDownlines  = @EnableDownlines,
	@SystemID	= @SystemID,
	@UserID		= @UserID,
	@SubAccID	= @SubAccID, --Sub-AccountID
	@IP			= @IP,
	@Language	= @Language,
	@ErrCode	= @ErrCode OUTPUT,
	@ErrMsg		= @ErrMsg OUTPUT
	
select 	@ErrCode,@ErrMsg