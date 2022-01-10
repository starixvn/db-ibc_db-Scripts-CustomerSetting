/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220110@Johnson
	Task: update log action for Cash Out
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

;WITH T AS (
	SELECT 60534 ActionID, N'Update Cash Out Status on Super by Admin' as EN, N'通过网络管理更新超级总代理实时兑现的状态' CS, N'通過網絡管理更新超級總代理實時兌現的狀態' CH, N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์โดยแอดมิน' TH, N'Cập nhật trạng thái Bán Vé Cược cho Super bởi Admin' VI
	UNION SELECT 60535, N'Update Cash Out Status on Super', N'更新超级总代理实时兑现的状态', N'更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์', N'Cập nhật trạng thái Bán Vé Cược cho Super'
	UNION SELECT 65568, N'Update Cash Out Status on Super by Admin', N'通过网络管理更新超级总代理实时兑现的状态', N'通過網絡管理更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Super bởi Admin'
	UNION SELECT 65569, N'Update Cash Out Status on Master by Admin', N'通过网络管理更新总代理实时兑现的状态', N'通過網絡管理更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Master bởi Admin'
	UNION SELECT 65570, N'Update Cash Out Status on Super', N'更新超级总代理实时兑现的状态', N'更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์', N'Cập nhật trạng thái Bán Vé Cược cho Super'
	UNION SELECT 65571, N'Update Cash Out Status on Master', N'更新总代理实时兑现的状态', N'更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์', N'Cập nhật trạng thái Bán Vé Cược cho Master'
	UNION SELECT 70606, N'Update Cash Out Status on Super by Admin', N'通过网络管理更新超级总代理实时兑现的状态', N'通過網絡管理更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Super bởi Admin'
	UNION SELECT 70607, N'Update Cash Out Status on Master by Admin', N'通过网络管理更新总代理实时兑现的状态', N'通過網絡管理更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Master bởi Admin'
	UNION SELECT 70608, N'Update Cash Out Status on Agent by Admin', N'通过网络管理更新代理实时兑现的状态', N'通過網絡管理更新代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับตัวแทนโดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Agent bởi Admin'
	UNION SELECT 70609, N'Update Cash Out Status on Super', N'更新超级总代理实时兑现的状态', N'更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์', N'Cập nhật trạng thái Bán Vé Cược cho Super'
	UNION SELECT 70610, N'Update Cash Out Status on Master', N'更新总代理实时兑现的状态', N'更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์', N'Cập nhật trạng thái Bán Vé Cược cho Master'
	UNION SELECT 70611, N'Update Cash Out Status on Agent', N'更新代理实时兑现的状态', N'更新代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับตัวแทน', N'Cập nhật trạng thái Bán Vé Cược cho Agent'
	UNION SELECT 75636, N'Update Cash Out Status on Super by Admin', N'通过网络管理更新超级总代理实时兑现的状态', N'通過網絡管理更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Super bởi Admin'
	UNION SELECT 75637, N'Update Cash Out Status on Master by Admin', N'通过网络管理更新总代理实时兑现的状态', N'通過網絡管理更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์โดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Master bởi Admin'
	UNION SELECT 75638, N'Update Cash Out Status on Agent by Admin', N'通过网络管理更新代理实时兑现的状态', N'通過網絡管理更新代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับตัวแทนโดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Agent bởi Admin'
	UNION SELECT 75639, N'Update Cash Out Status on Member by Admin', N'通过网络管理更新会员实时兑现的状态', N'通過網絡管理更新會員實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับสมาชิกโดยแอดมิน', N'Cập nhật trạng thái Bán Vé Cược cho Member bởi Admin'
	UNION SELECT 75640, N'Update Cash Out Status on Super', N'更新超级总代理实时兑现的状态', N'更新超級總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับซูปเปอร์', N'Cập nhật trạng thái Bán Vé Cược cho Super'
	UNION SELECT 75641, N'Update Cash Out Status on Master', N'更新总代理实时兑现的状态', N'更新總代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับมาสเตอร์', N'Cập nhật trạng thái Bán Vé Cược cho Master'
	UNION SELECT 75642, N'Update Cash Out Status on Agent', N'更新代理实时兑现的状态', N'更新代理實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับตัวแทน', N'Cập nhật trạng thái Bán Vé Cược cho Agent'
	UNION SELECT 75643, N'Update Cash Out Status on Member', N'更新会员实时兑现的状态', N'更新會員實時兌現的狀態', N'อัพเดทสถานะของแคชเอาท์สำหรับสมาชิก', N'Cập nhật trạng thái Bán Vé Cược cho Member'
)
UPDATE l
SET ActionNameEN = EN,
	ActionNameCH = CH,
	ActionNameCS = CS,
	ActionNameJP = EN,
	ActionNameIT = EN,
	ActionNameTH = TH,
	ActionNameKO = EN,
	ActionNameVI = VI,
	ActionNameCN = EN
FROM LogAction l
	INNER JOIN T ON l.ActionID = t.ActionID
GO
