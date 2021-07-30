/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210413@Tina
	Task: insert new message [redmine: #148600]
	DB: DBCUST.custDB
*/

USE [CustDB]
GO

UPDATE MsgError 
SET MsgNameEN = N'Your account has been locked due to multiple failed security check. Please contact your upline to unlock.', 
	MsgNameCS = N'由于检测多次失败，导致此账号已被锁定。请联系您的上线以解锁。', --Chinese Simplified (zh-CN)
	MsgNameCT = N'由於檢測多次失敗，導致此賬號已被鎖定。請聯繫您的上線以解鎖。', --Chinese Traditional (zh-TW)
	MsgNameTH = N'บัญชีนี้ถูกล็อก เนื่องจากการตรวจสอบความปลอดภัยล้มเหลวหลายครั้ง กรุณาติดต่ออัพไลน์ของคุณเพื่อปลดล็อก' --Thai
WHERE MsgID IN (80007, 40045)