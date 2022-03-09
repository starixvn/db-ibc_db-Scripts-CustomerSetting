/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220309@Elodie
	Task: Enable Cash Out for licensees
	DB: DBCust/CustDB
*/
DECLARE @ErrMsg VARCHAR(100), @CustID INT
--Cash Out --// ProductID = 25  SELECT ci.custid, 0 AS IsFinished INTO #SuperListFROM Dep_CustSuper ds WITH (NOLOCK)	INNER JOIN bodb_Licensee.dbo.Licensees l WITH (NOLOCK) on l.LicenseeName = ds.site and l.IsActive = 1	INNER JOIN custInfo ci WITH (NOLOCK) ON ds.custid = ci.custid	LEFT JOIN Dep_SupperProductSetting cs WITH (NOLOCK) ON cs.custid = ci.custidWHERE cs.CustID IS NULL 	AND ds.site IN (					'Betway'					,'GLive'					,'GoldenFCV'					,'JBO'					,'kbosportCV'					,'kgsports'					,'LEGaming'					,'SWDemo'					,'Test0112'					,'WSlots'					,'XLMEDIA'					,'YSYBO688CV'					,'yuanbaoCV'					,'ZhiFeng200')
WHILE (1=1)
BEGIN
	UPDATE TOP (1) s
	SET IsFinished = 1, @CustID = custid
	FROM #SuperList s
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0 BREAK

	EXEC Acc_3rdProductUpdSuperStatus @ProductID=25,@CustID=@CustID,@IsEnable=1,@ApplyToMember=1,@UserID=10278938,@IP = '10.3.11.200',@Langkey=default,@ErrMsg=@ErrMsg OUTPUT
	SELECT @ErrMsg
END

DROP TABLE #SuperList