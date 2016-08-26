<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset ListingClubs = "Yes">					<!--- Introduce paging April. 2001 --->
<cfinclude template="InclBegin.cfm">

<cfif StructKeyExists(request, "filter") AND RIGHT(request.DSN,4) EQ 1999>
	<span class="pix13bold">As the referee's promotion report runs over a two-year period, and this is the first effective year of football.mitoo, this section is inoperative!</span>
	<cfabort>
</cfif>

<cfoutput>
	<FORM ACTION="RefsPromotionReport.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
			<tr align="CENTER">
				<td colspan="2">
					<span class="pix10">
					 Please enter an unique name that specifies the candidate<BR>
					 both for this season and for last season<BR>
					</span>
				</td>
			</tr>
			<tr>
				<td align="CENTER" colspan="2">
					<input type="Text" name="RefsSurname"
					<cfif StructKeyExists(form, "RefsSurname")>value="#TRIM(form.RefsSurname)#"</cfif>
						size="20" maxlength="30">
					<input type="Submit" name="SubmitButton" value="continue" >
				</td>
			</tr>	  
		</table>
		<input type="Hidden" NAME="LeagueCode" VALUE="#LeagueCode#">
	</FORM>
</cfoutput>

<cfif StructKeyExists(form, "RefsSurname")>
<!--- Referees that are in a County FA promotion scheme are assessed over a period of one year.
This period covers two seasons because it runs from 1st March to 28/29th February.
That is the last 3 months of one season and the first 7 months of the following season.
So, we need to look at two databases, e.g. MDX02 and MDX03 (or FM2002 and FM2003)
--->
<cfif form.RefsSurname IS "">
	<CFABORT>
</cfif>
<cfif LEN(form.RefsSurname) LT 3>
Please enter at least three characters.
	<CFABORT>
</cfif>

<cfif StructKeyExists(request, "filter")>
	<cfset ThisYYYYString = RIGHT(URL.LeagueCode,4)>
	<!--- e.g. "2003" --->
	<cfset LastYYYYString = ThisYYYYString - 1 >
	<!--- e.g. "2002" --->
	<cfset NextYYYYString = ThisYYYYString + 1 >
	<!--- e.g. "2004" --->	
<cfelse>
	<cfset LeagueCodeLength = LEN(URL.LeagueCode) >
	<cfset LeagueCodePrefix = LEFT(URL.LeagueCode,LeagueCodeLength-2)>
	<cfset ThisYYstring = RIGHT(URL.LeagueCode,2)>
	<cfset ThisYYYYString = "20#ThisYYstring#" >
	<cfset LastYYYYString = ThisYYYYString - 1 >
	<cfset NextYYYYString = ThisYYYYString + 1 >
</cfif>

<!---
************
* season 1 *
************
--->
<!--- <cfset DataSrce = "#LeagueCodePrefix##RIGHT(LastYYYYString,2)#"> --->
<cfset DataSrce = "fm#LastYYYYString#">
<cfset DefaultLeagueCode1 = "fm#LastYYYYString#">
<cfinclude template="queries/qry_QRefsID.cfm">
<cfif QRefsID.RecordCount IS 1>
<cfelseif QRefsID.RecordCount IS 0 >
	<cfoutput>
	<span class="pix13bold">"#TRIM(form.RefsSurname)#" not found in Season #LastYYYYString#-#ThisYYYYString#</span>
	<CFABORT>
	</cfoutput>
<cfelse>
	<cfoutput query="QRefsID">
		<span class="pix18bold">#RName#<BR></span>
	</cfoutput>
	<span class="pix18boldred"><BR>Please enter an unique name for BOTH seasons.<BR>Check the spelling. Is it identical for BOTH seasons?<BR><BR></span>
	<CFABORT>
</cfif>
<cfinclude template="queries/qry_QRefsPromotionReport_v1.cfm">
<table border="1" cellpadding="2" cellspacing="2">
	<tr>
		<cfset DLCode = "#Left(LeagueCode,LEN(URL.LeagueCode)-4)##LastYYYYString#">
		<cfinclude template="queries/qry_QLeagueInfo.cfm">
		<cfif QLeagueInfo.RefMarksOutOfHundred IS 0>
			<cfset factor1 = 10>
		<cfelse>
			<cfset factor1 = 1>
		</cfif>
		<td colspan="3" align="center"><cfoutput><span class="pix13bold">#QRefsID.RName#<BR>Season #LastYYYYString#-#ThisYYYYString#</span></cfoutput></td>
		<td align="center"><span class="pix13">Marks <cfif factor1 IS 10>out of 10<br />will be<br />mult. by 10<cfelse>out of 100</cfif></span></td>
	</tr>
	<cfoutput query="QRefsPromotionReport">
	<tr>
		<td><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')#</span></td>
		<td><span class="pix13">#DivisionName#</span></td>
		<td><span class="pix13">#HomeTeamName# #HomeOrdinalName# #HomeGoals# v #AwayGoals# #AwayTeamName# #AwayOrdinalName#</span></td>
		<td align="center" <cfif RefereeMarksH IS "" OR RefereeMarksA IS "">bgcolor="Red"</cfif> ><span class="pix13">H=#RefereeMarksH# A=#RefereeMarksA#</span></td>
	</tr>
	</cfoutput>
