/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 218182@Gina
	Task: CWL - Funky Games - Integrate New Product [Redmine: #218182]
	Database:	DBCUST/CustDB
	Description: Update GroupName of  Funky Games(old)
*/

USE CustDB
GO
DECLARE @OldProductID TINYINT = 50,@NewProductID TINYINT = 104
DECLARE @OldGroupID TINYINT, @NewGroupName VARCHAR(200), @OldGroupName VARCHAR(200);	


SELECT @OldGroupName = ProductName
FROM dbo.Products p WITH (NOLOCK)
WHERE p.ProductID = @OldProductID

SELECT @NewGroupName = ProductName
FROM dbo.Products p WITH (NOLOCK)
WHERE p.ProductID = @NewProductID

SELECT @OldGroupID = GroupID
FROM Winlimit_Group WITH (NOLOCK)
WHERE GroupName = @NewGroupName

IF EXISTS (
	SELECT TOP 1 1
	FROM Winlimit_Group WITH (NOLOCK)
	WHERE GroupName = @NewGroupName 
		AND GroupID = @OldGroupID
)
BEGIN
	UPDATE g 
	SET g.GroupName = @OldGroupName
	FROM Winlimit_Group g WITH (ROWLOCK, UPDLOCK)
	WHERE GroupName= @NewGroupName and 
		 GroupID = @OldGroupID
END
