/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20240321
	Task: NAP - Virtual rate - For Direct account :Change default of VR Status for newly created accounts to "Follow upline" [#202624]
	DB: DBCUST/CustDB
*/

DECLARE @CustList TABLE (CustId INT)

INSERT INTO @CustList(CustId)
	select ci.custid 
	from custinfo ci with (NOLOCK)
		INNER JOIN CustSuper s (NOLOCK) ON ci.srecommend = s.custid
	where VirtualMultiplier = 0
		AND roleid IN (1,2,3,4)
		AND s.IsInternal = 0

UPDATE c
SET c.VirtualMultiplier = 1
FROM custInfo c WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @CustList l ON c.custid = l.CustId

;WITH _CTE AS
(
	SELECT custid, seqNo, virtualBitmap
	FROM @CustList 
	CROSS APPLY (VALUES(1, 0x64646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464),
							(2,0x64646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464),
							(3,0x64646464646400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
							) t(seqNo, virtualBitmap)
)
UPDATE cvs
SET cvs.bitmapVirtual = c.virtualBitmap
FROM CustVirtualSetting cvs WITH (ROWLOCK, UPDLOCK) 
	INNER JOIN _CTE c ON c.CustId = cvs.custid AND c.seqNo = cvs.seqNo
