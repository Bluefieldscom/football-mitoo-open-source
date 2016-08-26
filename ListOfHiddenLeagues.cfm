<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--- LEAVE THIS STYLESHEET BELOW - it is needed when generating HTM files for each County --->
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>List of HIDDEN Leagues</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>

                                         
<cfinclude template="queries/qry_QListOfHiddenLeagues.cfm">
<cfset NumberOfLeagues = QListOfHiddenLeagues.RecordCount>
<table   border="1" align="center" cellpadding="2" cellspacing="0" valign="MIDDLE">
	<cfoutput>
		<tr>
			<td colspan="8" align="CENTER">
			<a href="fmMap.cfm" ADDTOKEN="NO"><img src="mitoo_logo1.png" alt="fmlogo" border="0"></a></td>
		</tr>
	</cfoutput>
	<cfset DefaultLeagueCodeList=ValueList(QListOfHiddenLeagues.DefaultLeagueCode)>
	<cfset LeagueNameList=ValueList(QListOfHiddenLeagues.LeagueName)>
	<cfset SeasonNameList=ValueList(QListOfHiddenLeagues.SeasonName)>
	<cfset HideThisSeasonList=ValueList(QListOfHiddenLeagues.HideThisSeason)>
	<cfset NameSortList=ValueList(QListOfHiddenLeagues.NameSort)>
	<cfset LeagueBrandList=ValueList(QListOfHiddenLeagues.LeagueBrand)>
	<cfset DefaultYouthLeagueList=ValueList(QListOfHiddenLeagues.DefaultYouthLeague)>
	<cfset CountiesListList=ValueList(QListOfHiddenLeagues.CountiesList,"~")>
	<cfloop index="I" from="1" to="#NumberOfLeagues#" step="1">
		<tr>
			<cfoutput>
			<cfset DefaultLeagueCode = ListGetAt(DefaultLeagueCodeList, I)>
			<cfset request.filter = Left(DefaultLeagueCode, (Len(TRIM(DefaultLeagueCode))-4))>
			<cfset LeagueName =	ListGetAt(LeagueNameList, I)>
			<cfset SeasonName =	ListGetAt(SeasonNameList, I)>
			<cfset HideThisSeason =	ListGetAt(HideThisSeasonList, I)>
			<cfset NameSort = ListGetAt(NameSortList, I)>
			<cfset LeagueBrand = ListGetAt(LeagueBrandList, I)>
			<cfset DefaultYouthLeague = ListGetAt(DefaultYouthLeagueList, I)>
			<cfset CountiesList = ListGetAt(CountiesListList, I, "~")>

						<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid, 4=FootballAssociation,5=RefereesAssociation --->
						<CFSWITCH expression="#LeagueBrand#">
						
							<CFCASE VALUE="0">
								<cfset ThisClass = "white"> <!--- Normal --->
								<td>&nbsp;</td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="1">
								<cfset ThisClass = "bg_yellow"> <!--- National League System --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">National<BR>League<BR>System</span></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="2">
								<cfset ThisClass = "bg_lightgreen"> <!--- Womens Football Pyramid --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">Womens<BR>Football<BR>Pyramid</span></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="3">
								<cfset ThisClass = "white"> <!--- Normal --->
								<td></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="4">
								<cfset ThisClass = "bg_highlight"> <!--- Football Association --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">County<BR>F.A.</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="5">
								<cfset ThisClass = "bg_highlight2"> <!--- Referees Association --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">County<BR>R.A.</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>

							<CFCASE VALUE="6">
								<cfset ThisClass = "bg_highlight2"> <!--- Girls --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">Girls</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>
								
						</CFSWITCH>
			
			<td width="20"><a href="LeagueInfoUpdate.cfm?LeagueCode=#DefaultLeagueCode#"><span class="pix10bold">look</span></a></td>
			<!---
			<td>
				<a href="ShowContacts.cfm?LeagueCode=#DefaultLeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="#DefaultLeagueCode#Contacts"><span class="pix10bold">Contacts</span></a>				
			</td>
			--->
			<cfif DefaultYouthLeague>
				<td><span class="pix13boldred">#DefaultLeagueCode#</span><cfif HideThisSeason IS 1><span class="pix10boldnavy"><br>HIDDEN</span></cfif> </td>
			<cfelse>
				<td><span class="pix13">#DefaultLeagueCode#</span><cfif HideThisSeason IS 1><span class="pix10boldnavy"><br>HIDDEN</span></cfif></td>
			</cfif>
			<cfif ListFind("Silver",request.SecurityLevel) >
				<td><span class="pix10">#LEFT(CountiesList,100)#     </span></td>
			<cfelse>
				<td colspan="3"><span class="pix10">#LEFT(CountiesList,100)#</span></td>
			</cfif>
			</cfoutput>
		</tr>
	</cfloop>
	<tr>
		<td colspan="7" align="center"><span class="pix10">Total = <cfoutput>#NumberOfLeagues#</cfoutput></span></td>
	</tr>

	<tr bgcolor="beige">
		<td colspan="7" align="center"><span class="pix18"><strong>MISSING</strong></span></td>
	</tr>
	<cfset NumberOfLeagues = QListOfPreviousLeagues.RecordCount>


	<cfset DefaultLeagueCodeList=ValueList(QListOfPreviousLeagues.DefaultLeagueCode)>
	<cfset LeagueNameList=ValueList(QListOfPreviousLeagues.LeagueName)>
	<cfset SeasonNameList=ValueList(QListOfPreviousLeagues.SeasonName)>
	<cfset HideThisSeasonList=ValueList(QListOfPreviousLeagues.HideThisSeason)>
	<cfset NameSortList=ValueList(QListOfPreviousLeagues.NameSort)>
	<cfset LeagueBrandList=ValueList(QListOfPreviousLeagues.LeagueBrand)>
	<cfset DefaultYouthLeagueList=ValueList(QListOfPreviousLeagues.DefaultYouthLeague)>
	<cfset CountiesListList=ValueList(QListOfPreviousLeagues.CountiesList,"~")>
	<cfloop index="I" from="1" to="#NumberOfLeagues#" step="1">
		<tr bgcolor="beige">
			<cfoutput>
			<cfset DefaultLeagueCode = ListGetAt(DefaultLeagueCodeList, I)>
			<cfset request.filter = Left(DefaultLeagueCode, (Len(TRIM(DefaultLeagueCode))-4))>
			<cfset LeagueName =	ListGetAt(LeagueNameList, I)>
			<cfset SeasonName =	ListGetAt(SeasonNameList, I)>
			<cfset HideThisSeason =	ListGetAt(HideThisSeasonList, I)>
			<cfset NameSort = ListGetAt(NameSortList, I)>
			<cfset LeagueBrand = ListGetAt(LeagueBrandList, I)>
			<cfset DefaultYouthLeague = ListGetAt(DefaultYouthLeagueList, I)>
			<cfset CountiesList = ListGetAt(CountiesListList, I, "~")>

						<!--- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid, 4=FootballAssociation,5=RefereesAssociation --->
						<CFSWITCH expression="#LeagueBrand#">
						
							<CFCASE VALUE="0">
								<cfset ThisClass = "white"> <!--- Normal --->
								<td>&nbsp;</td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="1">
								<cfset ThisClass = "bg_yellow"> <!--- National League System --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">National<BR>League<BR>System</span></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="2">
								<cfset ThisClass = "bg_lightgreen"> <!--- Womens Football Pyramid --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">Womens<BR>Football<BR>Pyramid</span></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="3">
								<cfset ThisClass = "white"> <!--- Normal --->
								<td></td>
								<td class="#ThisClass#"><span class="pix13">#NameSort#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="4">
								<cfset ThisClass = "bg_highlight"> <!--- Football Association --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">County<BR>F.A.</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="5">
								<cfset ThisClass = "bg_highlight2"> <!--- Referees Association --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">County<BR>R.A.</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>
							
							<CFCASE VALUE="6">
								<cfset ThisClass = "bg_highlight2"> <!--- Girls --->
								<td align="CENTER" class="#ThisClass#"><span class="pix10">Girls</span></td>
								<td class="#ThisClass#"><span class="pix13">#LeagueName#</span></td>
							</CFCASE>
						</CFSWITCH>
			
			<td width="20"><a href="LeagueInfoUpdate.cfm?LeagueCode=#DefaultLeagueCode#"><span class="pix10bold">look</span></a></td>
			<!---
			<td>
				<a href="ShowContacts.cfm?LeagueCode=#DefaultLeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="#DefaultLeagueCode#Contacts"><span class="pix10bold">Contacts</span></a>				
			</td>
			--->
			<cfif DefaultYouthLeague>
				<td><span class="pix13boldred">#DefaultLeagueCode#</span><cfif HideThisSeason IS 1><span class="pix10boldnavy"><br>HIDDEN</span></cfif> </td>
			<cfelse>
				<td><span class="pix13">#DefaultLeagueCode#</span><cfif HideThisSeason IS 1><span class="pix10boldnavy"><br>HIDDEN</span></cfif></td>
			</cfif>
			<cfif ListFind("Silver",request.SecurityLevel) >
				<td><span class="pix10">#LEFT(CountiesList,100)#     </span></td>
			<cfelse>
				<td colspan="3"><span class="pix10">#LEFT(CountiesList,100)#</span></td>
			</cfif>
			</cfoutput>
		</tr>
	</cfloop>
	<tr bgcolor="beige">
		<td colspan="7" align="center"><span class="pix10">Total = <cfoutput>#NumberOfLeagues#</cfoutput></span></td>
	</tr>


</table>

</body>
</html>