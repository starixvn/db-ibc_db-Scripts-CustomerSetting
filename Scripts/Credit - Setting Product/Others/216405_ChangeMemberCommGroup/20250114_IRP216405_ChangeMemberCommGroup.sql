/*<info serverAlias="DBCUST-CustDB"></info>*/
 /*
	Created: 20250114@Johnson
	Task: Customer Setting - Allow Agents to change member Comm group [redmine: #216405]
	DB: DBCust/CustDB	
 */
 
DECLARE @MsgNameEN NVARCHAR(1000) = N'Unable to assign this commission group to the member.' 

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN]
           ,[MsgNameIN]
           )
SELECT 12,1,@MsgNameEN, N'無法將此佣金組別分配給會員。',N'无法将此佣金组别分配给会员。',N'このコミッショングループをメンバーに割り当てることができません。',N'ไม่สามารถกำหนดกลุ่มคอมมิชชั่นนี้ให้กับสมาชิกได้'
	,@MsgNameEN	,@MsgNameEN , N'Không thể gán nhóm hoa hồng này cho Member.', 1, @MsgNameEN, @MsgNameEN