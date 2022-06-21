/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220622@Johnson
	Task: update system setting for telegram bot service [#RedmineID:#167819]
	DB: DBBOT/bodb_Chatbot
*/


DELETE BotResource

;WITH T AS(
SELECT 	'Action_Name'	ResourceName,	'1'	ResourceKey,	'en-US'	Language,	N'Outstanding' Value
UNION ALL SELECT 	'Action_Name'	,	'1'	,	'zh-Hans'	,	N'未完成交易'
UNION ALL SELECT 	'Action_Name'	,	'1'	,	'zh-Hant'	,	N'未完成交易'
UNION ALL SELECT 	'Action_Name'	,	'1'	,	'th-TH'	,	N'การเดิมพันที่ยังไม่สิ้นสุด'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'en-US'	,	N'Balance Info'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'zh-Hans'	,	N'余额资料'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'zh-Hant'	,	N'餘額資料'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'th-TH'	,	N'ข้อมูลยอดเงินคงเหลือ'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'en-US'	,	N'Today Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'zh-Hans'	,	N'今日输赢'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'zh-Hant'	,	N'今日輸贏'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'th-TH'	,	N'ยอดได้เสียวันนี้'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'en-US'	,	N'Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'zh-Hans'	,	N'昨日输赢'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'zh-Hant'	,	N'昨日輸贏'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'th-TH'	,	N'ยอดได้เสียเมื่อวาน'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'en-US'	,	N'Top 50 Outstanding'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'zh-Hans'	,	N'前50未结束交易'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'zh-Hant'	,	N'前50未結束交易'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'th-TH'	,	N'ยอดค้างชำระ 50 อันดับแรก'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'en-US'	,	N'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'zh-Hans'	,	N'输入下线用户名'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'zh-Hant'	,	N'輸入下線用戶名'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'th-TH'	,	N'ป้อนชื่อผู้ใช้ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'en-US'	,	N'Top X Outstanding'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'zh-Hans'	,	N'前x未结束交易'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'zh-Hant'	,	N'前x未結束交易'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'th-TH'	,	N'ยอดค้างชำระ X อันดับแรก'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'en-US'	,	N'Please enter your downline username to view Outstanding Report.'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'zh-Hans'	,	N'请输入您的下线用户以查看未结束交易'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'zh-Hant'	,	N'請輸入您的下線用戶以查看未結束交易'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'th-TH'	,	N'โปรดป้อนชื่อผู้ใช้ดาวน์ไลน์ของคุณเพื่อดูรายงานยอดค้างชำระ'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'en-US'	,	N'How many downlines would you like to include in Outstanding Report?
Chatbot supports listing up to 100 downlines.'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'zh-Hans'	,	N'您想要在未结束交易报告中包括多少个下线?
Chatbot支持列出最多100个下线'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'zh-Hant'	,	N'您想要在未結束交易報告中包括多少個下線?
Chatbot支持列出最多100個下線'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'th-TH'	,	N'จำนวนดาวน์ไลน์เท่าใดที่คุณต้องการเพิ่มในรายงานยอดค้างชำระ?
Chatbotสามารถรองรับรายชื่อของดาวน์ไลน์สูงสุดจำนวน 100 รายการ'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'en-US'	,	N'Settings'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'zh-Hans'	,	N'设定'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'zh-Hant'	,	N'設定'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'th-TH'	,	N'ตั้งค่า'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'en-US'	,	N'My Balance'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'zh-Hans'	,	N'我的余额'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'zh-Hant'	,	N'我的餘額'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'th-TH'	,	N'ยอดคงเหลือของฉัน'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'en-US'	,	N'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'zh-Hans'	,	N'输入下线用户名'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'zh-Hant'	,	N'輸入下線用戶名'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'th-TH'	,	N'ป้อนชื่อผู้ใช้ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'en-US'	,	N'Top X Balance'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'zh-Hans'	,	N'前 x 余额'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'zh-Hant'	,	N'前 x 餘額'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'th-TH'	,	N'ยอดคงเหลือสูงสุด X'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'en-US'	,	N'Please enter your downline username to view Balance Report.'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'zh-Hans'	,	N'请输入您的下线账号以查看余额报告'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'zh-Hant'	,	N'請輸入您的下線賬號以查看餘額報告'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'th-TH'	,	N'โปรดป้อนชื่อผู้ใช้ดาวน์ไลน์ของคุณเพื่อดูรายงานยอดคงเหลือ'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'en-US'	,	N'How many downlines would you like to include in Balance Report?
Chatbot supports listing up to 100 downlines.'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'zh-Hans'	,	N'您想要在余额报告中包括多少个下线?
Chatbot支持列出最多100个下线'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'zh-Hant'	,	N'您想要在餘額報告中包括多少個下線?
Chatbot支持列出最多100個下線'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'th-TH'	,	N'จำนวนดาวน์ไลน์เท่าใดที่คุณต้องการเพิ่มในรายงานรายงานยอดคงเหลือ?
Chatbotสามารถรองรับรายชื่อของดาวน์ไลน์สูงสุดจำนวน 100 รายการ'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'en-US'	,	N'My Today Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'zh-Hans'	,	N'我的今日输赢'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'zh-Hant'	,	N'我的今日輸贏'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'th-TH'	,	N'ยอดชนะ/แพ้วันนี้ของฉัน'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'en-US'	,	N'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'zh-Hans'	,	N'输入下线用户名'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'zh-Hant'	,	N'輸入下線用戶名'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'th-TH'	,	N'ป้อนชื่อผู้ใช้ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'en-US'	,	N'Please enter your downline username to view Today Win Loss Report.'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'zh-Hans'	,	N'请输入您的下线账号以查看今日输赢报告'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'zh-Hant'	,	N'請輸入您的下線賬號以查看今日輸贏報告'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'th-TH'	,	N'โปรดป้อนชื่อผู้ใช้ดาวน์ไลน์ของคุณเพื่อดูรายงานชนะ แพ้วันนี้'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'en-US'	,	N'My Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'zh-Hans'	,	N'正确'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'zh-Hant'	,	N'正確'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'th-TH'	,	N'ถูกต้อง'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'en-US'	,	N'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'zh-Hans'	,	N'输入下线用户名'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'zh-Hant'	,	N'輸入下線用戶名'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'th-TH'	,	N'ป้อนชื่อผู้ใช้ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'en-US'	,	N'Please enter your downline username to view Yesterday Win Loss Report.'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'zh-Hans'	,	N'请输入您的下线账号以查看昨日输赢报告'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'zh-Hant'	,	N'請輸入您的下線賬號以查看昨日輸贏報告'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'th-TH'	,	N'โปรดป้อนชื่อผู้ใช้ดาวน์ไลน์ของคุณเพื่อดูรายงานชนะ แพ้เมื่อวาน'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'en-US'	,	N'Notifications'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'zh-Hans'	,	N'通告'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'zh-Hant'	,	N'通告'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'th-TH'	,	N'การแจ้งเตือน'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'en-US'	,	N'Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'zh-Hans'	,	N'昨日输赢'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'zh-Hant'	,	N'昨日輸贏'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'th-TH'	,	N'ยอดได้เสียเมื่อวาน'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'en-US'	,	N'Personal Message'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'zh-Hans'	,	N'个人讯息'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'zh-Hant'	,	N'個人訊息'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'th-TH'	,	N'ข้อความส่วนตัว'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'en-US'	,	N'Problem Account'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'zh-Hans'	,	N'问题账号'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'zh-Hant'	,	N'問題賬號'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'th-TH'	,	N'บัญชีที่มีปัญหา'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'en-US'	,	N'Member Win Loss Limit'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'zh-Hans'	,	N'会员输赢限额'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'zh-Hant'	,	N'會員輸贏限額'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'th-TH'	,	N'จำกัดยอดชนะ/แพ้ของสมาชิก'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'en-US'	,	N'Change Password Alert'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'zh-Hans'	,	N'警惕更换密码'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'zh-Hant'	,	N'警惕更換密碼'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'th-TH'	,	N'แจ้งเตือนเปลี่ยนรหัสผ่าน'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'en-US'	,	N'Change Security Code Alert'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'zh-Hans'	,	N'警惕更换保安码'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'zh-Hant'	,	N'警惕更換保安碼'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'th-TH'	,	N'แจ้งเตือนเปลี่ยนรหัสความปลอดภัย'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'en-US'	,	N'Abnormal Login Alert'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'zh-Hans'	,	N'警惕登入不正常'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'zh-Hant'	,	N'警惕登入不正常'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'th-TH'	,	N'แจ้งเตือนการเข้าสู่ระบบผิดปกติ'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'en-US'	,	N'Language'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'zh-Hans'	,	N'语言'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'zh-Hant'	,	N'語言'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'th-TH'	,	N'ภาษา'
UNION ALL SELECT 	'Action_Name'	,	'35'	,	'en-US'	,	N'English'
UNION ALL SELECT 	'Action_Name'	,	'36'	,	'en-US'	,	N'繁體中文'
UNION ALL SELECT 	'Action_Name'	,	'37'	,	'en-US'	,	N'简体中文'
UNION ALL SELECT 	'Action_Name'	,	'38'	,	'en-US'	,	N'ภาษาไทย'
UNION ALL SELECT 	'Action_Name'	,	'40'	,	'en-US'	,	N'Stop Using Chatbot'
UNION ALL SELECT 	'Action_Name'	,	'40'	,	'zh-Hans'	,	N'停止使用Chatbot'
UNION ALL SELECT 	'Action_Name'	,	'40'	,	'zh-Hant'	,	N'停止使用Chatbot'
UNION ALL SELECT 	'Action_Name'	,	'40'	,	'th-TH'	,	N'หยุดการใช้งานChatbot'
UNION ALL SELECT 	'Action_Description'	,	'1'	,	'en-US'	,	N'Open Outstanding Menu'
UNION ALL SELECT 	'Action_Description'	,	'1'	,	'zh-Hans'	,	N'打开未结束交易目录'
UNION ALL SELECT 	'Action_Description'	,	'1'	,	'zh-Hant'	,	N'打開未結束交易目錄'
UNION ALL SELECT 	'Action_Description'	,	'1'	,	'th-TH'	,	N'เปิดเมนูยอดค้างชำระ'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'en-US'	,	N'Open Balance Info Menu'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'zh-Hans'	,	N'打开余额资料列表'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'zh-Hant'	,	N'打開餘額資料列表'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'th-TH'	,	N'เปิดเมนูข้อมูลยอดคงเหลือ'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'en-US'	,	N'Open Today Win Loss Report Menu'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'zh-Hans'	,	N'打开今日输赢报告列表'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'zh-Hant'	,	N'打開今日輸贏報告列表'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'th-TH'	,	N'เปิดเมนูรายงานชนะ/แพ้วันนี้'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'en-US'	,	N'Open Yesterday Win Loss Report Menu'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'zh-Hans'	,	N'打开昨日输赢报告列表'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'zh-Hant'	,	N'打開昨日輸贏報告列表'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'th-TH'	,	N'เปิดเมนูรายงานชนะ/แพ้เมื่อวาน'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'en-US'	,	N'Get Outstanding Report of top 50 downlines'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'zh-Hans'	,	N'获取前50的下线未结束交易报告'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'zh-Hant'	,	N'獲取前50的下線未結束交易報告'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'th-TH'	,	N'รับรายงานยอดค้างชำระของดาวน์ไลน์ 50 อันดับแรก'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'en-US'	,	N'Get Outstanding Report of a specific downline'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'zh-Hans'	,	N'获取特定下线的未结束报告'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'zh-Hant'	,	N'獲取特定下線的未結束報告'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'th-TH'	,	N'รับรายงานยอดค้างชำระของดาวน์ไลน์ที่เฉพาะเจาะจง'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'en-US'	,	N'Get Outstanding Report of top # downlines'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'zh-Hans'	,	N'获取前#的下线未结束交易报告'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'zh-Hant'	,	N'獲取前#的下線未結束交易報告'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'th-TH'	,	N'รับรายงานยอดค้างชำระอันดับแรก #ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'en-US'	,	N'Get your Balance Info Report'
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'zh-Hans'	,	N'获取您的余额资料报告'
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'zh-Hant'	,	N'獲取您的餘額資料報告'
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'th-TH'	,	N'รับรายงานข้อมูลยอดคงเหลือของคุณ'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'en-US'	,	N'Get Balance Info Report of a specific downline'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'zh-Hans'	,	N'获取特定下线的余额资料报告'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'zh-Hant'	,	N'獲取特定下線的餘額資料報告'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'th-TH'	,	N'รับรายงานข้อมูลยอดคงเหลือของดาวน์ไลน์ที่เฉพาะเจาะจง'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'en-US'	,	N'Get Balance Info Report of the top # downlines'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'zh-Hans'	,	N'获取前#下线的余额资料报告'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'zh-Hant'	,	N'獲取前#下線的餘額資料報告'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'th-TH'	,	N'รับรายงานข้อมูลยอดคงเหลืออันดับแรก # ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'en-US'	,	N'Get your Today Win Loss Report'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'zh-Hans'	,	N'获取您今日输赢报告'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'zh-Hant'	,	N'獲取您今日輸贏報告'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'th-TH'	,	N'รับรายงานยอดได้เสียวันนี้'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'en-US'	,	N'Get Today Win Loss Report of a specific downline'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'zh-Hans'	,	N'获取特定下线的今日输赢报告'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'zh-Hant'	,	N'獲取特定下線的今日輸贏報告'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'th-TH'	,	N'รับรายงานชนะ/แพ้ของดาวน์ไลน์เฉพาะวันนี้'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'en-US'	,	N'Get your Yesterday Win Loss Report'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'zh-Hans'	,	N'获取您昨日的输赢报告'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'zh-Hant'	,	N'獲取您昨日的輸贏報告'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'th-TH'	,	N'รับรายงานชนะ/แพ้เมื่อวานของคุณ'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'en-US'	,	N'Get Yesterday Win Loss Report of a specific downline'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'zh-Hans'	,	N'获取特定下线昨日的输赢报告'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'zh-Hant'	,	N'獲取特定下線昨日的輸贏報告'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'th-TH'	,	N'รับรายงานชนะ/แพ้เมื่อวานของดาวน์ไลน์ที่เฉพาะเจาะจง'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'en-US'	,	N'Outstanding'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'zh-Hans'	,	N'未完成交易'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'zh-Hant'	,	N'未完成交易'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'th-TH'	,	N'การเดิมพันที่ยังไม่สิ้นสุด'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'en-US'	,	N'Balance Info'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'zh-Hans'	,	N'余额资料'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'zh-Hant'	,	N'餘額資料'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'th-TH'	,	N'ข้อมูลยอดเงินคงเหลือ'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'en-US'	,	N'Today Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'zh-Hans'	,	N'今日输赢'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'zh-Hant'	,	N'今日輸贏'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'th-TH'	,	N'ยอดได้เสียวันนี้'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'en-US'	,	N'Yesterday Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'zh-Hans'	,	N'昨日输赢'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'zh-Hant'	,	N'昨日輸贏'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'th-TH'	,	N'ยอดได้เสียเมื่อวาน'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'en-US'	,	N'Yesterday Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'zh-Hans'	,	N'昨日输赢'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'zh-Hant'	,	N'昨日輸贏'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'th-TH'	,	N'ยอดได้เสียเมื่อวาน'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'en-US'	,	N'Personal Message'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'zh-Hans'	,	N'个人讯息'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'zh-Hant'	,	N'個人訊息'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'th-TH'	,	N'ข้อความส่วนตัว'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'en-US'	,	N'Problem Account'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'zh-Hans'	,	N'问题账号'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'zh-Hant'	,	N'問題賬號'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'th-TH'	,	N'บัญชีที่มีปัญหา'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'en-US'	,	N'Member Win Loss Limit'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'zh-Hans'	,	N'会员输赢限额'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'zh-Hant'	,	N'會員輸贏限額'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'th-TH'	,	N'จำกัดยอดชนะ/แพ้ของสมาชิก'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'en-US'	,	N'Change Password Alert'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'zh-Hans'	,	N'警惕更换密码'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'zh-Hant'	,	N'警惕更換密碼'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'th-TH'	,	N'การแจ้งเตือนเปลี่ยนรหัสผ่าน'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'en-US'	,	N'Change Security Code Alert'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'zh-Hans'	,	N'警惕更换保安码'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'zh-Hant'	,	N'警惕更換保安碼'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'th-TH'	,	N'แจ้งเตือนเปลี่ยนรหัสความปลอดภัย'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'en-US'	,	N'Abnormal Login Alert'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'zh-Hans'	,	N'警惕登入不正常'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'zh-Hant'	,	N'警惕登入不正常'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'th-TH'	,	N'แจ้งเตือนการเข้าสู่ระบบผิดปกติ'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'en-US'	,	N'Settings'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'zh-Hans'	,	N'设定'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'zh-Hant'	,	N'設定'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'th-TH'	,	N'ตั้งค่า'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'en-US'	,	N'Get the <b>"Total"</b> values of your and your downlines'' Outstanding Report on the current date'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'zh-Hans'	,	N'获取您和您的下线在当前日期未完成交易报告的<b>"总"</b> 数额'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'zh-Hant'	,	N'獲取您和您的下線在當前日期未完成交易報告的<b>"總"</b> 數額'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'th-TH'	,	N'รับ <b>"ยอดรวม"</b> ของรายงานยอดค้างชำระของคุณและดาวน์ไลน์ของคุณในวันที่ปัจจุบัน'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'en-US'	,	N'Get your and your downlines'' Balance Info Report'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'zh-Hans'	,	N'获取您和您的下线的余额资料报告'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'zh-Hant'	,	N'獲取您和您的下線的餘額資料報告'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'th-TH'	,	N'รับรายงานข้อมูลยอดคงเหลือของคุณและดาวน์ไลน์'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'en-US'	,	N'Get the <b>"Total"</b> values of your and your downlines'' Win Loss Report on the current date'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'zh-Hans'	,	N'获取您和您的下线在当前日期输赢报告的<b>"总"</b> 数额'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'zh-Hant'	,	N'獲取您和您的下線在當前日期輸贏報告的<b>"總"</b> 數額'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'th-TH'	,	N'รับ <b>ยอดรวม"</b> รายงานชนะ/แพ้ของคุณและดาวน์ไลน์ในวันที่ปัจจุบัน'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'en-US'	,	N'Get the <b>"Total"</b> values of your and your downlines'' Yesterday Win Loss Report.'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'zh-Hans'	,	N'获取您和您的下线在昨日输赢报告的<b>"总"</b> 数额'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'zh-Hant'	,	N'獲取您和您的下線在昨日輸贏報告的<b>"總"</b> 數額'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'th-TH'	,	N'รับ <b>ยอดรวม"</b> รายงานการชนะ/แพ้ของเมื่อวานสำหรับคุณและดาวน์ไลน์ของคุณ'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'en-US'	,	N'Send the <b>"Total"</b> values of Yesterday Win Loss Report to your Telegram after 2:00PM (GMT+8) everyday'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'zh-Hans'	,	N'每天下注 2:00PM (GMT+8) 后发送昨日输赢报告的<b> "总" </b> 数额'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'zh-Hant'	,	N'每天下注 2:00PM (GMT+8) 後發送昨日輸贏報告的<b> "總" </b> 數額'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'th-TH'	,	N'ส่ง <b>"ยอดรวม"</b>รายงานชนะ/แพ้ของเมื่อวานหลัง 2:00PM (GMT+8) ของทุกวัน'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'en-US'	,	N'Push Personal Messages to your Telegram'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'zh-Hans'	,	N'个人消息将发送到您的Telegram'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'zh-Hant'	,	N'個人消息將发送到您的Telegram'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'th-TH'	,	N'ส่งข้อความส่วนตัวไปยังเทเลแกรมของคุณ'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'en-US'	,	N'Notify via your Telegram when there is a new downline marked as Problem Account'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'zh-Hans'	,	N'当新的下线被标记为问题账号通过Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'zh-Hant'	,	N'當新的下線被標記為問題賬號通過Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'th-TH'	,	N'แจ้งผ่านTelegramของคุณเมื่อมีดาวน์ไลน์ใหม่ถูกตรวจสอบว่าเป็นบัญชีที่มีปัญหา'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'en-US'	,	N'Notify via your Telegram when a Member reaches their Win Loss Limit'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'zh-Hans'	,	N'当会员达到输赢限额通过Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'zh-Hant'	,	N'當會員達到輸贏限額通過Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'th-TH'	,	N'แจ้งผ่านTelegramของคุณเมื่อสมาชิกถึงขีดกำจัดชนะ/แพ้'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'en-US'	,	N'Notify via your Telegram when your account password is changed'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'zh-Hans'	,	N'当您帐户密码更改时，将通过Telegram通知您'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'zh-Hant'	,	N'當您帳戶密碼更改時，將通過Telegram通知您'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'th-TH'	,	N'แจ้งเตือนทางเทเลแกรมของคุณเมื่อรหัสผ่านบัญชีของคุณถูกเปลี่ยน'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'en-US'	,	N'Notify via your Telegram when your Security Code is changed'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'zh-Hans'	,	N'当您的保安码更改时通过Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'zh-Hant'	,	N'當您的保安碼更改時通過Telegram通知'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'th-TH'	,	N'แจ้งเตือนผ่านTelegramเมื่อรหัสความปลอดภัยของคุณมีการเปลี่ยนแปลง'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'en-US'	,	N'Notify via your Telegram when there is unrecognized login activity using your account'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'zh-Hans'	,	N'当您的代理账号存在无法识别的登录活动时，会通過Telegram通知。'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'zh-Hant'	,	N'當您的代理賬號存在無法識別的登錄活動時，會通過Telegram通知。'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'th-TH'	,	N'แจ้งเตือนผ่านTelegramของคุณเมื่อมีการเข้าสู่ระบบที่ไม่รู้จักโดยใช้บัญชีของคุณลงชื่อเข้าใช้งานในเว็บไซต์ตัวแทน'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'en-US'	,	N'Settings'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'zh-Hans'	,	N'设定'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'zh-Hant'	,	N'設定'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'th-TH'	,	N'ตั้งค่า'

--vi
UNION ALL SELECT 	'Action_Name'	,	'39'	,	'en-US'	,	N'Tiếng Việt'
UNION ALL SELECT 	'Action_Name'	,	'1'	,	'vi-VN'	,	N'Tiền chưa xử lý'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'vi-VN'	,	N'Tài Khoản'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'vi-VN'	,	N'Thắng thua trong ngày'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'vi-VN'	,	N'Thắng thua hôm qua'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'vi-VN'	,	N'50 Khoản Tiền Chờ Xử Lý Hàng Đầu'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'vi-VN'	,	N'Nhập tên người dùng cấp dưới'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'vi-VN'	,	N'X Khoản Tiền Chờ Xử Lý Hàng Đầu'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'vi-VN'	,	N'Vui lòng nhập tên người dùng cấp dưới để xem Báo Cáo Tiền Chờ Xử Lý.'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'vi-VN'	,	N'Bạn muốn xem bao nhiêu cấp dưới trong Báo Cáo Tiền Chưa Xử Lý?
Chatbot hỗ trợ thống kê đến 100 cấp dưới.'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'vi-VN'	,	N'Cài Đặt'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'vi-VN'	,	N'Báo Cáo Tài Khoản Của Tôi'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'vi-VN'	,	N'Nhập tên người dùng cấp dưới'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'vi-VN'	,	N'X Tài Khoản Hàng Đầu'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'vi-VN'	,	N'Vui lòng nhập tên người dùng cấp dưới để xem Báo Cáo Tài Khoản.'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'vi-VN'	,	N'Bạn muốn xem bao nhiêu cấp dưới trong Báo Cáo Tài Khoản?
Chatbot hỗ trợ thống kê đến 100 cấp dưới.'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'vi-VN'	,	N'Thắng Thua Trong Ngày Của Tôi'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'vi-VN'	,	N'Nhập tên người dùng cấp dưới'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'vi-VN'	,	N'Vui lòng nhập tên người dùng cấp dưới để xem Báo Cáo Thắng Thua Trong Ngày.'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'vi-VN'	,	N'Thắng Thua Hôm Qua Của Tôi'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'vi-VN'	,	N'Nhập tên người dùng cấp dưới'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'vi-VN'	,	N'Vui lòng nhập tên người dùng cấp dưới để xem Báo Cáo Thắng Thua Hôm Qua.'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'vi-VN'	,	N'Thông Báo'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'vi-VN'	,	N'Thắng thua hôm qua'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'vi-VN'	,	N'Tin nhắn cá nhân'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'vi-VN'	,	N'Tài Khoản Có Vấn Đề'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'vi-VN'	,	N'Giới Hạn Thắng Thua của Member'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'vi-VN'	,	N'Thông Báo Đổi Mật Khẩu'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'vi-VN'	,	N'Thông Báo Đổi Mã Bảo Mật'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'vi-VN'	,	N'Thông Báo Đăng Nhập Bất Thường'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'vi-VN'	,	N'Ngôn Ngữ'
UNION ALL SELECT 	'Action_Name'	,	'39'	,	'en-US'	,	N'Tiếng Việt'
UNION ALL SELECT 	'Action_Name'	,	'40'	,	'vi-VN'	,	N'Ngưng sử dụng Chatbot'
UNION ALL SELECT 	'Action_Description'	,	'1'	,	'vi-VN'	,	N'Mở Menu Tiền Chưa Xử Lý'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'vi-VN'	,	N'Mở Menu Báo Cáo Tài Khoản'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'vi-VN'	,	N'Mở Menu Báo Cáo Thắng Thua Trong Ngày'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'vi-VN'	,	N'Mở Menu Báo Cáo Thắng Thua Hôm Qua'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'vi-VN'	,	N'Xem Báo Cáo Tiền Chưa Xử Lý của 50 cấp dưới hàng đầu'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'vi-VN'	,	N'Xem Báo Cáo Tiền Chưa Xử Lý của một cấp dưới'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'vi-VN'	,	N'Xem Báo Cáo Tiền Chưa Xử Lý của # cấp dưới hàng đầu'
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'vi-VN'	,	N'Xem Báo Cáo Tài Khoản của bạn'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'vi-VN'	,	N'Xem Báo Cáo Tài Khoản của một cấp dưới'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'vi-VN'	,	N'Xem Báo Cáo Tài Khoản của # cấp dưới hàng đầu'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'vi-VN'	,	N'Xem Báo Cáo Thắng Thua Trong Ngày của bạn'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'vi-VN'	,	N'Xem Báo Cáo Thắng Thua Trong Ngày của một cấp dưới'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'vi-VN'	,	N'Xem Báo Cáo Thắng Thua Hôm Qua của bạn'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'vi-VN'	,	N'Xem Báo Cáo Thắng Thua Hôm Qua của một cấp dưới'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'vi-VN'	,	N'Tiền chưa xử lý'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'vi-VN'	,	N'Tài Khoản'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'vi-VN'	,	N'Thắng thua trong ngày'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'vi-VN'	,	N'Thắng thua hôm qua'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'vi-VN'	,	N'Thắng thua hôm qua'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'vi-VN'	,	N'Tin nhắn cá nhân'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'vi-VN'	,	N'Tài Khoản Có Vấn Đề'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'vi-VN'	,	N'Giới Hạn Thắng Thua của Member'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'vi-VN'	,	N'Thông Báo Đổi Mật Khẩu'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'vi-VN'	,	N'Thông Báo Đổi Mã Bảo Mật'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'vi-VN'	,	N'Thông Báo Đăng Nhập Bất Thường'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'vi-VN'	,	N'Cài Đặt'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'vi-VN'	,	N'Xem giá trị <b>"Tổng"</b> trong Báo Cáo Tiền Chờ Xử Lý của bạn và cấp dưới trực thuộc ở ngày hiện tại.'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'vi-VN'	,	N'Xem Báo Cáo Tài Khoản của bạn và cấp dưới trực thuộc'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'vi-VN'	,	N'Xem giá trị <b>"Tổng"</b> trong Báo Cáo Thắng Thua của bạn và cấp dưới trực thuộc ở ngày hiện tại.'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'vi-VN'	,	N'Xem giá trị <b>"Tổng"</b> trong Báo Cáo Thắng Thua của bạn và cấp dưới trực thuộc ở ngày hôm qua.'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'vi-VN'	,	N'Gửi giá trị <b>"Tổng"</b> trong Báo Cáo Thắng Thua Hôm Qua tới Telegram của bạn sau 2:00PM (GMT+8) hằng ngày.'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'vi-VN'	,	N'Gửi Tin Nhắn Cá Nhân tới Telegram của bạn.'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'vi-VN'	,	N'Thông báo trên Telegram khi có cấp dưới bị đánh dấu là Tài Khoản Có Vấn Đề.'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'vi-VN'	,	N'Thông báo trên Telegram khi Member đạt Giới Hạn Thắng Thua'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'vi-VN'	,	N'Thông báo trên Telegram khi mật khẩu của bạn bị thay đổi.'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'vi-VN'	,	N'Thông báo trên Telegram khi Mã Bảo Mật bị thay đổi.'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'vi-VN'	,	N'Thông báo trên Telegram khi có hoạt động đăng nhập bất thường vào tài khoản của bạn.'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'vi-VN'	,	N'Cài Đặt'
)
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)
SELECT ResourceName,ResourceKey,Language,Value
FROM T
GO


