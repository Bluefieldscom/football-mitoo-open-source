<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition
If it is, then we'll jump over to Knock Out History instead
--->
<cfsilent>
<CFPARAM name="KO" default="No">

<cfinclude template="queries/qry_QKnockOut.cfm">

<cfif Left(QKnockOut.Notes,2) IS "KO" >
<!--- Jumping here.... --->
	<CFLOCATION URL=
		"KOHist.cfm?TblName=Matches&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" 
				ADDTOKEN="NO">
</cfif>

<cfif     Left(QKnockOut.Notes,2) IS "P1" > 
	<cfset NoOfMeetings = 1>
<cfelseif Left(QKnockOut.Notes,2) IS "P3" >
	<cfset NoOfMeetings = 3>
<cfelseif Left(QKnockOut.Notes,2) IS "P4" >
	<cfset NoOfMeetings = 4>
<cfelse>
	<cfset NoOfMeetings = 2> <!--- "Normal" teams play each other twice a season, home and away --->
</cfif>

<!--- HideGoals will suppress Goals For, Goals Against and Goal Difference columns --->
<cfif Find( "HideGoals", QKnockOut.Notes )>
	<cfset HideGoals = "Yes">
<cfelse>
	<cfset HideGoals = "No">
</cfif>
<!--- HideGoalDiff will suppress Goal Difference columns --->
<cfif Find( "HideGoalDiff", QKnockOut.Notes )>
	<cfset HideGoalDiff = "Yes">
<cfelse>
	<cfset HideGoalDiff = "No">
</cfif>
<!--- HideDivision will suppress everything for this Division --->
<cfif Find( "HideDivision", QKnockOut.Notes )>
	<cfset HideDivision = "Yes">
<cfelse>
	<cfset HideDivision = "No">
</cfif>
<cfif Find( "SuppressTable", QKnockOut.Notes )>
	<cfset SuppressTable = "Yes">
<cfelse>
	<cfset SuppressTable = "No">
</cfif>

<cfif QKnockOut.CompetitionDescription IS "Miscellaneous" OR QKnockOut.CompetitionDescription IS "Friendly" >
	<cfset SuppressLeagueTable = "Yes">
<cfelse>
	<cfset SuppressLeagueTable = "No">
</cfif>



<!--- find out the number of rows to highlight at the top and bottom of a league table thereby indicating teams in a promotion/relegation positions
only a single digit is allowed, this should be plenty for every type of league, typically it will be one, two or three --->

<cfset PromotedRows = 0 >
<cfset RelegatedRows = 0 >

<cfset p = FindNoCase("Promoted=",QKnockOut.Notes) >
<cfif p GT 0 >
	<cfset PromotedRows = Mid(QKnockOut.Notes, (p+9), 1) >
	<cfif NOT IsNumeric(PromotedRows)>
		<cfset PromotedRows = 0 >
	</cfif>
</cfif>
<cfset r = FindNoCase("Relegated=",QKnockOut.Notes) >
<cfif r GT 0 >
	<cfset RelegatedRows = Mid(QKnockOut.Notes, (r+10), 1) >
	<cfif NOT IsNumeric(RelegatedRows)>
		<cfset RelegatedRows = 0 >
	</cfif>
</cfif>

<cfinclude template="queries/qry_QGetPointsAdjust.cfm">

</cfsilent>

<cfif NoOfMeetings IS 1>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other once only</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 3>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other three times</span></td>
		</tr>
	</table>
<cfelseif NoOfMeetings IS 4>
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Teams play each other four times</span></td>
		</tr>
	</table>
<cfelse>

</cfif>

<cfif HideGoals IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Goals For, Goals Against and Goal Difference columns have been hidden at the League's request</span></td>
		</tr>
	</table>
</cfif>
<cfif HideGoalDiff IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">Goal Difference column has been hidden at the League's request</span></td>
		</tr>
	</table>
</cfif>
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND SuppressTable IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<td align="CENTER"><span class="pix10">This has been suppressed at the League's request</span></td>
		</tr>
	</table>
	<CFABORT>
</cfif>
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND SuppressLeagueTable IS "Yes">
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<cfoutput>
			<td align="CENTER"><span class="pix10">#QKnockOut.CompetitionDescription# League Table has been suppressed</span></td>
			</cfoutput>
		</tr>
	</table>
	<CFABORT>
</cfif>
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND HideDivision IS "Yes"  >
	<table width="100%" border="0" cellspacing="2" cellpadding="0" >
		<tr>
			<cfoutput>
			<td align="CENTER"><span class="pix10">#QKnockOut.CompetitionDescription# League Table is not published</span></td>
			</cfoutput>
		</tr>
	</table>
	<CFABORT>
</cfif>
<!---	
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.fmTeamID = session.fmTeamID>
</cflock>
--->
<cfset ThisDivisionID = DivisionID >
<cfinclude template="queries/qry_QNewLeagueTable.cfm">
<cfif QNewLeagueTable.RecordCount IS 0 >
	<cfinclude template="RefreshLeagueTable.cfm">
	<!---    <cfinclude template="InclAdjustNewLeagueTableRows.cfm">    Re-Order rows where maximum played and same number of points and same goal difference --->
	<cfinclude template="queries/qry_QNewLeagueTable.cfm">
</cfif>
<cfinclude template="InclNewLeagueTable.cfm">   <!--- Display the Normal League Table --->

