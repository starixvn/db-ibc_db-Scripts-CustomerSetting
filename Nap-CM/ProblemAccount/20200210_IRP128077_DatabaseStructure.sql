/*
	Created: 20200210@Johnson	
	Task: Prepare structure for problem account for deposit	
*/
--step 1: run this script at DBCUST/bodb_Licensee 
--add new column into  table Licensees
USE bodb_Licensee
GO

ALTER TABLE Licensees ADD IsAcknowledgement BIT NULL
GO

--Step 2: run this script at @DBCUST/CustDB & DBACC/bodb02
--Then add table Dep_CustVIP into replication pub CustDB_CustSetting

--script create table Dep_CustVIP
CREATE TABLE Dep_CustVIP (
	CustID INT NOT NULL,
	ModifiedDate DATETIME NULL,
	UserID INT NULL
CONSTRAINT [PK_Dep_CustVIP] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [table_customer]
) ON [table_customer]
GO

--add new column to mark player has void tickets
--deploy this script on DBCUST/CustDB only
ALTER TABLE ProblemAccount ADD isMarkVoid BIT NULL DEFAULT 0
GO

--Step 3: Run this script @DBLOG/bodb_CustomerLog
--add log action

USE bodb_CustomerLog
GO
INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 31624,6,'NAP_ProblemAccount_LicenseeAcknowledgementUpd',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement',1,N'Update Licensee Acknowledgement',N'Update Licensee Acknowledgement'
UNION ALL SELECT 31625,6,'Lrf_ProblemAccount_LicenseeVipPlayerUpd',N'Update Vip status for deposit member',N'Update Vip status for deposit member',N'Update Vip status for deposit member',N'Update Vip status for deposit member',N'Update Vip status for deposit member',N'Update Vip status for deposit member',N'Update Vip status for deposit member',1,N'Update Vip status for deposit member',N'Update Vip status for deposit member'
UNION ALL SELECT 31626,6,'NAP_ProblemAccount_LicenseeAddCustomer',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member',1,N'Mark New Problem Account for deposit member',N'Mark New Problem Account for deposit member'
UNION ALL SELECT 31627,6,'NAP_ProblemAccount_LicenseeRemoveCustomer',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member',1,N'Unmark Problem Account for deposit member',N'Unmark Problem Account for deposit member'
UNION ALL SELECT 31628,6,'NAP_ProblemAccount_LicenseeInformStatusUpd',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',N'Update Informing Status for deposit member',1,N'Update Informing Status for deposit member',N'Update Informing Status for deposit member'
UNION ALL SELECT 31629,6,'NAP_ProblemAccount_LicenseeReduceBetLimit',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member',1,N'Reduce Bet Limit for deposit member',N'Reduce Bet Limit for deposit member'
UNION ALL SELECT 31630,6,'NAP_ProblemAccount_LicenseeRemoveReduceBetLimit',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member',1,N'Remove Reduced Bet Limit for deposit member',N'Remove Reduced Bet Limit for deposit member'
UNION ALL SELECT 31631,6,'NAP_ProblemAccount_LicenseePreventiveActionUpd',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member',1,N'Update Preventive Action for deposit member',N'Update Preventive Action for deposit member'
		   
		   




