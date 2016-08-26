<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries\qry_QCommitteeDetails.cfm">
<cfoutput><center><span class="pix18bold">Season #RIGHT(request.DSN,4)#</span></center><br><br></cfoutput>
<cfoutput query="QCommitteeDetails">
	<span class="monopix12">"#trim(longcol)#","#trim(mediumcol)#","#trim(leaguecode)#","#trim(namesort)#","#stripcr(replacelist(UCase(notes),'",<,>,!,/','*,*,*,*,*'))#"</span>
	</span><BR>
</cfoutput>