</table>
<cfinclude template="queries/qry_QRefereeH1.cfm">

<cfif QRefereeH1.SumRefereeMarksH IS "">
	<cfset RefereeMarksH1 = 0>
<cfelse>
	<cfset RefereeMarksH1 = QRefereeH1.SumRefereeMarksH * factor1>
</cfif>
<cfset RefereeMarkedGamesH1 = QRefereeH1.RefereeMarkedGamesH >

<cfinclude template="queries/qry_QRefereeA1.cfm">

<cfif QRefereeA1.SumRefereeMarksA IS "">
	<cfset RefereeMarksA1 = 0>
<cfelse>
	<cfset RefereeMarksA1 = QRefereeA1.SumRefereeMarksA * factor1>
</cfif>
<cfset RefereeMarkedGamesA1 = QRefereeA1.RefereeMarkedGamesA >


<cfinclude template="queries/qry_QLeagueMarksH1.cfm">
<cfif QLeagueMarksH1.SumRefereeMarksH IS "">
	<cfset LeagueMarksH1 = 0>
<cfelse>
	<cfset LeagueMarksH1 = QLeagueMarksH1.SumRefereeMarksH * factor1>
</cfif>
<cfset LeagueMarkedH1 = QLeagueMarksH1.RefereeMarkedGamesH >

<cfinclude template="queries/qry_QLeagueMarksA1.cfm">
<cfif QLeagueMarksA1.SumRefereeMarksA IS "">
	<cfset LeagueMarksA1 = 0>
<cfelse>
	<cfset LeagueMarksA1 = QLeagueMarksA1.SumRefereeMarksA * factor1>
</cfif>
<cfset LeagueMarkedA1 = QLeagueMarksA1.RefereeMarkedGamesA >

<cfif IsNumeric(RefereeMarksH1) IS "No">
	<cfset RefereeMarksH1 = 0 >
</cfif>
<cfif IsNumeric(RefereeMarkedGamesH1) IS "No">
	<cfset RefereeMarkedGamesH1 = 0 >
</cfif>
<cfif IsNumeric(RefereeMarksA1) IS "No">
	<cfset RefereeMarksA1 = 0 >
</cfif>
<cfif IsNumeric(RefereeMarkedGamesA1) IS "No">
	<cfset RefereeMarkedGamesA1 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarksH1) IS "No">
	<cfset LeagueMarksH1 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarkedH1) IS "No">
	<cfset LeagueMarkedH1 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarksA1) IS "No">
	<cfset LeagueMarksA1 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarkedA1) IS "No">
	<cfset LeagueMarkedA1 = 0 >
</cfif>
<!---
************
* season 2 *
************
--->
<cfset DataSrce = "fm#ThisYYYYString#">
<cfinclude template="queries/qry_QRefsID.cfm">
<cfif QRefsID.RecordCount IS 1>
<cfelseif QRefsID.RecordCount IS 0 >
	<cfoutput>
	<span class="pix13bold">"#TRIM(form.RefsSurname)#" not found in Season #ThisYYYYString#-#NextYYYYString#</span>
	<CFABORT>
	</cfoutput>
<cfelse>
	<cfoutput query="QRefsID">
		<span class="pix18bold">#RName#<BR></span>
	</cfoutput>
	<BR>
	<cfoutput>
	<span class="pix18boldred"><BR>Please enter an unique name for BOTH seasons</span>
	</cfoutput>
	<BR>
	<CFABORT>
</cfif>
<BR>
<cfinclude template="queries/qry_QRefsPromotionReport_v2.cfm">
<table border="1" cellpadding="2" cellspacing="2">
	<tr>
		<cfset DLCode = "#Left(LeagueCode,LEN(URL.LeagueCode)-4)##ThisYYYYString#">
		<cfinclude template="queries/qry_QLeagueInfo.cfm">
		<cfif QLeagueInfo.RefMarksOutOfHundred IS 0>
			<cfset factor2 = 10>
		<cfelse>
			<cfset factor2 = 1>
		</cfif>
		<td colspan="3" align="center"><cfoutput><span class="pix13bold">#QRefsID.RName#<BR>Season #ThisYYYYString#-#NextYYYYString#</strong></span></cfoutput></td>
		<td align="center"><span class="pix13">Marks <cfif factor2 IS 10>out of 10<br />will be<br />mult. by 10<cfelse>out of 100</cfif></span></td>
	</tr>
	<cfoutput query="QRefsPromotionReport">
		<tr>
			<td><span class="pix13">#DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')#</span></td>
			<td><span class="pix13">#DivisionName#</span></td>
			<td><span class="pix13">#HomeTeamName# #HomeOrdinalName# #HomeGoals# v #AwayGoals# #AwayTeamName# #AwayOrdinalName#</span></td>
			<td align="center" <cfif RefereeMarksH IS "" OR RefereeMarksA IS "">bgcolor="Red"</cfif> ><span class="pix13">H=#RefereeMarksH# A=#RefereeMarksA#</span></td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="queries/qry_QRefereeH2.cfm">
