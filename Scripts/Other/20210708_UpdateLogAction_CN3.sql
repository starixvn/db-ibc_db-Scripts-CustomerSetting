/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20210708
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameVI)
SELECT 220000, N'Cập Nhật Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout'
UNION ALL 
SELECT 220001, N'Cập Nhật Gián Tiếp Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout Indirectly'
UNION ALL
SELECT 220002, N'Cập Nhật Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout'
UNION ALL 
SELECT 220003, N'Cập Nhật Gián Tiếp Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout Indirectly'
UNION ALL
SELECT 220004, N'Cập Nhật Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout'
UNION ALL 
SELECT 220005, N'Cập Nhật Gián Tiếp Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout Indirectly'
UNION ALL
SELECT 220006, N'Cập Nhật Thanh Toán Tối Đa Cho Cược Xiên' --'Update Parlay Max Payout'
-------------------------------------------------------------------
UNION ALL
SELECT 1182, N'Mở Khoá Truy Cập'
UNION ALL
SELECT 948, N'Tài khoản này bị khóa do nhập sai mật khẩu 5 lần.'
UNION ALL
SELECT 949, N'Tài khoản phụ bị khóa do nhập sai mật khẩu 5 lần.'
UNION ALL
SELECT 65020, N'Cập nhật Trạng thái Đóng cho Super.'
UNION ALL
SELECT 70029, N'Cập nhật Trạng thái Đóng cho Super.'
UNION ALL
SELECT 70030, N'Cập nhật Trạng thái Đóng cho Master.'
UNION ALL
SELECT 75039, N'Cập nhật Trạng thái Đóng cho Super.'
UNION ALL
SELECT 75040, N'Cập nhật Trạng thái Đóng cho Master.'
UNION ALL
SELECT 75041, N'Cập nhật Trạng thái Đóng cho Agent.'
UNION ALL
SELECT 950, N'Tài khoản phụ bị đóng do nhập sai mật khẩu 5 lần.'

UPDATE l
SET l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

GO