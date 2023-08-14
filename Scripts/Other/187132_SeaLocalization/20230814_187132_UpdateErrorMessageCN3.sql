/*<info serverAlias="DBCUST-CustDB,DBTXN-bodb02"></info>*/
/*
	Created: 20230810@Luke
	Task: LAP - SEA Localization [Redmine: #187132]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--Update existed msg of CN3
CREATE TABLE #tmpMsgError(
	MsgID INT, 
	MsgNameEN NVARCHAR(500), 
	MsgNameVI NVARCHAR(500)
)

INSERT INTO #tmpMsgError(MsgID, MsgNameEN, MsgNameVI) VALUES
(40001, N'This username is not available.', N'Tên người dùng không khả dụng.'),
(40002, N'This user does not exist!', N'Người dùng này không tồn tại!'),
(40004, N'Create customer failed. Please try again.', N'Tạo khách hàng không thành công. Vui lòng thử lại.'),
(60020, N'This account was disabled', N'Tài khoản này đã bị vô hiệu'),
(90010, N'This function is not available during peak hour since it might affect the performance of the whole system. Please contact IT for further assistance.', N'Chức năng này không hoạt động trong giờ cao điểm để tránh ảnh hưởng đến hiệu suất của toàn hệ thống. Vui lòng liên hệ bộ phận IT để được hỗ trợ thêm.'),
(200001, N'The Group Commission does not exist, please check again!', N'Nhóm hoa hồng không tồn tại, vui lòng kiểm tra lại!'),
(200002, N'Player commission should not be greater than', N'Hoa hồng người chơi không được lớn hơn'),
(200003, N'Wrong input, please check again!', N'Nhập sai, vui lòng kiểm tra lại!'),
(200004, N'Selected customer(s) do not belong to any group.', N'Khách hàng được chọn không thuộc bất kỳ nhóm nào.'),
(200005, N'BA status can only be changed on Monday from 1PM to 5PM (GMT+8)', N'Chỉ có thể thay đổi trạng thái BA vào Thứ Hai từ 13h đến 17h (GMT+8)'),
(200008, N'Wrong special level !', N'Cấp độ đặc biệt không hợp lệ !'),
(200010, N'Could not update special level for this member !', N'Không thể cập nhật cấp độ đặc biệt cho thành viên này !'),
(200011, N'This Licensee does NOT have any setting!', N'Nhà Cái này KHÔNG có bất kỳ cài đặt nào !'),
(200012, N'Wrong discount.', N'Chiết khấu không hợp lệ.'),
(200013, N'Process turn on BA is unsuccessful !', N'Quá trình bật BA không thành công !'),
(200014, N'This member has already enabled BA !', N'Thành viên này đã kích hoạt BA !'),
(200015, N'Process turn off BA is unsuccessful !', N'Quá trình tắt BA không thành công !'),
(200016, N'This Group does not exist!', N'Nhóm này không tồn tại!'),
(200017, N'This is the default group. Do you want to proceed?', N'Đây là nhóm mặc định. Bạn có muốn tiếp tục?'),
(200018, N'Another group is currently set as default. Wanna set this group as default?', N'Nhóm khác hiện đang được thiết lập là mặc định. Bạn có muốn đặt nhóm này làm nhóm mặc định không?'),
(200019, N'Process create new group commission has been failed!', N'Quá trình tạo Nhóm hoa hồng mới đã bị lỗi!'),
(200020, N'This Group Name has been created before!', N'Tên nhóm này đã tồn tại!'),
(200026, N'This user does not belong to:', N'Người dùng này không thuộc về:'),
(200033, N'This currency is not offered to operate BA yet !', N'Đơn vị tiền tệ này không hỗ trợ BA !'),
(200034, N'This currency is not allowed BA !', N'Đơn vị tiền tệ này không được sử dụng cho BA !'),
(200035, N'This member has already enabled BA !', N'Thành viên này đã kích hoạt BA !'),
(200036, N'You are not allowed to change BA status !', N'Bạn không được phép thay đổi trạng thái BA !'),
(200037, N'This licensee is not allowed BA !', N'Nhà Cái không được phép sử dụng BA !'),
(200038, N'This member has already disabled BA ! ', N'Thành viên này đã bị vô hiệu hóa BA !'),
(200048, N'Cannot turn on BA for customers joining Bonus campaign.', N'Không thể kích hoạt BA cho khách hàng đang tham gia chương trình Thưởng.'),
(200049, N'You have reached the maximum number of updating customers'' commission. Please contact Customer Service to process your request.', N'Bạn đã đạt đến số lần tối đa cho việc cập nhật hoa hồng khách hàng. Vui lòng liên hệ với Dịch vụ Khách hàng để xử lý yêu cầu của bạn.'),
(200050, N'This is VIP player. To turn on BA, please turn off VIP for the player first.', N'Đây là người chơi VIP. Để kích hoạt BA, vui lòng tắt chế độ VIP của người chơi trước.')

UPDATE m
SET m.MsgNameEN = t.MsgNameEN, m.MsgNameVI = t.MsgNameVI
FROM MsgError m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpMsgError t WITH (NOLOCK) ON m.MsgID = t.MsgID
