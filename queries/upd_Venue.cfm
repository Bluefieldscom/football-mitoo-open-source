<!--- called by Action.cfm --->

<cfquery name="QUpdtVenueRecord" datasource="#request.DSN#" >
	UPDATE
		venue 
	SET 
		LongCol = <cfqueryparam value = '#Form.LongCol#' cfsqltype="CF_SQL_VARCHAR" maxlength="50">, 
		MediumCol = <cfqueryparam value = '#Form.MediumCol#' cfsqltype="CF_SQL_VARCHAR" maxlength="25">, 
		ShortCol = <cfqueryparam value = '#TRIM(Form.ShortCol)#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="15">,
		<cfif Form.Notes IS "">
			Notes = NULL ,
		<cfelse>
			Notes = '#TRIM(Form.Notes)#' ,
		</cfif>
		AddressLine1 = '#TRIM(Form.AddressLine1)#',
		AddressLine2 = '#TRIM(Form.AddressLine2)#',
		AddressLine3 = '#TRIM(Form.AddressLine3)#',
		PostCode = '#TRIM(Form.PostCode)#',
		VenueTel = '#TRIM(Form.VenueTel)#',
		MapURL = '#TRIM(Form.MapURL)#',
		CompassPoint = #Form.CompassPoint#
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>


