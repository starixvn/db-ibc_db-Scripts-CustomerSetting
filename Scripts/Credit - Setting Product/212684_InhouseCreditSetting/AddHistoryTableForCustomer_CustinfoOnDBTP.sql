/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 2024114@Johnson
	Task: Add triggers for credit history tables [redmine: #212684]
	DB: DBCUST-CUSTDB
*/ 
----------------------------------------------------------------
--custInfo
CREATE TRIGGER [dbo].[CustInfo_update] ON [dbo].[custInfo]
AFTER UPDATE
AS
/*
	Created by: 2024114@Johnson
	Task: Trigger for updating [custInfo] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]

*/
BEGIN 
	SET NOCOUNT ON
	
	INSERT INTO CustDB_History.dbo.CustInfo_history (
        username
        ,custid
        ,currency
        ,roleid
        ,srecommend
        ,mrecommend
        ,recommend
        ,dangercust
        ,autosuspend
        ,reject
        ,credit
        ,closed
        ,MatchLimit
        ,VirtualMultiplier
        ,[Enabled]
        ,danger     
        ,danger2
        ,danger3
        ,DisableOutright            
        ,Abnormal
        ,DoubleCommLosing       
        ,autosuspend2       
        ,DisableEsports
        ,DisableSuperLive
        ,LockUpd
        ,BonusWalletFlag
        ,DangerLevel
        ,CustomerClass
        ,danger4
        ,danger5
        ,CCSoccer
        ,CCBasketball
        ,CCEsports
        ,CCOtherSports
        ,CCNonSports
        ,autosuspend3
        )
    SELECT username
        ,custid
        ,currency
        ,roleid
        ,srecommend
        ,mrecommend
        ,recommend
        ,dangercust
        ,autosuspend
        ,reject
        ,credit
        ,closed
        ,MatchLimit
        ,VirtualMultiplier
        ,[Enabled]
        ,danger 
        ,danger2
        ,danger3
        ,DisableOutright
        ,Abnormal
        ,DoubleCommLosing
        ,autosuspend2
        ,DisableEsports
        ,DisableSuperLive
        ,LockUpd
        ,BonusWalletFlag
        ,DangerLevel
        ,CustomerClass
        ,danger4
        ,danger5
        ,CCSoccer
        ,CCBasketball
        ,CCEsports
        ,CCOtherSports
        ,CCNonSports
        ,autosuspend3
    FROM [DELETED]
END	
GO

----------------------------------------------------------------
--customer
CREATE TRIGGER [dbo].[trg_Customer_update] ON [dbo].[Customer]
AFTER UPDATE
AS
/*  
	Created by: 2024114@Johnson
	Task: Trigger for updating [Customer] table
	DB: DBCUST/CUSTDB
	
	Revisions: 
        - 2024114@Johnson: Apply In-house Replication for Credit Customer Setting [redmine:#212684]
*/
BEGIN
	SET NOCOUNT ON
	 

	INSERT INTO CustDB_History.dbo.Customer_history (
	custid
	,firstname
	,lastname
	,address
	,postal
	,city
	,STATE
	,country
	,phone
	,mobilephone
	,fax
	,email
	,birthday
	,refcode1
	,refcode2
	,remark
	,creatdate
	,creator
	,username
	,currency
	,userpwd
	,lastlogged
	,pwdexpiry
	,roleid
	,mrecommend
	,recommend
	,ugroup
	,logincount
	,on_sessionid
	,site
	,iplogin
	,important
	,srecommend
	,username2
		)
	SELECT d.custid
	,d.firstname
	,d.lastname
	,d.address
	,d.postal
	,d.city
	,d.STATE
	,d.country
	,d.phone
	,d.mobilephone
	,d.fax
	,d.email
	,d.birthday
	,d.refcode1
	,d.refcode2
	,d.remark
	,d.creatdate
	,d.creator
	,d.username
	,d.currency
	,d.userpwd
	,d.lastlogged
	,d.pwdexpiry
	,d.roleid
	,d.mrecommend
	,d.recommend
	,d.ugroup
	,d.logincount
	,d.on_sessionid
	,d.site
	,d.iplogin
	,d.important
	,d.srecommend
	,d.username2
	FROM [DELETED] d
		inner join inserted I on i.custid = d.custid
	WHERE d.lastlogged = i.lastlogged  --- no need to record changes are made on lastlogged column
END
GO