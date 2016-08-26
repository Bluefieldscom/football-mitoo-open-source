<!--- called by Calendar.cfm --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- applies to season 2012 onwards only --->
<cfset ThisRefAvailableID = form.RefereeID >
<cfif RIGHT(request.dsn,4) GE 2012>
	<!--- snapshot before --->
	<cfset BeforeID = #ThisID# >
	<cfinclude template="qry_QRefAvailableBefore.cfm">
		<cfset ThisRefereeID = QRefAvailableBefore.RefereeID >
		<cfset ThisMatchDate = QRefAvailableBefore.MatchDate >
		<cfloop index = "ListElement" list = "Available,Notes"> 
			<cfscript>
				ThisFieldName = "#ListElement#" ;
				BeforeValue = "QRefAvailableBefore.#ThisFieldName#" ;
				BeforeValue = Evaluate(BeforeValue);
				AfterValue = "" ;
				SecurityLevel = "#MID(request.SecurityLevel,4,1)#";
			</cfscript>
			<cfif BeforeValue IS NOT AfterValue >
				<cfinclude template="ins_RefAvailableUpdateLog.cfm">
			</cfif>
		</cfloop>
</cfif>

<cftry>		  
	<cfquery name="DeleteEvent" datasource="#request.DSN#">
		DELETE FROM
			refavailable 
		WHERE
			ID = '#ThisID#';
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="Event" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>
