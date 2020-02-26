/*
	Created: 20200226@Johnson	
	Task: Add log action for problem account for deposit
	DB: DBLOG/bodb_CustomerLog
*/

--Run this script @DBLOG/bodb_CustomerLog
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
UNION ALL SELECT 31631,6,'NAP_ProblemAccount_LicenseeAccountReasonUpd',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',N'Update Problem Account for deposit member',1,N'Update Problem Account for deposit member',N'Update Problem Account for deposit member'
UNION ALL SELECT 31632,6,'CS_ProblemAccount_AddAbnormalMember',N'Mark New Problem Account by Voiding Bet' ,N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet',1,N'Mark New Problem Account by Voiding Bet',N'Mark New Problem Account by Voiding Bet'
UNION ALL SELECT 31633,6,'CS_ProblemAccount_AddAbnormalMember',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member',1,N'Unset VIP Status for deposit member',N'Unset VIP Status for deposit member'

