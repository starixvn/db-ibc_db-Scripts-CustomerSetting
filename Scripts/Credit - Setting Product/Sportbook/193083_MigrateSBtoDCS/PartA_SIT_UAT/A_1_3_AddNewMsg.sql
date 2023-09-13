/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Add new Msg for Update Credit [#193083] 
	DB: DBCust/CustDB
*/

-- Add new Msg for Update Credit

IF EXISTS (SELECT 1 FROM MsgError me WITH (NOLOCK) WHERE me.MsgID IN (70030,70031,70032,70033,70034,70035,70036,70037))
BEGIN
	DELETE me FROM MsgError me WITH (ROWLOCK) WHERE me.MsgID IN (70030,70031,70032,70033,70034,70035,70036,70037)
END


	 INSERT INTO MsgError  ( MsgID , MsgGroupID , MsgNameEN , MsgNameCT , MsgNameCS , MsgNameJP , MsgNameTH , MsgNameKO , MsgNameES , MsgNameVI , IsActive , MsgNameCN , MsgNameIN)
	 SELECT 70030  AS MsgID , 8 AS MsgGroupID , N'The new credit has exceeded the available given credit ({number}).'  AS MsgNameEN , N'新額度已超過可用信用額({number})。' AS MsgNameCT , N'新额度已超过可用信用额({number})。' AS MsgNameCS , N'The new credit has exceeded the available given credit ({number}).' AS MsgNameJP , N'เครดิตใหม่เกินกว่าเครดิตที่ได้รับที่มีอยู่ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit has exceeded the available given credit ({number}).'  AS MsgNameES , N'Mức tín dụng mới đã vượt hạn mức tín dụng còn lại ({number})' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70031  AS MsgID , 8 AS MsgGroupID , N'The new credit must be greater than or equal to ({number}). '  AS MsgNameEN , N'新的信用額必須多於或等於({number})。' AS MsgNameCT , N'新的信用额必须多于或者等于({number})。' AS MsgNameCS , N'The new credit must be greater than or equal to ({number}). ' AS MsgNameJP , N'เครดิตใหม่จะต้องมากกว่าหรือเท่ากับ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit must be greater than or equal to ({number}). '  AS MsgNameES , N'Mức tín dụng mới phải lớn hơn hoặc bằng ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70032  AS MsgID , 8 AS MsgGroupID , N'The new credit has exceeded the maximum Member credit set by upline ({number}).'  AS MsgNameEN , N'新額度已超過上線設定於的最高會員信用額({number})。' AS MsgNameCT , N'新额度已超过上线设定的最高会员信用额({number})。' AS MsgNameCS , N'The new credit has exceeded the maximum Member credit set by upline ({number}).' AS MsgNameJP , N'เครดิตใหม่เกินกว่าเครดิตสูงสุดสำหรับสมาชิกที่กำหนดโดยอัพไลน์ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit has exceeded the maximum Member credit set by upline ({number}).'  AS MsgNameES , N'Mức tín dụng mới đã vượt hạn mức tín dụng tối đa của Member được cấp bởi cấp trên ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70033  AS MsgID , 8 AS MsgGroupID , N'The new credit is insufficient for all current Members ({number}).'  AS MsgNameEN , N'新額度不足給目前的會員({number})。' AS MsgNameCT , N'新额度不足给目前的会员({number})。' AS MsgNameCS , N'The new credit is insufficient for all current Members ({number}).' AS MsgNameJP , N'เครดิตใหม่ไม่เพียงพอสำหรับสมาชิกทั้งหมดที่มีอยู่ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit is insufficient for all current Members ({number}).'  AS MsgNameES , N'Mức tín dụng mới không đủ cho các Member hiện tại ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70034  AS MsgID , 8 AS MsgGroupID , N'The Member max credit must be less than or equal to the Agent credit ({number}).'  AS MsgNameEN , N'會員最高信用額必須少於或者等於代理信用額({number})。' AS MsgNameCT , N'会员最高信用额必须少于或者等于代理信用额({number})。' AS MsgNameCS , N'The Member max credit must be less than or equal to the Agent credit ({number}).' AS MsgNameJP , N'เครดิตสูงสุดของสมาชิกต้องน้อยกว่าหรือเท่ากับเครดิตของเอเย่นต์ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The Member max credit must be less than or equal to the Agent credit ({number}).'  AS MsgNameES , N'Hạn mức tín dụng tối đa của Member phải nhỏ hơn hoặc bằng hạn mức tín dụng của Agent ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70035  AS MsgID , 8 AS MsgGroupID , N'The Member max credit must be greater than or equal to current Member credit ({number}).'  AS MsgNameEN , N'會員最高信用額必須多於或者等於目前會員信用額({number})。' AS MsgNameCT , N'会员最高信用额必须多于或者等于目前会员信用额({number})。' AS MsgNameCS , N'The Member max credit must be greater than or equal to current Member credit ({number}).' AS MsgNameJP , N'เครดิตสูงสุดของสมาชิกจะต้องมากกว่าหรือเท่ากับเครดิตปัจจุบันของสมาชิก ({number})' AS MsgNameTH, N''  MsgNameKO , N'The Member max credit must be greater than or equal to current Member credit ({number}).'  AS MsgNameES , N'Hạn mức tín dụng tối đa của Member phải lớn hơn hoặc bằng hạn mức tín dụng hiện tại của Member ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70036  AS MsgID , 8 AS MsgGroupID , N'The new credit is insufficient for all current Agents ({number}).'  AS MsgNameEN , N'新額度不足給目前的代理({number})。' AS MsgNameCT , N'新额度不足给目前的代理({number})。' AS MsgNameCS , N'The new credit is insufficient for all current Agents ({number}).' AS MsgNameJP , N'เครดิตใหม่ไม่เพียงพอสำหรับเอเย่นต์ทั้งหมดที่มีอยู่ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit is insufficient for all current Agents ({number}).'  AS MsgNameES , N'Mức tín dụng mới không đủ cho các Agent hiện tại ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  
 UNION SELECT 70037  AS MsgID , 8 AS MsgGroupID , N'The new credit is insufficient for all current Masters ({number}).'  AS MsgNameEN , N'新額度不足給目前的總代理({number})。' AS MsgNameCT , N'新额度不足给目前的总代理({number})。' AS MsgNameCS , N'The new credit is insufficient for all current Masters ({number}).' AS MsgNameJP , N'เครดิตใหม่ไม่เพียงพอสำหรับมาสเตอร์ทั้งหมดที่มีอยู่ ({number})' AS MsgNameTH, N''  MsgNameKO , N'The new credit is insufficient for all current Masters ({number}).'  AS MsgNameES , N'Mức tín dụng mới không đủ cho các Master hiện tại ({number}).' AS MsgNameVI , 1 AS IsActive , N'' AS MsgNameCN , N'' AS MsgNameIN  




-- Add new Msg for BetSetting : MaxPayoutPerMatch

IF EXISTS (SELECT 1 FROM MsgError me  WITH (NOLOCK) WHERE me.MsgID IN (10075,10076,10077))
BEGIN
	DELETE me FROM MsgError me WITH (ROWLOCK) WHERE me.MsgID IN (10075,10076,10077)
END


	 INSERT INTO MsgError  ( MsgID , MsgGroupID , MsgNameEN , MsgNameCT , MsgNameCS , MsgNameJP , MsgNameTH , MsgNameKO , MsgNameES , MsgNameVI , IsActive , MsgNameCN , MsgNameIN)
	
	 SELECT 10075 , 8 , N'Max Payout Per Match must be less than or equal to Super Max Payout Per Match' , N'單場最高派彩必須小于或等于超級總代理單場最高派彩' , N'单场最高派彩必须小于或等于超级总代理单场最高派彩' , N'Max Payout Per Match must be less than or equal to Super Max Payout Per Match' , N'การจ่ายเงินสูงสุดต่อการแข่งขัน จะต้องน้อยกว่าหรือเท่ากับ การจ่ายเงินสูงสุดสูงสุดต่อการแข่งขันของซุปเปอร์' , N'Max Payout Per Match must be less than or equal to Super Max Payout Per Match' , N'Max Payout Per Match must be less than or equal to Super Max Payout Per Match' , N'Thanh Toán Tối Đa Mỗi Trận phải nhỏ hơn hoặc bằng Thanh Toán Tối Đa Mỗi Trận của Super' , 1 , '' , '' 	
 UNION SELECT 10076 , 8 , N'Max Payout Per Match must be less than or equal to Master Max Payout Per Match' , N'單場最高派彩必須小于或等于總代理單場最高派彩' , N'单场最高派彩必须小于或等于总代理单场最高派彩' , N'Max Payout Per Match must be less than or equal to Master Max Payout Per Match' , N'การจ่ายเงินสูงสุดต่อการแข่งขัน จะต้องน้อยกว่าหรือเท่ากับ การจ่ายเงินหลักสูงสุดต่อการแข่งขันของมาสเตอร์' , N'Max Payout Per Match must be less than or equal to Master Max Payout Per Match' , N'Max Payout Per Match must be less than or equal to Master Max Payout Per Match' , N'Thanh Toán Tối Đa Mỗi Trận phải nhỏ hơn hoặc bằng Thanh Toán Tối Đa Mỗi Trận của Master' , 1 , '' , '' 	
 UNION SELECT 10077 , 8 , N'Max Payout Per Match must be less than or equal to Agent Max Payout Per Match' , N'單場最高派彩必須小于或等于代理單場最高派彩' , N'单场最高派彩必须小于或等于代理单场最高派彩' , N'Max Payout Per Match must be less than or equal to Agent Max Payout Per Match' , N'การจ่ายเงินสูงสุดต่อการแข่งขัน จะต้องน้อยกว่าหรือเท่ากับ การจ่ายเงินสูงสุดของตัวแทนต่อการแข่งขันของเอเย่นต์' , N'Max Payout Per Match must be less than or equal to Agent Max Payout Per Match' , N'Max Payout Per Match must be less than or equal to Agent Max Payout Per Match' , N'Thanh Toán Tối Đa Mỗi Trận phải nhỏ hơn hoặc bằng Thanh Toán Tối Đa Mỗi Trận của Agent' , 1 , '' , '' 	




