/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220930
    Task: Restore data customer for member custid = 41193977, username: DawooRMB01182965  [#176624]
    DB: DBCUST/CustDB
*/ 
DECLARE @CustID int = 41193977,
	@ErrCode int = 0,    
	@ErrMsg nvarchar(2000) = ''   
DECLARE @currency int,    
	 @recommend int,    
	 @mrecommend int,    
	 @srecommend int,     
	 @agusername varchar(30),    
	 @site varchar(30),    
	    
	 @pwdexpiry datetime,    
	 @ugroup varchar(5),
	    
	 @Aclosed bit,     
	 @Asuspended bit,      
	 @suspended bit = 0,    
	 @matchlimit smallmoney,    
	 @virtualmultiplier smallmoney    
	    
	--Init param    
	select @pwdexpiry = dateadd(dd, 30, getdate())  

	---------------------------------
	--20181011@Kean: Support for reactivation of member
	DECLARE @FirstName nvarchar(50),    
			@LastName nvarchar(50),    
			@Email nvarchar(50),    
			@username2 varchar(50),    
			@refcode2 nvarchar(50),    
			@Password varchar(40),
			@AgentID int,
			@Country nvarchar(50),
			@Username varchar(50) ='',
			@phone nvarchar(50),
			@mobilephone nvarchar(50),
			@fax nvarchar(50),
			@address nvarchar(50),
			@city nvarchar(50),   
			@state nvarchar(50),
			@postal nvarchar(50),
			@birthday smalldatetime,
			@refcode1	nvarchar(50),
			@remark nvarchar(50),
			@createDate smalldatetime,
			-- Use for reinit old balance
			@CustIDBalanceDummy INT,
			@ClosingBalance MONEY

	SELECT @FirstName = firstname,
				@Lastname = lastname,
				@Username = username,
				@Password = userpwd,
				@pwdexpiry = pwdexpiry,
				@phone = phone,
				@mobilephone = mobilephone,
				@Email = email,
				@fax = fax,
				@address = address,
				@city = city,
				@state = state,
				@Country = country,
				@postal = postal,
				@birthday = birthday,
				@refcode1 = refcode1,
				@remark = remark,
				@createDate = creatdate,
				@username2 = username2,
				@refcode2 = refcode2,
				@AgentID = recommend
	 FROM DBARCCUST.Bodb_Archive_Customer_Licensee.dbo.Customer WITH(NOLOCK)
	 WHERE custid = @CustID
	---------------------------------
	    
	select    
	 @srecommend = ci.srecommend,    
	 @mrecommend = ci.mrecommend,     
	 @recommend = ci.custID,    
	 @agusername = ci.username,    
	 @currency = ci.currency,     
	 ----- add more    
	 @site    = c.site,       
	 @Aclosed   = closed,    
	 @Asuspended   = reject,    
	 @matchlimit   = matchlimit,    
	 @virtualmultiplier = virtualmultiplier
	FROM custinfo ci WITH(NOLOCK)     
	 inner join customer c WITH(NOLOCK) ON ci.custid = c.custid    
	WHERE ci.CustID = @AgentID    
	 and ci.roleid = 2    
	    
	--20110426@Thien: rollback for DELA, set to group A again    
	SELECT @ugroup = 'a'    

	IF EXISTS (SELECT TOP 1 1 FROM Dep_DefaultOddGroup WITH(NOLOCK) WHERE AgentID=@AgentID AND IsActive=1)
		SELECT @ugroup = Ugroup FROM Dep_DefaultOddGroup WITH(NOLOCK) WHERE AgentID=@AgentID AND IsActive=1

	--check suspended of Agent     
	if @Asuspended =1 
	BEGIN    
	 set @suspended =1    
	END    
	-----------------------------------------------    
	--reset the @site param    
	select @site=case when @ugroup like 'indo_' then 'INDO' else '' end,    
	 @ugroup = case when @ugroup like 'indo_' then right(@ugroup,1) else @ugroup end    
	
	IF EXISTS(SELECT 1 FROM customer (NOLOCK) WHERE custid = @CustID)
		OR ISNULL(@Username,'') = ''  OR @recommend is null    
	BEGIN
		SELECT ErrMsg = 'Cannot insert'
			,ErrCode = 101
			,@Username AS Username, @recommend as AgentID
		RETURN
	END   

	SELECT		custid=				@custid,
				firstname=			@firstname,
				lastname=			@lastname,
				creator=			@recommend,
				username=			@username,
				userpwd=			@Password,
				pwdexpiry=			@pwdexpiry,
				currency=			@currency,
				site=				@site,
				ugroup=				@ugroup,
				createDate=			@createDate,
				birthday=			@birthday,
				refcode1=			@refcode1,
				remark=				@remark,
				refcode2=			@refcode2,
				username2=			@username2,
				srecommend=			@srecommend,
				mrecommend=			@mrecommend,
				recommend=			@recommend,
				roleid=				1,
				phone=				@phone,
				mobilephone=		@mobilephone,
				email=				@email,
				fax=				@fax,
				address=			@address,
				city=				@city,
				state=				@state,
				country=			@country,
				postal=				@postal


	EXEC Dep_Customer_Archive_InsCustomer_WithCustID 
				@custid=@custid,
				@firstname=@firstname,
				@lastname=@lastname,
				@creator=@recommend,
				@username=@username,
				@userpwd=@Password,
				@pwdexpiry=@pwdexpiry,
				@currency=@currency,
				@site=@site,
				@ugroup=@ugroup,
				@createDate=@createDate,
				@birthday=@birthday,
				@refcode1=@refcode1,
				@remark=@remark,
				@refcode2=@refcode2,
				@username2=@username2,
				@srecommend=@srecommend,
				@mrecommend=@mrecommend,
				@recommend=@recommend,
				@roleid=1,
				@phone=@phone,
				@mobilephone=@mobilephone,
				@email=@email,
				@fax=@fax,
				@address=@address,
				@city=@city,
				@state=@state,
				@country=@country,
				@postal=@postal,
				@ErrCode = @ErrCode OUTPUT,    
				@ErrMsg = @ErrMsg OUTPUT
	
    IF @ErrCode <> 0
    BEGIN
		    SELECT ErrCode = @ErrCode, ErrMsg = @ErrMsg
			RETURN
    END

	IF NOT EXISTS( SELECT 1 FROM CustVirtualSetting WITH(NOLOCK) WHERE custid = @CustID)  
		INSERT INTO [dbo].[CustVirtualSetting] (custid, seqNo, bitmapVirtual)
		SELECT @Custid, seqNo, bitmapVirtual
		FROM CustVirtualSetting WITH(NOLOCK)
		WHERE custid = @recommend  