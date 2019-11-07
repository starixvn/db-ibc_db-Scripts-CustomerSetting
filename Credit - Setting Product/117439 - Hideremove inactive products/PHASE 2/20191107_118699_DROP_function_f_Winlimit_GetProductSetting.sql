/*	
	Created: 20191107@Eden
	Task: DROP function f_Winlimit_GetProductSetting
	Redmine: https://nexdev.net/issues/118699
	DB: DBTXN/bodb02
	Note : Run this script before deploy package SPs
		IF envỉontment = PRODUCT ( release) Please DROP FUNCTION f_Winlimit_GetProductSetting
		   ELSE DROP FUNCTION f_Winlimit_GetProductSetting_UAT4
*/
USE bodb02
GO
DROP FUNCTION f_Winlimit_GetProductSetting_UAT4 -- f_Winlimit_GetProductSetting