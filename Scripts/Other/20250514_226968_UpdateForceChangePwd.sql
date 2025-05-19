/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Elodie
	Date: 14/05/2025
	Task: Update force change password [Redmine:#226968]	
	DB: DBCUST/CustDB
*/
USE CustDB
GO
    DECLARE  @PwdExpiry DATETIME
			,@OldPwd	VARCHAR(40), @UserPwd VARCHAR(40)
	/*
	SELECT custid INTO #tmpCust
	FROM Customer (NOLOCK)
	WHERE custid in (44146288
					,27238645
					,47937957
					,6554610
					,46392640
					,38047105
					,10516252
					,49244386
					,47626448
					,151056478
					,7970127
					,65806585
					,26287921
					,1732467
					,15622880
					,29864864
					,16286970
					,48154989
					,47953742
					,15616454
					,47100170
					,52109701
					,51823724
					,5411193
					,33939550
					,15237020
					,47117577
					,4913294
					,8461041
					,46863316
					,45568336
					,8164249
					,53855351
					,47785291
					,46416439
					,3529795
					,35982427
					,7317532
					,6652095
					,3334429
					,14846351
					,52024531
					,16109648
					,128527445
					,165491878
					,162845500
					,132110501
					,145090037
					,48233189
					,20710808
					,1554988
					,53909296
					,46096543
					,1670304
					,4911222
					,46978144
					,47247213
					,72303815
					,1875848
					,4347396
					,46033205
					,813887
					,1032845
					,31831864
					,45570710
					,42905234
					,45454395
					,50497058
					,48185600
					,49006219)
	*/

	SELECT custid INTO #tmpCust
	FROM Customer (NOLOCK)
	WHERE custid in (23994603)

	SELECT	@OldPwd	= userpwd, @pwdexpiry = DATEADD(dd, -1, GETDATE())
	FROM	Customer WITH (NOLOCK) 
	WHERE	custid = 44146288

	SELECT	@UserPwd = userpwd -- D548BE72744688482D84C7677A2A88
	FROM	Customer WITH (NOLOCK) 
	WHERE	custid = 28205847

    UPDATE  customer WITH (ROWLOCK, UPDLOCK)
    SET     userpwd = @UserPwd ,
            pwdexpiry = @PwdExpiry,
			RepUpdateTime = dbo.f_GetDateTime2()
    WHERE   custid IN (SELECT custid FROM #tmpCust)
    
	UPDATE	CustLoginInfo_Member WITH (ROWLOCK, UPDLOCK)
	SET	gesture = NULL
	   ,RepUpdateTime = dbo.f_GetDateTime2()
		,OldUserPwd			=	@OldPwd
		,LastChangedPwdDate	=	GETDATE()
	WHERE	custid IN (SELECT custid FROM #tmpCust)
	