<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=RefereeDetails.xls">
<cfset ThisColSpan = 4 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Referee Details</strong></td></tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_RefereeList.cfm">
<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="RefereeList">
	<tr>
		<td width="100%" colspan="#ThisColSpan#" align="left" bgcolor="white"><b>#Forename# #Surname#</b><cfif len(trim(ParentCounty)) GT 0> (#ParentCounty#)</cfif><cfif Level GT 0> Level #Level#</cfif><cfif PromotionCandidate IS "Yes"> <strong>Promotion Candidate</strong></cfif></td>
	</tr>
	<tr>
		<td align="left" colspan="#ThisColSpan#"  valign="top">#AddressLine1#<cfif len(trim(AddressLine2)) GT 0>, #AddressLine2#</cfif><cfif len(trim(AddressLine3)) GT 0>, #AddressLine3#</cfif><cfif len(trim(PostCode)) GT 0>&nbsp;&nbsp;#PostCode#</cfif><br>
	<cfif len(trim(HomeTel)) GT 0> H: #HomeTel#</cfif><cfif len(trim(WorkTel)) GT 0> W: #WorkTel#</cfif><cfif len(trim(MobileTel)) GT 0> M: #MobileTel#</cfif><br>
	<cfif len(trim(EmailAddress1)) GT 0><font face="Courier New, Courier, mono">#LCase(EmailAddress1)#</font></cfif><br>
	<cfif len(trim(EmailAddress2)) GT 0><font face="Courier New, Courier, mono">#LCase(EmailAddress2)#</font></cfif><br>
	<cfif len(trim(Notes)) GT 0>#Notes#</cfif><br>
	</tr>
</cfoutput>
</table>
