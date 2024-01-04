/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231124@Luke
	Task: LAP - Support Indonesian & Thai language [Redmine: #196246]
	DB: DBCUST/CustDB
*/

--Update Indo & Thai Msg
CREATE TABLE #tmpMsgError(
	MsgID INT, 
	MsgNameEN NVARCHAR(500), 
	MsgNameIN NVARCHAR(500),
	MsgNameTH NVARCHAR(500)
)

INSERT INTO #tmpMsgError(MsgID, MsgNameEN, MsgNameIN, MsgNameTH) VALUES
(40001, N'This username is not available!', N'Nama pengguna ini tidak tersedia!', N'ไม่สามารถใช้ชื่อนี้ได้'),
(40002, N'This user does not exist!', N'Pengguna ini tidak ada!', N'ไม่มีผู้ใช้รายนี้'),
(40004, N'Create customer failed. Please try again.', N'Gagal membuat pelanggan. Silakan coba lagi.', N'สร้างลูกค้าไม่สำเร็จ กรุณาลองอีกครั้ง'),
(60020, N'This account was disabled!', N'Akun ini telah dinonaktifkan!', N'บัญชีนี้ถูกปิดใช้งาน'),
(90001, N'Update process is unsuccessful!', N'Proses pembaruan tidak berhasil!', N'กระบวนการอัปเดตไม่สำเร็จ'),
(90010, N'This function is not available during peak hour since it might affect the performance of the whole system. Please contact IT for further assistance.', N'Fungsi ini tidak tersedia selama jam sibuk karena dapat mempengaruhi kinerja seluruh sistem. Harap hubungi IT untuk bantuan lebih lanjut.', N'ฟังก์ชันนี้ไม่สามารถใช้งานได้ในช่วงชั่วโมงเร่งด่วน เนื่องจากอาจส่งผลต่อประสิทธิภาพการทำงานของระบบทั้งหมด โปรดติดต่อฝ่ายไอทีเพื่อขอความช่วยเหลือเพิ่มเติม'),
(200001, N'The Group Commission does not exist, please check again!', N'Komisi Grup tidak ada, harap periksa kembali!', N'ไม่มีกลุ่มคอมมิชชั่น โปรดตรวจสอบอีกครั้ง'),
(200002, N'Player commission should not be greater than', N'Komisi Pemain tidak boleh lebih besar dari', N'ค่าคอมมิชชั่นของผู้เล่นไม่ควรมากกว่า'),
(200003, N'Wrong input, please check again!', N'Input salah, harap periksa kembali!', N'ป้อนผิด กรุณาตรวจสอบอีกครั้ง'),
(200004, N'Selected customer(s) do not belong to any group.', N'Pelanggan yang dipilih tidak termasuk dalam grup apa pun.', N'ลูกค้าที่เลือกไม่ได้อยู่ในกลุ่มใดๆ'),
(200005, N'BA status can only be changed on Monday from 1PM to 5PM (GMT+8)', N'Status BA hanya dapat diubah pada hari Senin dari pukul 13.00 hingga 17.00 (GMT+8)', N'สถานะ BA สามารถเปลี่ยนได้ในวันจันทร์ ตั้งแต่เวลา13:00-17:00 (GMT+8)'),
(200008, N'Wrong special level!', N'Level khusus yang salah!', N'ระดับพิเศษผิด'),
(200010, N'Could not update special level for this member!', N'Tidak dapat memperbarui level khusus untuk anggota ini!', N'ไม่สามารถอัปเดตระดับพิเศษสำหรับสมาชิกรายนี้'),
(200011, N'This Licensee does NOT have any setting!', N'Licensee ini TIDAK memiliki pengaturan apa pun!', N'ผู้ได้รับอนุญาตนี้ไม่มีการตั้งค่าใดๆ'),
(200012, N'Wrong discount.', N'Diskon yang salah.', N'ส่วนลดผิด'),
(200013, N'Process turn on BA is unsuccessful!', N'Proses mengaktifkan BA tidak berhasil!', N'กระบวนการเปิด BA ไม่สำเร็จ'),
(200014, N'This member has already enabled BA!', N'Anggota ini telah mengaktifkan BA sebelumnya!', N'สมาชิกรายนี้ได้เปิดใช้งาน BA แล้ว'),
(200015, N'Process turn off BA is unsuccessful!', N'Proses menonaktifkan BA tidak berhasil!', N'กระบวนการปิด BA ไม่สำเร็จ'),
(200016, N'This Group does not exist!', N'Grup ini tidak ada!', N'ไม่มีกลุ่มนี้'),
(200017, N'This is the default group. Do you want to proceed?', N'Ini adalah grup default. Apakah Anda ingin melanjutkan?', N'ค่าคอมมิชชั่นของผู้เล่นไม่ควรมากกว่า'),
(200018, N'Another group is currently set as default. Wanna set this group as default?', N'Grup lain saat ini diatur sebagai default. Apakah Anda ingin mengatur grup ini sebagai default?', N'ขณะนี้กลุ่มอื่นถูกตั้งค่าเป็นค่าเริ่มต้น ต้องการตั้งค่ากลุ่มนี้เป็นค่าเริ่มต้นหรือไม่'),
(200019, N'Process create new group commission has been failed!', N'Proses pembuatan komisi grup baru gagal!', N'กระบวนการสร้างกลุ่มค่าคอมมิชชั่นใหม่ล้มเหลว'),
(200020, N'This group name has been already chosen, please try another name!', N'Nama grup ini sudah dipilih, harap coba nama lain!', N'ชื่อกลุ่มนี้ถูกเลือกแล้ว โปรดลองใช้ชื่ออื่น'),
(200026, N'This user does not belong to:', N'Pengguna ini tidak termasuk dalam:', N'ผู้ใช้นี้ไม่ได้เป็นของ'),
(200033, N'This currency is not offered to operate BA yet!', N'Mata uang ini belum ditawarkan untuk pengoperasian BA!', N'สกุลเงินนี้ยังไม่ได้รับการเสนอให้ใช้งาน BA'),
(200034, N'This currency is not allowed BA!', N'Mata uang ini tidak diizinkan untuk BA!', N'BA ไม่อนุญาตให้ใช้สกุลเงินนี้'),
(200035, N'This member has already enabled BA!', N'Anggota ini telah mengaktifkan BA sebelumnya!', N'สมาชิกรายนี้ได้เปิดใช้งาน BA แล้ว'),
(200036, N'You are not allowed to change BA status!', N'Anda tidak diizinkan untuk mengubah status BA!', N'คุณไม่ได้รับอนุญาตให้เปลี่ยนสถานะ BA'),
(200037, N'This licensee is not allowed BA!', N'Lisensi ini tidak diizinkan untuk BA!', N'ผู้ได้รับอนุญาตนี้ไม่ได้รับอนุญาตให้ BA'),
(200038, N'This member has already disabled BA! ', N'Anggota ini telah menonaktifkan BA sebelumnya!', N'สมาชิกรายนี้ได้ปิดการใช้งาน BA แล้ว'),
(200048, N'Cannot turn on BA for customers joining Bonus campaign.', N'Tidak dapat mengaktifkan BA untuk pelanggan yang mengikuti kampanye Bonus.', N'ไม่สามารถเปิด BA สำหรับลูกค้าที่เข้าร่วมแคมเปญโบนัส'),
(200049, N'You have reached the maximum number of updating customers'' commission. Please contact Customer Service to process your request.', N'Anda telah mencapai jumlah maksimum pembaruan komisi pelanggan. Silakan hubungi Layanan Pelanggan untuk memproses permintaan Anda.', N'คุณมาถึงจำนวนสูงสุดของการอัพเดทค่าคอมมิชชั่นของลูกค้าแล้ว โปรดติดต่อฝ่ายบริการลูกค้าเพื่อดำเนินการตามคำขอของคุณ'),
(200050, N'This is VIP player. To turn on BA, please turn off VIP for the player first.', N'Ini adalah pemain VIP. Untuk mengaktifkan BA, harap nonaktifkan status VIP terlebih dahulu.', N'นี่คือผู้เล่นวีไอพี หากต้องการเปิด BA โปรดปิดวีไอพี ของผู้เล่นก่อน'),
(200051, N'Customer does not belong to licensee', N'Pelanggan tidak termasuk dalam lisensi', N'ลูกค้าไม่ได้เป็นผู้รับอนุญาต')

UPDATE m
SET m.MsgNameIN = t.MsgNameIN, m.MsgNameTH = t.MsgNameTH
FROM MsgError m WITH (ROWLOCK)
	INNER JOIN #tmpMsgError t ON m.MsgID = t.MsgID

