<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "RI")> <!--- highlight the referee in the ranking --->
	<cfset RI = "#url.RI#">
	<!--- <cfinclude template="queries/qry_QReferee_v1.cfm"> --->
<cfelseif StructKeyExists(form, "RI")> <!--- highlight the referee in the ranking --->
	<cfset RI = "#form.RI#">
	<!--- <cfinclude template="queries/qry_QReferee_v1.cfm"> --->
<cfelse>
	<cfset RI = "">
</cfif>


<cfset RefsRank = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Referees' Ranking --->

<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRefsLevels.cfm">
<cfinclude template="queries/qry_QRefsCounties.cfm">
<cfif StructKeyExists(form, "PCounty")> <!--- highlight the referee in the ranking --->
	<cfset ThisPCounty = #form.PCounty# >
<cfelse>
	<cfset ThisPCounty = "ALL">
</cfif>
<cfif StructKeyExists(form, "Level")> <!--- highlight the referee in the ranking --->
	<cfset ThisLevel = #form.Level# >
<cfelse>
	<cfset ThisLevel = "">
</cfif>

<cfoutput>
<form name="RefsRanking" action="RefsRanking.cfm?LeagueCode=#LeagueCode#" METHOD="post" >
<input type="hidden" name="RI" VALUE="#RI#">

</cfoutput>
<table border="0" cellspacing="0" cellpadding="0" align="CENTER">
	<tr>
		<td align="CENTER">
			<span class="pix10bold">Parent County
				<select name="PCounty" size="1" style="font-family:#font_face#; font-size:13px;" >
				<cfoutput><option value="ALL" <cfif "ALL" IS ThisPCounty>selected</cfif>>ALL</option></cfoutput>
				<cfoutput query="QRefsCounties" ><option value="#PCounty#" <cfif QRefsCounties.PCounty IS ThisPCounty>selected</cfif>>#PCounty#</option></cfoutput>
				</select>
			</span>
		</td>
		<td align="CENTER">&nbsp;</td>
		<td align="CENTER">
			<span class="pix10bold">Level
				<select name="Level" size="1" style="font-family:#font_face#; font-size:13px;" >
				<cfoutput><option value="">ALL</option></cfoutput>
				<cfoutput query="QRefsLevels" ><option value="#Level#" <cfif QRefsLevels.Level IS ThisLevel>selected</cfif>>#Level#</option></cfoutput>
				</select>
			</span>
		</td>
		<td align="CENTER"><input name="ReportButton" type="submit" value="Create Report"></td>
	</tr>
</table>
</form>
<br>
<cfif StructKeyExists(form, "ReportButton")> 

 
	<cfinclude template="queries/qry_QRefsRanking.cfm">
	<cfif QRefsRanking.RecordCount GT 0>
	
	<BR>
	<table border="1" cellspacing="2" cellpadding="2" align="CENTER">
		<tr>
			<td><span class="pix13bold">&nbsp;</span></td>
			<td align="CENTER"><span class="pix10bold">Surname</span></td>
			<td align="CENTER"><span class="pix10bold">Forename</span></td>
			<td align="CENTER"><span class="pix10bold">Referee</span></td>
			<td align="CENTER"><span class="pix10bold">Parent<br>County</span></td>
			<td align="CENTER"><span class="pix10bold">Level</span></td>
			<td align="CENTER"><span class="pix10bold">Number of<br>Marks</span></td>
			<td align="CENTER"><span class="pix10bold">Average<br>Marks</span></td>
			<td><span class="pix13bold">&nbsp;</span></td>
		</tr>
		<cfoutput query="QRefsRanking" >
			<tr <cfif #RefsID# IS #form.RI# >class="bg_highlight"</cfif> >
				<td align="right"><span class="pix13bold">#CurrentRow#</span></td>
				<td align="left"><span class="pix13">#Surname#</span></td>
				<td align="left"><span class="pix13">#Forename#</span></td>
				<td align="left"><span class="pix10">#RefsName#</span></td>
				<td align="left"><span class="pix10">#ParentCounty#</span></td>
				<td align="center"><span class="pix10">#Level#</span></td>
				<td align="CENTER"><span class="pix13">#RefereeMarkedGames#</span></td>
				<td align="CENTER"><span class="pix13">#NumberFormat(Evaluate(SumRefereeMarks / RefereeMarkedGames),"99.999")#</span></td>
				<td align="center"><a href="RefsHist.cfm?LeagueCode=#LeagueCode#&RI=#RefsID#"><span class="pix10">see history</span></a></td>
			</tr>
		</cfoutput>
	</table>
	<cfinclude template="queries/qry_QRefsAverage_v5.cfm">
	<HR>
	<BR>
	<cfoutput query="QRefsAverage">
	<span class="pix13">
	<cfif ThisPCounty IS "ALL">
		All Parent Counties
	<cfelse>
		Parent County #ThisPCounty#
	</cfif>
	<cfif ThisLevel IS "">
		All Levels
	<cfelse>
		Level #ThisLevel# Referees
	</cfif>
	
	<br>
	Total marks = #NumberFormat(SumRefereeMarks, "9,999,999")#<BR>
	Total no. of marks = #RefereeMarkedGames#<BR>
	League average mark = #NumberFormat(Evaluate(SumRefereeMarks / RefereeMarkedGames),"99.999")#
	</span>
	</cfoutput>
	<cfelse>
	<table border="0" cellspacing="2" cellpadding="2" align="CENTER">
		<tr>
			<td><span class="pix13bold">Nothing to report with these criteria</span></td>
		</tr>
	</table>
	</cfif>



</cfif>


