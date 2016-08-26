<!--- called by InclInsrtLookUp.cfm --->
<cfquery name="InsrtLookUpTblName" datasource="#request.DSN#" >
	INSERT INTO venue 
	(LongCol, MediumCol, ShortCol, Notes, LeagueCode,
	AddressLine1,
	AddressLine2,
	AddressLine3,
	PostCode,
	VenueTel,
	MapURL,
	CompassPoint
	) 
	VALUES ('#Trim(LongCol)#', '#Trim(MediumCol)#', '#ShortCol#', '#Notes#', 
			<cfqueryparam value = '#request.filter#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
			'#Trim(AddressLine1)#',
			'#Trim(AddressLine2)#',
			'#Trim(AddressLine3)#',
			'#Trim(PostCode)#',
			'#Trim(VenueTel)#',
			'#Trim(MapURL)#',
			#CompassPoint#
			 )
</cfquery>



