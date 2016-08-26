<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset ErrorText = "">
<cfset InptCount = 0>
<cfoutput>
	<CFLOOP index="I" from="2" to="500" step="1">
		<!--- PerfectLine is a flag ... Posit the line is good.... --->
		<cfset PerfectLine = "Yes" >
		<cfset LineString = #Trim(GetToken(Form.BatchInput, I, CHR(10) )) #>
		<!--- Check the RegNo --->
		<cfif PerfectLine IS "Yes">
			<cfset PlayerRegNo = GetToken(Linestring, 1, " " ) >
			<cfif IsNumeric(PlayerRegNo) IS "No" >
				<cfset PerfectLine = "No" >
			</cfif>
		</cfif>
		<cfif PerfectLine IS "Yes">
			<cfinclude template="queries/qry_QTempPlayerRegNo.cfm">
			<cfif QTempPlayerRegNo.RecordCount IS 1>
				<cfset ErrorText = '#ErrorText# <span class="pix10bold">Player Reg. No. #PlayerRegNo#  #QTempPlayerRegNo.Forename# <u>#QTempPlayerRegNo.Surname#</u><BR></span>'>
			<cfelse>
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Player Reg. No. #PlayerRegNo# not found.<BR><BR></span>'>
			</cfif>
		</cfif>
		<cfif PerfectLine IS "Yes">
			<cfinclude template="queries/qry_QRegisterF.cfm">
			<cfif QRegisterF.RecordCount IS 1>
				<cfinclude template="queries/upd_RegisterFB.cfm">
			<cfelse>
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">not updated ....<BR><BR></span>'>
			</cfif>
		</cfif>
		<cfif PerfectLine IS "Yes">
			<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">now a Contract player for #QRegisterF.TeamName#<BR><BR></span>'>
			<cfset InptCount = InptCount + 1>
		</cfif>															

	</cfloop>
</cfoutput>	
<cfoutput>
	<span class="pix18bold">Batch Input Report<BR><BR></span>
	<cfif Trim(ErrorText) IS "">
		<span class="pix13">Nothing to report.<BR><BR></span>
	<cfelse>
		<span class="pix13">#ErrorText#<BR><BR></span>
		<span class="pix18boldgreen">Input Total #InptCount#<BR><BR></span>
	</cfif>
	<span class="pix18bold">Please press the "Back" button on your browser to continue.....</span>
</cfoutput>
