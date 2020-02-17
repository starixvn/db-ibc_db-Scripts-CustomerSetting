/*<info serverAlias="DBCUST-CUSTDB,DBACC-bodb02" selecters="bodbAdminNet,bodbDownlineNet" viewers="" isFunction="1"></info>*/
ALTER FUNCTION [dbo].[f_SetBinaryValues_2bytes] (@binStr VARBINARY(256), @xmlStr XML)   
RETURNS TABLE
AS  
/*
	Created: Eden@20200214
	DB: DBCust/custDB

	Revision:     
		- 20200214@eden: Initial SP [Redmine: #123750]
	Param's Explanation:   
		@xmlStr:   
			+ FORMAT: <root><r pos="" val="" /></root>  
			+ r: row  
			+ pos: Byte's position  
			+ val: new value
	Example: 
	declare @binaryStr VARBINARY(256) = 0x00050000000000000000
	,@xmlStr XML = '<root><r pos="2" val="100"/><r pos="40" val="35"/></root>'
	SELECT @binaryStr = binaryStr FROM dbo.[f_SetBinaryValues_2bytes](@binaryStr,@xmlStr)

	DECLARE @pos smallint = 2
	SELECT CONVERT(SMALLINT, SUBSTRING(@binaryStr, @pos * 2 - 1, 2))
*/  
RETURN(
	WITH PosValCTE AS (  
		SELECT T.C.value('./@pos', 'smallint') AS Pos,   
			CONVERT(VARCHAR(1000),CAST(T.C.value('./@val', 'smallint') AS BINARY(2)),2) AS Val,
			ROW_NUMBER() OVER (ORDER BY T.C.value('./@pos', 'smallint')) as RN
		FROM @XmlStr.nodes('/root/r') as [T](C) --T: table, C: column 
	)
	,tmp as(
		SELECT TOP 1 RN,
				CONVERT(binary(256),STUFF(CONVERT(varchar(1000),@binStr,2),(Pos-1)*4 + 1,4,Val),2) as binaryStr
		FROM PosValCTE
		UNION ALL 
		SELECT  c.RN,
				CONVERT(binary(256), STUFF(CONVERT(varchar(1000),tmp.binaryStr,2),(c.Pos-1)*4 + 1,4,c.Val),2)
		FROM tmp
			INNER JOIN PosValCTE c ON tmp.RN = c.RN - 1
	)
	SELECT TOP 1 binaryStr AS binaryStr_new FROM tmp ORDER BY RN DESC
)
GO