<cfset RefereeMarksH2 = QRefereeH2.SumRefereeMarksH >
<cfset RefereeMarkedGamesH2 = QRefereeH2.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QRefereeA2.cfm">
<cfset RefereeMarksA2 = QRefereeA2.SumRefereeMarksA >
<cfset RefereeMarkedGamesA2 = QRefereeA2.RefereeMarkedGamesA >
<cfinclude template="queries/qry_QLeagueMarksH2.cfm">
<cfset LeagueMarksH2 = QLeagueMarksH2.SumRefereeMarksH >
<cfset LeagueMarkedH2 = QLeagueMarksH2.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QLeagueMarksA2.cfm">
<cfset LeagueMarksA2 = QLeagueMarksA2.SumRefereeMarksA >
<cfset LeagueMarkedA2 = QLeagueMarksA2.RefereeMarkedGamesA >
<cfif IsNumeric(RefereeMarksH2) IS "No">
	<cfset RefereeMarksH2 = 0 >
<cfelse>
	<cfset RefereeMarksH2 = RefereeMarksH2 * factor2>
</cfif>
<cfif IsNumeric(RefereeMarkedGamesH2) IS "No">
	<cfset RefereeMarkedGamesH2 = 0 >
</cfif>
<cfif IsNumeric(RefereeMarksA2) IS "No">
	<cfset RefereeMarksA2 = 0 >
<cfelse>
	<cfset RefereeMarksA2 = RefereeMarksA2 * factor2>
</cfif>
<cfif IsNumeric(RefereeMarkedGamesA2) IS "No">
	<cfset RefereeMarkedGamesA2 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarksH2) IS "No">
	<cfset LeagueMarksH2 = 0 >
<cfelse>
	<cfset LeagueMarksH2 = LeagueMarksH2 * factor2>
</cfif>
<cfif IsNumeric(LeagueMarkedH2) IS "No">
	<cfset LeagueMarkedH2 = 0 >
</cfif>
<cfif IsNumeric(LeagueMarksA2) IS "No">
	<cfset LeagueMarksA2 = 0 >
<cfelse>
	<cfset LeagueMarksA2 = LeagueMarksA2 * factor2>
</cfif>
<cfif IsNumeric(LeagueMarkedA2) IS "No">
	<cfset LeagueMarkedA2 = 0 >
</cfif>

<cfset RefsMarks = RefereeMarksH1+RefereeMarksA1+RefereeMarksH2+RefereeMarksA2 >
<cfset RefsMarkedGames = RefereeMarkedGamesH1+RefereeMarkedGamesA1+RefereeMarkedGamesH2+RefereeMarkedGamesA2 >
<cfset LeagueMarks = LeagueMarksH1+LeagueMarksA1+LeagueMarksH2+LeagueMarksA2 >
<cfset LeagueMarkedGames = LeagueMarkedH1+LeagueMarkedA1+LeagueMarkedH2+LeagueMarkedA2 >
<BR>
<BR>
<table  border="1" cellpadding="2" cellspacing="2">
	<cfif RefsMarkedGames GT 0 >
		<tr>
			<td align="center">
				<cfoutput>
				<span class="pix13bold">
				This Referee's Average mark out of 100 = #NumberFormat(Evaluate(RefsMarks/RefsMarkedGames),"99.999")# (Total marks = #NumberFormat(RefsMarks, "9,999,999")# divided by #RefsMarkedGames# sets of marks)<BR>
				</span>
				</cfoutput>
			</td>
		</tr>
	<cfelse>
		<tr>
			<td align="center">
				<cfoutput>
				<span class="pix13bold">
				No marks available for this referee<BR>
				</span>
				</cfoutput>
			</td>
		</tr>
	</cfif>
	<cfif LeagueMarkedGames GT 0 >
		<tr>
			<td align="center">
				<cfoutput>
				<span class="pix13bold">
				League Average mark out of 100 = #NumberFormat(Evaluate(LeagueMarks / LeagueMarkedGames),"99.999")# (Total marks = #NumberFormat((LeagueMarks), "9,999,999")# divided by #LeagueMarkedGames# sets of marks)<BR>
				</span>
				</cfoutput>
			</td>
		</tr>
	</cfif>
</table>
</cfif>