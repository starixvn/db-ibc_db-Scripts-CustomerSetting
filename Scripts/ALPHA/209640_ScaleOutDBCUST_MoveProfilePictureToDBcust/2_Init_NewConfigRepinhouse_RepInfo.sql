/*<info serverAlias="DBAGE-bodb02, DBTP-bodb02"></info>*/
/*
	Created by: @Helios
	Date: 21/08/2024
	Task: Scale Out DBCUST - Move CustProfilePicture and ProfilePicture to DBcust - Migrate Data [Redmine:#209640]	
	DB: DBAGE-bodb02, DBTP-bodb02
*/

DECLARE 
	  @Group INT = 1
	, @Active  BIT = 0


INSERT INTO RepInfo 
	(
		[group]
	    , [name]
	    , active
	    , version_key
	    , version_type
	    , unique_key
	    , get_sp
	    , put_sp
	    , interval
	    , back_fix
	    , delayed_fix
	)
SELECT
		@Group AS [group]
	    , [name]
	    , @Active AS active
	    , version_key
	    , version_type
	    , unique_key
	    , get_sp
	    , put_sp
	    , interval
	    , back_fix
	    , delayed_fix
FROM RepInfo WITH (NOLOCK)
WHERE [name] IN ('CustProfilePicture' , 'ProfilePicture')
AND [group] = 0