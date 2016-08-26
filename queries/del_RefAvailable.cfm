<!--- called by RefAvailableUpdDel.cfm --->
<cfset ThisRefAvailableID = form.ID >

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.DSN,4) GE 2012 AND ListFind("Silver,Skyblue",request.SecurityLevel)>
	<!--- check to see if the referee has an appointment on this date so possibly don't allow deletion by Julian or Administrator  --->
	<cfinclude template="qry_QRefAppt.cfm">
	<cfif QRefAppt.RecordCount GT 0 >
		<cfoutput>
			<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
			<span class="pix13boldred">The referee has an appointment on this day. You must remove the appointment before you can delete the availability.<br>Please click on the Back button of your browser.</span>
		</cfoutput>
		<cfabort>
	</cfif>
</cfif>

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.DSN,4) GE 2012 AND ListFind("Yellow",request.SecurityLevel)>
	<!----------
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
	--------------->
	
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
		
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<!--- snapshot before --->
	<cfset BeforeID = form.ID >
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
	<cfquery name="DeleteRefavailable" datasource="#request.DSN#">
		DELETE FROM
			refavailable 
		WHERE
			ID = '#form.ID#';
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="Refavailable" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>