DELETE BotAction

;WITH T AS (
SELECT 	1	ActionID,	'Outstanding'	ActionName,	1	Type,	'/os'	Command,	1	FunctionID,	0	ParentID,	0	Status,	0 IsEndAction
UNION ALL SELECT 	2	,	'Balance Info'	,	1	,	'/bal'	,	2	,	0	,	0	,	0
UNION ALL SELECT 	3	,	'Today Win Loss'	,	1	,	'/wl'	,	3	,	0	,	0	,	0
UNION ALL SELECT 	4	,	'Yesterday Win Loss'	,	1	,	'/ywl'	,	4	,	0	,	0	,	0
UNION ALL SELECT 	5	,	'Top 50 Outstanding'	,	1	,	'50'	,	1	,	1	,	0	,	1
UNION ALL SELECT 	6	,	'Enter downline username'	,	1	,	'&lt;Username&gt;'	,	1	,	1	,	0	,	0
UNION ALL SELECT 	7	,	'Top Downlines'	,	3	,	NULL	,	1	,	1	,	0	,	1
UNION ALL SELECT 	8	,	'Top X Outstanding'	,	1	,	'&lt;#&gt;'	,	1	,	1	,	0	,	0
UNION ALL SELECT 	9	,	'Please enter your downline username to view Outstanding Report.'	,	2	,	NULL	,	1	,	6	,	0	,	1
UNION ALL SELECT 	10	,	'How many downlines would you like to include in Outstanding Report? Chatbot supports listing up to 100 downlines.'	,	2	,	NULL	,	1	,	8	,	0	,	1
UNION ALL SELECT 	11	,	'Settings'	,	1	,	'/settings'	,	12	,	0	,	0	,	0
UNION ALL SELECT 	12	,	'My Balance'	,	1	,	'm'	,	2	,	2	,	0	,	1
UNION ALL SELECT 	13	,	'Enter downline username'	,	1	,	'&lt;Username&gt;'	,	2	,	2	,	0	,	0
UNION ALL SELECT 	14	,	'Top Downlines'	,	3	,	NULL	,	2	,	2	,	0	,	1
UNION ALL SELECT 	15	,	'Top X Balance'	,	1	,	'&lt;#&gt;'	,	2	,	2	,	0	,	0
UNION ALL SELECT 	16	,	'Please enter your downline username to view Balance Report.'	,	2	,	NULL	,	2	,	13	,	0	,	1
UNION ALL SELECT 	17	,	'How many downlines would you like to include in Balance Report? Chatbot supports listing up to 100 downlines.'	,	2	,	NULL	,	2	,	15	,	0	,	1
UNION ALL SELECT 	18	,	'My Today Win Loss'	,	1	,	'm'	,	3	,	3	,	0	,	1
UNION ALL SELECT 	19	,	'Enter downline username'	,	1	,	'&lt;Username&gt;'	,	3	,	3	,	0	,	0
UNION ALL SELECT 	20	,	'Top Downlines'	,	3	,	NULL	,	3	,	3	,	0	,	1
UNION ALL SELECT 	21	,	'Please enter your downline username to view Today Win Loss Report.'	,	2	,	NULL	,	3	,	19	,	0	,	1
UNION ALL SELECT 	22	,	'My Yesterday Win Loss'	,	1	,	'm'	,	4	,	4	,	0	,	1
UNION ALL SELECT 	23	,	'Enter downline username'	,	1	,	'&lt;Username&gt;'	,	4	,	4	,	0	,	0
UNION ALL SELECT 	24	,	'Top Downlines'	,	3	,	NULL	,	4	,	4	,	0	,	1
UNION ALL SELECT 	25	,	'Please enter your downline username to view Yesterday Win Loss Report.'	,	2	,	NULL	,	4	,	23	,	0	,	1
UNION ALL SELECT 	26	,	'Notifications'	,	1	,	NULL	,	12	,	11	,	0	,	0
UNION ALL SELECT 	27	,	'Yesterday Win Loss'	,	1	,	'5'	,	5	,	26	,	0	,	1
UNION ALL SELECT 	28	,	'Personal Message'	,	1	,	'6'	,	6	,	26	,	0	,	1
UNION ALL SELECT 	29	,	'Problem Account'	,	1	,	'7'	,	7	,	26	,	0	,	1
UNION ALL SELECT 	30	,	'Member Win Loss Limit'	,	1	,	'8'	,	8	,	26	,	0	,	1
UNION ALL SELECT 	31	,	'Change Password Alert'	,	1	,	'9'	,	9	,	26	,	0	,	1
UNION ALL SELECT 	32	,	'Change Security Code Alert'	,	1	,	'10'	,	10	,	26	,	0	,	1
UNION ALL SELECT 	34	,	'Language'	,	1	,	NULL	,	12	,	11	,	0	,	0
UNION ALL SELECT 	35	,	'English'	,	1	,	'en-US'	,	12	,	34	,	0	,	1
UNION ALL SELECT 	36	,	'ChineseTraditional'	,	1	,	'zh-Hant'	,	12	,	34	,	0	,	1
UNION ALL SELECT 	37	,	'ChineseSimplified'	,	1	,	'zh-Hans'	,	12	,	34	,	0	,	1
UNION ALL SELECT 	38	,	'Thai'	,	1	,	'th-TH'	,	12	,	34	,	0	,	1
UNION ALL SELECT 	40	,	'Stop Using Chatbot'	,	1	,	'stop'	,	12	,	11	,	0	,	1

--vi @PRO
UNION ALL SELECT 	39	,	'Vietnamese'	,	1	,	'vi-VN'	,	12	,	34	,	0	,	1
)
INSERT INTO [dbo].[BotAction]
           ([ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction])
SELECT [ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction]
FROM T
GO