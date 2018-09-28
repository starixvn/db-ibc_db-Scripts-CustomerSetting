/*
	Created: Vicky
	Task: create execrep fn
	DB: DBPRO/bodb02,DBTXN/bodb02, 
	Date: 20180912
*/
USE [bodb02]
GO

-------------------------------------------------------------SP NAP_Admin_Calculate_9001
CREATE PROCEDURE [dbo].[NAP_Admin_Calculate_9001]
    @transIds           VARCHAR(MAX)
AS
BEGIN
	SELECT 1
END 
	
-------------------------------------------------------------SP NAP_Admin_Calculate_Refund_9001	
ALTER PROCEDURE [dbo].[NAP_Admin_Calculate_Refund_9001]
	@transIds					VARCHAR(MAX)	 = NULL

AS
BEGIN
	SELECT 1
END 


-------------------------------------------------------------SP NAP_Admin_Calculate_Undo_9001
ALTER PROCEDURE [dbo].[NAP_Admin_Calculate_Undo_9001]
	@transIds      		VARCHAR(MAX)
AS
BEGIN
	SELECT 1
END 
	