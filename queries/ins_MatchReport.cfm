<!--- called by InclInsrtLookUp.cfm --->
		  
<cfquery name="InsrtMatchReport" datasource="#request.DSN#" >
	INSERT INTO 
		matchreport 
			(LongCol, MediumCol, ShortCol, Notes, LeagueCode) 
		VALUES 
		('#LongCol#', '#MediumCol#', #ShortCol#, '#Notes#', 
			<cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
