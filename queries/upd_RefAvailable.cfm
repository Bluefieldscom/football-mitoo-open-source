<!--- called by RefAvailableUpdDel.cfm --->
<cfset ThisRefAvailableID = form.ID >
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.DSN,4) GE 2012 AND ListFind("Silver,Skyblue",request.SecurityLevel)>
	<!--- check to see if the referee has an appointment on this date so possibly don't allow changes to be made by Julian or Administrator  --->
	<cfinclude template="qry_QRefAppt.cfm">
	<cfif QRefAppt.RecordCount GT 0 >
		<!--- 
		currently GREEN
		--->	
		<cfif form.Status IS "Y"> <!--- available   --->
			<cfif form.Action IS "Yes">
				<cfoutput>
					<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
					<span class="pix13boldred">Nothing changed. Please click on the Back button of your browser.</span>
				</cfoutput>
				<cfabort>
			<cfelseif form.Action IS "No">
				<cfoutput>
					<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
					<span class="pix13boldred">The referee has an appointment on this day. You must remove the appointment before you can close the date.<br>Please click on the Back button of your browser.</span>
				</cfoutput>
				<cfabort>
			<cfelse>
				ERROR form.Action IS "#form.Action#" ....... aborting
				<cfabort>
			</cfif>
		<!--- 
		currently PINK
		--->	
		<cfelseif form.Status IS "N"> <!--- not available  --->
			<cfif form.Action IS "Yes">
			<cfelseif form.Action IS "No">
				<cfoutput>
					<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
					<span class="pix13boldred">Nothing changed. Please click on the Back button of your browser.</span>
				</cfoutput>
				<cfabort>
			<cfelse>
				ERROR form.Action IS "#form.Action#" ....... aborting
				<cfabort>
			</cfif>
		<!--- 
		currently GREY
		--->	
		<cfelseif form.Status IS "0"> <!--- not known  --->
			<cfif form.Action IS "Yes">
			<cfelseif form.Action IS "No">
				<cfoutput>
					<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
					<span class="pix13boldred">The referee has an appointment on this day. You must remove the appointment before you can close the date.<br>Please click on the Back button of your browser.</span>
				</cfoutput>
				<cfabort>
			<cfelse>
				ERROR form.Action IS "#form.Action#" ....... aborting
				<cfabort>
			</cfif>
		
		<cfelse>
			ERROR upd_RefAvailable.cfm .... aborting
			<cfabort>
		</cfif>
	</cfif>
</cfif>


<cfif RIGHT(request.DSN,4) GE 2012 AND ListFind("Yellow",request.SecurityLevel)>
	<!-----
	<cflock scope="session" timeout="10" type="readonly">
		<cfset request.spare01 = session.spare01  >
	</cflock>
	---------->
	
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
	
<!--- 
currently GREEN
--->	
	<cfif form.Status IS "Y"> <!--- available   --->
		<cfif form.Action IS "Yes">
			<cfoutput>
				<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
				<span class="pix13boldred">Nothing changed. Please click on the Back button of your browser.</span>
			</cfoutput>
			<cfabort>
		<cfelseif form.Action IS "No">
		<cfelse>
			ERROR form.Action IS "#form.Action#" ....... aborting
			<cfabort>
		</cfif>
<!--- 
currently PINK
--->	
	<cfelseif form.Status IS "N"> <!--- not available  --->
		<cfif form.Action IS "Yes">
		<cfelseif form.Action IS "No">
			<cfoutput>
				<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
				<span class="pix13boldred">Nothing changed. Please click on the Back button of your browser.</span>
			</cfoutput>
			<cfabort>
		<cfelse>
			ERROR form.Action IS "#form.Action#" ....... aborting
			<cfabort>
		</cfif>
	
<!--- 
currently GREY
--->	
	<cfelseif form.Status IS "0"> <!--- not known  --->
		<cfif form.Action IS "Yes">
		<cfelseif form.Action IS "No">
		<cfelse>
			ERROR form.Action IS "#form.Action#" ....... aborting
			<cfabort>
		</cfif>
	
	<cfelse>
		ERROR upd_RefAvailable.cfm .... aborting
		<cfabort>
	</cfif>
	
	
</cfif>

<!--- snapshot before --->
<cfset BeforeID = form.ID >
<cfinclude template="qry_QRefAvailableBefore.cfm">

<cftry>		  
		<cfquery name = "UpdateRefAvailable" datasource="#request.DSN#">
		UPDATE
			refavailable 
		SET 
			Notes = '#form.Notes#' ,
			Available = '#form.Action#'
		WHERE
			ID = '#form.ID#';
		</cfquery>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="RefAvailable" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<!--- snapshot after --->
	<cfset AfterID = #ThisRefAvailableID# >
	<cfinclude template="qry_QRefAvailableAfter.cfm">
	<cfset ThisRefereeID = QRefAvailableAfter.RefereeID >
	<cfset ThisMatchDate = QRefAvailableAfter.MatchDate >
	<!--- check for any changes --->
	<cfloop index = "ListElement" list = "Available,Notes"> 
		<cfscript>
			ThisFieldName = "#ListElement#" ;
			BeforeValue = "QRefAvailableBefore.#ThisFieldName#" ;
			BeforeValue = Evaluate(BeforeValue);
			AfterValue = "QRefAvailableAfter.#ThisFieldName#" ;
			AfterValue = Evaluate(AfterValue);
			SecurityLevel = "#MID(request.SecurityLevel,4,1)#";
		</cfscript>
		<cfif BeforeValue IS NOT AfterValue >
			<cfinclude template="ins_RefAvailableUpdateLog.cfm">
		</cfif>
	</cfloop>
</cfif>

