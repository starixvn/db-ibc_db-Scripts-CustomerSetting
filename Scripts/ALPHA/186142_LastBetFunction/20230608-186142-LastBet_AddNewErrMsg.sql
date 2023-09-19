/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230626@Tacy
	Task: Add new error message [#186142]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO MsgError ([MsgID], [MsgGroupID], [MsgNameEN], [MsgNameCT], [MsgNameCS], [MsgNameJP], [MsgNameTH], [MsgNameKO], [MsgNameES], [MsgNameVI], [IsActive])
VALUES 
	 (90020,10,N'Filter name already exists',N'篩選名稱已存在',N'筛选名称已存在',N'Filter name already exists',N'Filter name already exists',N'Filter name already exists',N'Filter name already exists',N'Tên bộ lọc đã tồn tại',1)
	,(90021,10,N'Please enter Member username(s)/nickname(s) or select Member(s)',N'請輸入會員賬號或選擇會員',N'请输入会员账号或选择会员',N'Please enter Member username(s)/nickname(s) or select Member(s)',N'Please enter Member username(s)/nickname(s) or select Member(s)',N'Please enter Member username(s)/nickname(s) or select Member(s)',N'Please enter Member username(s)/nickname(s) or select Member(s)',N'Vui lòng nhập tên người dùng của Member hoặc chọn Member',1)
	,(90022,10,N'Please select sport(s)',N'請選擇體育項目',N'请选择体育项目',N'Please select sport(s)',N'Please select sport(s)',N'Please select sport(s)',N'Please select sport(s)',N'Vui lòng chọn môn thể thao',1)
	,(90023,10,N'Please enter a filter name',N'請輸入篩選名稱',N'请输入筛选名称',N'Please enter a filter name',N'Please enter a filter name',N'Please enter a filter name',N'Please enter a filter name',N'Vui lòng nhập tên bộ lọc',1)
	,(90024,10,N'Please select Bet type(s)',N'請選擇投注類型',N'请选择投注类型',N'Please select Bet type(s)',N'Please select Bet type(s)',N'Please select Bet type(s)',N'Please select Bet type(s)',N'Vui lòng chọn Loại Cược',1)
	,(90025,10,N'Please enter Stake',N'請輸入本金',N'请输入本金',N'Please enter Stake',N'Please enter Stake',N'Please enter Stake',N'Please enter Stake',N'Vui lòng nhập Tiền Cược',1)
	,(90026,10,N'This filter is not available',N'This filter is not available',N'This filter is not available',N'This filter is not available',N'This filter is not available',N'This filter is not available',N'This filter is not available',N'This filter is not available',1)
GO