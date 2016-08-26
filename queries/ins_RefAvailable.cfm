<!--- called by RefAvailableAdd.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.DSN,4) GE 2012 AND ListFind("Yellow",request.SecurityLevel)>
	<!--------
	<cflock scope="session" timeout="10" type="readonly">
		<cfset request.spare01 = session.spare01  >
	</cflock>
	<cfif DateDiff("d", Now(), form.MatchDate) LT request.spare01 >  
		<cfoutput>
			<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
			<span class="pix13boldred">You are not allowed to alter your availability within #request.spare01# days of the match. Please contact the league directly.<br><br>Please click on the Back button of your browser.</span>
		</cfoutput>
		<cfabort>
	</cfif>
	----------->
	
	<!--- check to see if the referee has an appointment on this date and don't allow any changes to be made by referee --->
	<cfinclude template="qry_QRefAppt.cfm">
	<cfif QRefAppt.RecordCount GT 0 >
		<cfoutput>
			<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
			<span class="pix13boldred">You have an appointment on this day. Please contact the Ref Sec if there's a problem.<br>Please click on the Back button of your browser.</span>
		</cfoutput>
		<cfabort>
	</cfif>
	
	<cfif DateDiff("d", Now(), form.MatchDate) LT 0 >  
		<cfoutput>
			<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
			<span class="pix13boldred">You are not allowed to change availability for old dates.<br><br>Please click on the Back button of your browser.</span>
		</cfoutput>
		<cfabort>
	</cfif>
	
	
</cfif>
<cftry>		  
		<cfquery name = "InsertRefAvailable" datasource="#request.DSN#">
			INSERT INTO
				refavailable  
				(RefereeID, MatchDate, Available, Notes, LeagueCode)
				VALUES
				( #form.RefereeID# , '#form.MatchDate#' , '#form.Action#' , '#form.Notes#' ,
				 <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> );
		</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<!--- duplicate values on index EventDateLeaguecode --->
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
				ID,
				RefereeID,
				MatchDate
			FROM 
				refavailable 
			WHERE 
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
				AND RefereeID = <cfqueryparam value = #form.RefereeID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
				AND MatchDate = <cfqueryparam value = '#form.MatchDate#'  cfsqltype="CF_SQL_DATE" >
		</cfquery>
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

