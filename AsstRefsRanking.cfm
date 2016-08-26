<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "RI")>
	<cfinclude template="queries/qry_QAsstReferee.cfm">
<cfelse>
	<cfset RI = "">
</cfif>
<cfset AsstRefsRank = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's an Assistant Referees' Ranking --->
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QAsstRefsRanking.cfm">
<BR>
<table border="1" cellspacing="0" cellpadding="3" align="CENTER">
	<tr>
		<td><span class="pix13">&nbsp;</span></td>
		<td align="CENTER"><span class="pix10bold">Surname</span></td>
		<td align="CENTER"><span class="pix10bold">Forename</span></td>
		<td align="CENTER"><span class="pix10bold">Assistant<BR>Referee</span></td>
		<td align="CENTER"><span class="pix10bold">Parent<br>County</span></td>
		<td align="CENTER"><span class="pix10bold">Level</span></td>
		<td align="CENTER"><span class="pix10bold">Number of<BR>Marks</span></td>
		<td align="CENTER"><span class="pix10bold">Average<BR>Marks</span></td>
	</tr>
	<cfoutput query="QAsstRefsRanking">
		<tr <cfif #AsstRefsID# IS #RI# >class="bg_highlight"</cfif> >
			<td><span class="pix13bold">#CurrentRow#</span></td>
			<td align="left"><span class="pix13">#Surname#</span></td>
			<td align="left"><span class="pix13">#Forename#</span></td>
			<td><span class="pix10">#AsstRefsName#</span></td>
			<td><span class="pix10">#ParentCounty#</span></td>
			<td align="center"><span class="pix10">#RefsLevel#</span></td>
			<td align="CENTER"><span class="pix13">#NumberFormat(TGames, "9999")#</span></td>
			<td align="CENTER"><span class="pix13">#NumberFormat(TAverage, "99.999")#</span></td>
		</tr>
	</cfoutput>
</table>

