<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(url, "CountiesList") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif url.CountiesList IS '' >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<table border="0" align="center" cellpadding="10" cellspacing="0" bgcolor="white">
<tr>
	<td >
		<cfinclude template="queries/qry_QNoticeboard.cfm">
		<cfoutput query="QNoticeboard">
			<cfif ShowEverywhere>
				<cfinclude template="Noticeboard_output.cfm">
				<br>
			<cfelseif ShowForTheseCounties IS NOT "">
				<cfset ShowAdvert = "No">
				<cfloop index="I" from="1" to="#ListLen(QNoticeboard.ShowForTheseCounties)#" step="1">
					<cfif ListFindNoCase( url.CountiesList, ListGetAt(QNoticeboard.ShowForTheseCounties, I) )>
						<cfset ShowAdvert = "Yes">
					</cfif>
				</cfloop>
				<cfif ShowAdvert IS "Yes">
				<cfinclude template="Noticeboard_output.cfm">
				<br>
				</cfif>
			<cfelse>
			</cfif>
		</cfoutput>
	</td>
	<td valign="top">
		<cfif TimeFormat(Now(),'s') GE 20>
			<cfinclude template="adverts/inclVIDEOperformgroup300x360.cfm">
		<cfelse>
			<cfinclude template="adverts/inclYouth300x250.cfm">
		</cfif>
	</td>							
	
</tr>
</table>


