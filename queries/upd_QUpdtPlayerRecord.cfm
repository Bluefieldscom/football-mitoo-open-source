<!--- called by Action.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>

<!--- added Feb 2012 to delete any playerduplicatenowarnings rows associated with this update --->
<cfquery name="DelPDNWRecord" datasource="#request.DSN#" >
	DELETE FROM 
		playerduplicatenowarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RegNo1 = <cfqueryparam value = #Form.ShortCol# cfsqltype="CF_SQL_INTEGER" maxlength="10">
</cfquery>
<cfquery name="DelPDNWRecord" datasource="#request.DSN#" >
	DELETE FROM 
		playerduplicatenowarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RegNo2 = <cfqueryparam value = #Form.ShortCol# cfsqltype="CF_SQL_INTEGER" maxlength="10">
</cfquery>
<cftry>
	<cfquery name="QUpdtPlayerRecord" datasource="#request.DSN#" result="QUpdtPlayerRecord_result">
		UPDATE
			player
		SET 
			<cfif TRIM(Form.FAN) IS "">
				FAN = NULL,
			<cfelse>
				FAN = <cfqueryparam value = #Form.FAN# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			</cfif>
		
			Surname = <cfqueryparam value = '#Form.Surname#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="20">, 
			Forename = <cfqueryparam value = '#Form.Forename#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="35">, 						
<!---			LongCol = <cfqueryparam value = '#Form.LongCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
			MediumCol = <cfqueryparam value = '#Form.MediumCol#' 
							cfsqltype="CF_SQL_DATE">,
			ShortCol = <cfqueryparam value = #Form.ShortCol# 
						cfsqltype="CF_SQL_INTEGER" maxlength="10">,
			<cfif TRIM(Form.Notes) IS "">
				Notes = NULL,
			<cfelse>
				Notes = <cfqueryparam value = '#Form.Notes#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="225">,
			</cfif>
				AddressLine1 = <cfqueryparam value = '#Trim(Form.AddressLine1)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40">,
				AddressLine2 = <cfqueryparam value = '#Trim(Form.AddressLine2)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40">,
				AddressLine3 = <cfqueryparam value = '#Trim(Form.AddressLine3)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40">,
				Postcode = <cfqueryparam value = '#Trim(Form.Postcode)#' cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
				Email1 = <cfqueryparam value = '#Trim(Form.Email1)#' cfsqltype="CF_SQL_VARCHAR" maxlength="80">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #Form.ID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<cfif cfcatch.detail contains "key 3">
				<!--- duplicate values on Leaguecode,LongCol(Name),MediumCol(DOB) - Check2 --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="namedob">
				<cfelse>
				<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="indexno">
				</cfif>
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Player" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>
	
			
			
			
<cfelse>

<!--- added Feb 2012 to delete any playerduplicatenowarnings rows associated with this update --->
<cfquery name="DelPDNWRecord" datasource="#request.DSN#" >
	DELETE FROM 
		playerduplicatenowarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RegNo1 = <cfqueryparam value = #Form.ShortCol# cfsqltype="CF_SQL_INTEGER" maxlength="10">
</cfquery>
<cfquery name="DelPDNWRecord" datasource="#request.DSN#" >
	DELETE FROM 
		playerduplicatenowarnings 
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND RegNo2 = <cfqueryparam value = #Form.ShortCol# cfsqltype="CF_SQL_INTEGER" maxlength="10">
</cfquery>
<cftry>
	<cfquery name="QUpdtPlayerRecord" datasource="#request.DSN#" result="QUpdtPlayerRecord_result">
		UPDATE
			player
		SET 
			<cfif TRIM(Form.FAN) IS "">
				FAN = NULL,
			<cfelse>
				FAN = <cfqueryparam value = #Form.FAN# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			</cfif>
		
			Surname = <cfqueryparam value = '#Form.Surname#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="20">, 
			Forename = <cfqueryparam value = '#Form.Forename#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="35">, 						
<!---			LongCol = <cfqueryparam value = '#Form.LongCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
			MediumCol = <cfqueryparam value = '#Form.MediumCol#' 
							cfsqltype="CF_SQL_DATE">,
			ShortCol = <cfqueryparam value = #Form.ShortCol# 
						cfsqltype="CF_SQL_INTEGER" maxlength="10">,
			<cfif TRIM(Form.Notes) IS "">
				Notes = NULL
			<cfelse>
				Notes = <cfqueryparam value = '#Form.Notes#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="225">
			</cfif>
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #Form.ID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<cfif cfcatch.detail contains "key 3">
				<!--- duplicate values on Leaguecode,LongCol(Name),MediumCol(DOB) - Check2 --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="namedob">
				<cfelse>
				<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="indexno">
				</cfif>
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Player" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>
			
</cfif>







