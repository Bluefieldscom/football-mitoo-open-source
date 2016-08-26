<!--- called by Action.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template="queries/qry_QConstitution.cfm">

<!--- if they are trying to change the team or ordinal drop-downs and this side have fixtures 
and/or results in the KO competition then we must prevent them from updating --->
<cfif ListFind("Skyblue",request.SecurityLevel) AND ((QConstitution.TeamID IS NOT Form.TeamID) OR (QConstitution.OrdinalID IS NOT Form.OrdinalID)) >
	<cfset CI = QConstitution.ID >
	<cfinclude template="queries/qry_QFixtures_v3.cfm">
	<cfif QFixtures.RecordCount GT 0>
		<br /><br />
		<table width="80%" border="1" align="center" cellpadding="2" cellspacing="2">
			<cfoutput query="QFixtures">
				<tr>
					<td><span class="pix13">#DateFormat(FixtureDate, 'DDD, DD MMMM YYYY')#</span></td>
					<td><cfif QConstitution.ID IS HomeID><span class="pix13boldred"><cfelse><span class="pix13"></cfif>#HomeTeam# #HomeOrdinal#</span><span class="pix13"> #Homegoals# v #Awaygoals# </span><cfif QConstitution.ID IS AwayID><span class="pix13boldred"><cfelse><span class="pix13"></cfif>#AwayTeam# #AwayOrdinal#</span></td>
				</tr>
			</cfoutput>
			<tr>
				<td colspan="2"><span class="pix24boldred">These games have already been played or scheduled so you can't change the team details. Press the Back button on your browser. Please contact INSERT_EMAIL_HERE if you need help or advice.</span></td>
			</tr>
		</table>
		<cfabort>
	</cfif>
</cfif>
	
<!--- if there is no change in key fields --->
<cfif
	QConstitution.TeamID IS Form.TeamID AND
	QConstitution.OrdinalID IS Form.OrdinalID AND
	QConstitution.DivisionID IS Form.DivisionID >
	<!--- don't bother to check for duplicates --->
<cfelse>
<!--- If there's been a change in TeamID, OrdinalID or DivisionID
Check to see if this combination is already in the Constitution --->
	<cfinclude template="queries/qry_QCheckDuplicateC.cfm">
	<cfif QCheckDuplicateC.RecordCount IS NOT "0">	
		<cfoutput query="QCheckDuplicateC">
			<span class="pix24boldred">#TeamName# #OrdinalName# is already in #DivisionName#<BR><BR>
			Press the Back button on your browser....
			</span>
		</cfoutput>
		<CFABORT>
	</cfif>
</cfif>
<cfset PointsAdjustment = 0 > <!--- most of the time this is zero --->
<cfif StructKeyExists(form, "PointsAdjustment" ) AND IsNumeric(form.PointsAdjustment)>
	<cfset PointsAdjustment = form.PointsAdjustment >
</cfif>
<!--- FIRST, do the update, because the duplicate tests must look at the latest Constitution table ---->
<cfinclude template="queries/upd_Constitution.cfm">
<!--- Then check for duplicate Match Numbers........... --->
<cfinclude template="InclCheckMatchNos.cfm">
