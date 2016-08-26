<!--- called by InclInsrtLookUp.cfm --->
<!--- this excludes player, matchreport  which have their own inserts --->		  

<cfquery name="InsrtLookUpTblName" datasource="#request.DSN#" >
	INSERT INTO #LCase(TblName)# 
	(LongCol, MediumCol, ShortCol, Notes, LeagueCode) 
	VALUES ('#LongCol#', '#MediumCol#', '#ShortCol#', '#Notes#', 
			<cfqueryparam value = '#request.filter#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
	