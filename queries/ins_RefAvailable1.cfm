<!--- called by Calendar.cfm --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cftry>		  
		<cfquery name = "InsertRefAvailable1" datasource="#request.DSN#">
			INSERT INTO
				refavailable  
				(RefereeID, MatchDate, Available,  LeagueCode)
				VALUES
				( '#form.RefereeID#' , '#ThisDate#' , '#ThisAvailability#' , '#ThisLeagueCodePrefix#' );
		</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
					<cfmodule template="../dberrorpage.cfm" 
						source="RefAvailable" errortype="duplicatekey" message="xxxxx">
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="RefAvailable" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<!--- find this inserted RefAvailable record --->
	<cfquery name="QRefAvailable" datasource="#request.DSN#" >
		SELECT 
			ID
		FROM 
			refavailable 
		WHERE 
			LeagueCode = <cfqueryparam value = '#ThisLeagueCodePrefix#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND RefereeID = <cfqueryparam value = #form.RefereeID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND MatchDate = <cfqueryparam value = '#ThisDate#'  cfsqltype="CF_SQL_DATE" >
	</cfquery>
	<cfset ThisRefAvailableID = #QRefAvailable.ID# >
		<!--- snapshot after --->
		<cfset AfterID = #QRefAvailable.ID# >
		<cfinclude template="qry_QRefAvailableAfter.cfm">
		<cfset ThisRefereeID = QRefAvailableAfter.RefereeID >
		<cfset ThisMatchDate = QRefAvailableAfter.MatchDate >
		<!--- check for any changes --->
		<cfloop index = "ListElement" list = "Available,Notes"> 
			<cfscript>
				ThisFieldName = "#ListElement#" ;
				BeforeValue = "" ;
				
				AfterValue = "QRefAvailableAfter.#ThisFieldName#" ;
				AfterValue = Evaluate(AfterValue);
				SecurityLevel = "#MID(request.SecurityLevel,4,1)#";
			</cfscript>
			<cfif BeforeValue IS NOT AfterValue >
				<cfinclude template="ins_RefAvailableUpdateLog.cfm">
			</cfif>
		</cfloop>
	</cfif>

