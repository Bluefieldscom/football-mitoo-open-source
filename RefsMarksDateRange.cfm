<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<CFSET TTL="Referee Promotion Candidate" >
<CFSET ListingClubs = "Yes">					<!--- Introduce paging April. 2001 --->
<cfinclude template="InclBegin.cfm">
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
					<cfif IsDefined("RefsSurname")>value="#TRIM(RefsSurname)#"</cfif>
						size="20" maxlength="30">
					<input type="Submit" name="SubmitButton" value="continue" >
				</td>
			</tr>	  
		</table>
		<input type="Hidden" NAME="LeagueCode" VALUE="#LeagueCode#">
	</FORM>
</cfoutput>
<cfif IsDefined("form.RefsSurname")>
<!--- Referees that are in a County FA promotion scheme are assessed ove a period of one year.
This period covers two seasons because it runs from 1st March to 28/29th February.
That is the last 3 months of one season and the first 7 months of the following season.
So, we need to look at two Access mdbs, e.g. MDX02 and MDX03
--->
<cfif form.RefsSurname IS "">
	<CFABORT>
</cfif>
<cfif LEN(form.RefsSurname) LT 3>
Please enter at least three characters.
	<CFABORT>
</cfif>
<cfset LeagueCodeLength = LEN(URL.LeagueCode) >
<!--- e.g. "MDX03" is 5 characters long --->
<cfset LeagueCodePrefix = LEFT(URL.LeagueCode,LeagueCodeLength-2)>
<!--- e.g. "MDX" --->
<cfset ThisYYstring = RIGHT(URL.LeagueCode,2)>
<!--- e.g. "03" --->
<cfset ThisYYYYString = "20#ThisYYstring#" >
<!--- e.g. "2003" --->
<!--- previous year --->
<cfset LastYYYYString = ThisYYYYString - 1 >
<!--- e.g. "2002" --->
<!--- next year --->
<cfset NextYYYYString = ThisYYYYString + 1 >
<!--- e.g. "2004" --->


<!---
************
* season 1 *
************
--->
<cfset DataSrce = "#LeagueCodePrefix##RIGHT(LastYYYYString,2)#">
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
		<td colspan="3" align="center"><cfoutput><span class="pix13bold">#QRefsID.RName#<BR>Season #LastYYYYString#-#ThisYYYYString#</span></cfoutput></td>
		<td align="center"><span class="pix13">Marks</span></td>
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
<CFSET RefereeMarksH1 = QRefereeH1.SumRefereeMarksH >
<CFSET RefereeMarkedGamesH1 = QRefereeH1.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QRefereeA1.cfm">
<CFSET RefereeMarksA1 = QRefereeA1.SumRefereeMarksA >
<CFSET RefereeMarkedGamesA1 = QRefereeA1.RefereeMarkedGamesA >
<cfinclude template="queries/qry_QLeagueMarksH1.cfm">
<CFSET LeagueMarksH1 = QLeagueMarksH1.SumRefereeMarksH >
<CFSET LeagueMarkedH1 = QLeagueMarksH1.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QLeagueMarksA1.cfm">
<CFSET LeagueMarksA1 = QLeagueMarksA1.SumRefereeMarksA >
<CFSET LeagueMarkedA1 = QLeagueMarksA1.RefereeMarkedGamesA >
<CFIF IsNumeric(RefereeMarksH1) IS "No">
	<CFSET RefereeMarksH1 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarkedGamesH1) IS "No">
	<CFSET RefereeMarkedGamesH1 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarksA1) IS "No">
	<CFSET RefereeMarksA1 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarkedGamesA1) IS "No">
	<CFSET RefereeMarkedGamesA1 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarksH1) IS "No">
	<CFSET LeagueMarksH1 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarkedH1) IS "No">
	<CFSET LeagueMarkedH1 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarksA1) IS "No">
	<CFSET LeagueMarksA1 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarkedA1) IS "No">
	<CFSET LeagueMarkedA1 = 0 >