<!--- Now, underneath the League Table, in small font, let's display any team's non-match-specific points adjustment --->
<table  border="0" cellspacing="2" cellpadding="0" >
	<cfoutput query="QNewLeagueTable">
		<cfif PointsAdjustment IS 0 >
		<cfelse>
			<tr bgcolor="White">
				<td align="LEFT" >
					<span class="pix10">
						#Name# [#NumberFormat(PointsAdjustment,"+9")# points]
					</span>
				</td>
			</tr>
		</cfif>
	</cfoutput>
</table>
<!--- 
underneath the League Table 
display all the Awarded games and points adjustments 
--->
<table border="0" cellspacing="2" cellpadding="0" >
	<cfoutput query="QGetPointsAdjust">
	  	<cfset Highlight = "No">
		<cfif request.fmTeamID IS HomeTeamID>
			<cfset Highlight = "Yes">
		</cfif>
		<cfif request.fmTeamID IS AwayTeamID>
			<cfset Highlight = "Yes">
		</cfif>
		<tr bgcolor="White">
			<td align="LEFT" <cfif Highlight>class="bg_highlight"</cfif> >
				<span class="pix10">
					#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#:
					<cfif HomePointsAdjust IS NOT 0>[#NumberFormat(HomePointsAdjust,"+9")# <cfif HomePointsAdjust IS 1 OR HomePointsAdjust IS -1>point<cfelse>points</cfif>]</cfif> #HomeTeamName# #HomeOrdinal#
						 #HomeGoals# v #AwayGoals#
					#AwayTeamName# #AwayOrdinal# <cfif AwayPointsAdjust IS NOT 0>[#NumberFormat(AwayPointsAdjust,"+9")# <cfif AwayPointsAdjust IS 1 OR AwayPointsAdjust IS -1>point<cfelse>points</cfif>]</cfif>
					<cfif AwardedResult IS "H" >
						- Home Win was awarded
					<cfelseif AwardedResult IS "A" >
						- Away Win was awarded
					<cfelseif AwardedResult IS "D" >
						- Draw was awarded
					<cfelseif AwardedResult IS "W" >
						- Void
					<cfelse>
					</cfif>
				</span>
			</td>
		</tr>
	</cfoutput>
</table>
<!--- next, underneath the Awarded games and points adjustments display various buttons....... 
Fixtures & Results Grid
Leading Goalscorers
Attendance Statistics
Expanded League Table
.... etc
--->
<table width="100%" border="0" cellpadding="0" cellspacing="5">
	<tr>
		<td valign="top">
			<table>
				<cfset DivisionName = Getlong.CompetitionDescription>
				<cfinclude template="InclLeagueTabButtons.cfm">
				<!--- Now allow the user to send a plain old email of the league table.
				Of course, only do all the extra processing if he has opted to receive stuff
				 Firstly, get the longest team name. --->
				<cfif Len(Trim(request.EmailAddr)) GT 0 >
					<cfinclude template="InclLeagueTabEmail.cfm">
				</cfif>
				
				<cfoutput>
					<tr>
						<td>
							<span class="pix10">
								<cfif Len(Trim(request.EmailAddr)) IS 0 >
									Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to receive a <strong>Printer Friendly</strong> email of this League Table.
								<cfelse>
									An email of this league table has been sent to <b>#request.EmailAddr#</b><BR>Please click <a href="EmailSetUpForm.cfm?LeagueCode=#LeagueCode#"><b>here</b></a> to change the email address or to turn off automatic emails.
								</cfif>
							</span>
						</td>
						<cfif Len(Trim(request.EmailAddr)) GT 0 >
							<cfinclude template="inclInsrtEmailAddr.cfm"> 
							<cfmail to="#request.EmailAddr#" from="#request.EmailAddr#" subject="#SubjectString#" type="text" >#LgTblText#      #UnderTblTxt##CHR(10)#
							
							
							
							
								#CHR(10)#*** Please Note ***#CHR(10)#For the columns to line up properly you must view this table in a FIXED WIDTH FONT e.g. Courier New
							</cfmail>
						</cfif>
					</tr>
				</cfoutput>
			</table>
		</td>
		<td> <!-- align="center">-->
			<cfinclude template="InclLeagueTabAdvertsTbl.cfm">
		</td>
	</tr>
</table>

<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<!--- added Jan 26 2010 - bypass subsite tags if logged in as JAB or Administrator --->
<cfelse>
	<cfif DefaultYouthLeague IS 0> <!--- Adult League --->
		<!-- utarget Ad code -->
		<script language="JavaScript">
		var now = new Date();
		var nIndex = now.getTime();
		document.write('<s' + 'cript src="http://www.utarget.co.uk/scriptinject.aspx?h=2077&nocache=' + nIndex + '">');
		document.write('</' + 's' + 'cript>');
		</script>
		<!-- utarget Ad code Ends -->
	<cfelseif DefaultYouthLeague IS 1> <!--- Youth League --->
		<!-- utarget Ad code -->
		<script language="JavaScript">
		var now = new Date();
		var nIndex = now.getTime();
		document.write('<s' + 'cript src="http://www.utarget.co.uk/scriptinject.aspx?h=2075&nocache=' + nIndex + '">');
		document.write('</' + 's' + 'cript>');
		</script>
		<!-- utarget Ad code Ends -->
	</cfif>
</cfif>