</CFIF>
<!---
************
* season 2 *
************
--->
<cfset DataSrce = "#LeagueCodePrefix##RIGHT(ThisYYYYString,2)#">
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
		<td colspan="3" align="center"><cfoutput><span class="pix13bold">#QRefsID.RName#<BR>Season #ThisYYYYString#-#NextYYYYString#</strong></span></cfoutput></td>
		<td align="center"><span class="pix13">Marks</span></td>
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
<CFSET RefereeMarksH2 = QRefereeH2.SumRefereeMarksH >
<CFSET RefereeMarkedGamesH2 = QRefereeH2.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QRefereeA2.cfm">
<CFSET RefereeMarksA2 = QRefereeA2.SumRefereeMarksA >
<CFSET RefereeMarkedGamesA2 = QRefereeA2.RefereeMarkedGamesA >
<cfinclude template="queries/qry_QLeagueMarksH2.cfm">
<CFSET LeagueMarksH2 = QLeagueMarksH2.SumRefereeMarksH >
<CFSET LeagueMarkedH2 = QLeagueMarksH2.RefereeMarkedGamesH >
<cfinclude template="queries/qry_QLeagueMarksA2.cfm">
<CFSET LeagueMarksA2 = QLeagueMarksA2.SumRefereeMarksA >
<CFSET LeagueMarkedA2 = QLeagueMarksA2.RefereeMarkedGamesA >
<CFIF IsNumeric(RefereeMarksH2) IS "No">
	<CFSET RefereeMarksH2 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarkedGamesH2) IS "No">
	<CFSET RefereeMarkedGamesH2 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarksA2) IS "No">
	<CFSET RefereeMarksA2 = 0 >
</CFIF>
<CFIF IsNumeric(RefereeMarkedGamesA2) IS "No">
	<CFSET RefereeMarkedGamesA2 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarksH2) IS "No">
	<CFSET LeagueMarksH2 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarkedH2) IS "No">
	<CFSET LeagueMarkedH2 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarksA2) IS "No">
	<CFSET LeagueMarksA2 = 0 >
</CFIF>
<CFIF IsNumeric(LeagueMarkedA2) IS "No">
	<CFSET LeagueMarkedA2 = 0 >
</CFIF>

<CFSET RefsMarks = RefereeMarksH1+RefereeMarksA1+RefereeMarksH2+RefereeMarksA2 >
<CFSET RefsMarkedGames = RefereeMarkedGamesH1+RefereeMarkedGamesA1+RefereeMarkedGamesH2+RefereeMarkedGamesA2 >
<CFSET LeagueMarks = LeagueMarksH1+LeagueMarksA1+LeagueMarksH2+LeagueMarksA2 >
<CFSET LeagueMarkedGames = LeagueMarkedH1+LeagueMarkedA1+LeagueMarkedH2+LeagueMarkedA2 >
<BR>
<BR>
<CFIF RefsMarkedGames IS 0 >
	<CFSET RefsMarkedGames = 1 >
</CFIF>
<CFIF LeagueMarkedGames IS 0 >
	<CFSET LeagueMarkedGames = 1 >
</CFIF>
<table  border="1" cellpadding="2" cellspacing="2">
	<tr>
		<td align="center">
			<cfoutput>
			<span class="pix13bold">
			This Referee's Average mark = #NumberFormat(Evaluate(RefsMarks/RefsMarkedGames),"99.999")# (Total marks = #NumberFormat(RefsMarks, "9,999,999")# divided by #RefsMarkedGames# sets of marks)<BR>
			</span>
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td align="center">
			<cfoutput>
			<span class="pix13bold">
			League Average mark = #NumberFormat(Evaluate(LeagueMarks / LeagueMarkedGames),"99.999")# (Total marks = #NumberFormat((LeagueMarks), "9,999,999")# divided by #LeagueMarkedGames# sets of marks)<BR>
			</span>
			</cfoutput>
		</td>
	</tr>
</table>
</cfif>