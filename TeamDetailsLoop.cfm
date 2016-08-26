<cfoutput>
<cfset TextString = "<b>Normal Venue:</b>">

<cfif VenueAndPitchAvailable IS "Yes">
	<cfif VenueID GT 0 >
		<cfset ThisVenueID = venueid >
		<cfinclude template="queries/qry_QVenueInformation.cfm">
		<cfif QVenueInformation.RecordCount IS 0>
			<cfset TextString = "Normal Venue not specified">
		<cfelse>
			<cfset TextString = "#TextString# #Trim(QVenueInformation.VenueDescription)#" >
			<cfif Len(Trim(QVenueInformation.AddressLine1)) GT 0 >
				<cfset TextString = "#TextString#, #Trim(QVenueInformation.AddressLine1)#" >
			</cfif>
			<cfif Len(Trim(QVenueInformation.AddressLine2)) GT 0 >
				<cfset TextString = "#TextString#, #Trim(QVenueInformation.AddressLine2)#" >
			</cfif>
			<cfif Len(Trim(QVenueInformation.AddressLine3)) GT 0 >
				<cfset TextString = "#TextString#, #Trim(QVenueInformation.AddressLine3)#" >
			</cfif>
			<cfif Len(Trim(QVenueInformation.PostCode)) GT 0 >
				<cfset TextString = "#TextString# #Trim(QVenueInformation.PostCode)#" >
			</cfif>
			<cfif Len(Trim(QVenueInformation.VenueTel)) GT 0 >
				<cfset TextString = "#TextString#&nbsp;&nbsp;Tel: #QVenueInformation.VenueTel#" >
			</cfif>
			<cfif Len(Trim(QVenueInformation.MapURL)) GT 0 >
				<cfset TextString = "#TextString#&nbsp;&nbsp;<a href='#Trim(QVenueInformation.MapURL)#' 'target=_blank'><img src='images/icon_map.png' border='0' align='absmiddle'></a>" >
			</cfif>
		</cfif>
	<cfelse>
		<cfset TextString = "Normal Venue not specified">
	</cfif>
	<tr>
		<td bgcolor="lightgreen"><span class="pix10">#TextString#</span>
		<cfif TextString IS NOT "Normal Venue not specified" AND ListFind("Silver,Skyblue",request.SecurityLevel)><span class="pix10">&nbsp;&nbsp;&nbsp;<a href="UpdateForm.cfm?TblName=Venue&ID=#ThisVenueID#&LeagueCode=#LeagueCode#">upd/del</a> venue</span></cfif>
		</td>
	</tr>
</cfif>


<cfset TextString = "<b>Home Colours:</b>">
<cfif Len(Trim(ShirtColour1)) GT 0>
	<cfset TextString = "#TextString# #Trim(ShirtColour1)# shirts,">
</cfif>
<cfif Len(Trim(ShortsColour1)) GT 0>
	<cfset TextString = "#TextString# #Trim(ShortsColour1)# shorts,">
</cfif>
<cfif Len(Trim(SocksColour1)) GT 0>
	<cfset TextString = "#TextString# #Trim(SocksColour1)# socks">
</cfif>
<cfset TextString = "#TextString#&nbsp;&nbsp;<b>Away Colours:</b>">
<cfif Len(Trim(ShirtColour2)) GT 0>
	<cfset TextString = "#TextString# #Trim(ShirtColour2)# shirts,">
</cfif>
<cfif Len(Trim(ShortsColour2)) GT 0>
	<cfset TextString = "#TextString# #Trim(ShortsColour2)# shorts,">
</cfif>
<cfif Len(Trim(SocksColour2)) GT 0>
	<cfset TextString = "#TextString# #Trim(SocksColour2)# socks">
</cfif>
<tr>
	<td colspan="2"><span class="pix10">#TextString#</span></td>
</tr>
<!---
<cfif Len(Trim(URLTeamWebsite)) GT 0>
	<tr>
		<td width="50%" align="right">
			<span class="pix10">URL Team Website:</span>
		</td>
		<td width="50%" align="left">
			<span class="pix10">#URLTeamWebsite#</span>
		</td>
	</tr>
</cfif>
<cfif Len(Trim(URLTeamPhoto)) GT 0>
	<tr>
		<td width="50%" align="right">
			<span class="pix10">URL Team Photo:</span>
		</td>
		<td width="50%" align="left">
			<span class="pix10">#URLTeamPhoto#</span>
		</td>
	</tr>
</cfif>
--->

<!---
*************
* Contact 1 *
*************
--->
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cfset TextString = "<b>Contact 1:</b>">
	<cfif Len(Trim(Contact1Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact1Name)#,">
	</cfif>
	<cfif Len(Trim(Contact1JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact1JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact1Address)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact1Address)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo1Descr)) GT 0 AND ShowHideContact1TelNo1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo1)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo2Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo2)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo3Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo3)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact1Email1)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact1Email1)#?subject=#TN# - #LN#'>#Trim(Contact1Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact1Email2)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact1Email2)#?subject=#TN# - #LN#'>#Trim(Contact1Email2)#</a>">
	</cfif>
<cfelse>
	<cfset TextString = "<b>Contact 1:</b>">
	<cfif Len(Trim(Contact1Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact1Name)#,">
	</cfif>
	<cfif Len(Trim(Contact1JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact1JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact1Address)) GT 0 AND ShowHideContact1Address IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact1Address)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo1Descr)) GT 0 AND ShowHideContact1TelNo1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo1)) GT 0 AND ShowHideContact1TelNo1 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo2Descr)) GT 0 AND ShowHideContact1TelNo2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo2)) GT 0 AND ShowHideContact1TelNo2 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact1TelNo3Descr)) GT 0 AND ShowHideContact1TelNo3 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact1TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact1TelNo3)) GT 0 AND ShowHideContact1TelNo3 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact1TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact1Email1)) GT 0 AND ShowHideContact1Email1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact1Email1)#?subject=#TN# - #LN#'>#Trim(Contact1Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact1Email2)) GT 0 AND ShowHideContact1Email2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact1Email2)#?subject=#TN# - #LN#'>#Trim(Contact1Email2)#</a>">
	</cfif>
</cfif>
<tr>
	<td colspan="2"><span class="pix10">#TextString#</span></td>
</tr>

<!---
*************
* Contact 2 *
*************
--->
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cfset TextString = "<b>Contact 2:</b>">
	<cfif Len(Trim(Contact2Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact2Name)#,">
	</cfif>
	<cfif Len(Trim(Contact2JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact2JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact2Address)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact2Address)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo1Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo1)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo2Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo2)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo3Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo3)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact2Email1)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact2Email1)#?subject=#TN# - #LN#'>#Trim(Contact2Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact2Email2)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact2Email2)#?subject=#TN# - #LN#'>#Trim(Contact2Email2)#</a>">
	</cfif>
<cfelse>
	<cfset TextString = "<b>Contact 2:</b>">
	<cfif Len(Trim(Contact2Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact2Name)#,">
	</cfif>
	<cfif Len(Trim(Contact2JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact2JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact2Address)) GT 0 AND ShowHideContact2Address IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact2Address)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo1Descr)) GT 0 AND ShowHideContact2TelNo1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo1)) GT 0 AND ShowHideContact2TelNo1 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo2Descr)) GT 0 AND ShowHideContact2TelNo2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo2)) GT 0 AND ShowHideContact2TelNo2 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact2TelNo3Descr)) GT 0 AND ShowHideContact2TelNo3 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact2TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact2TelNo3)) GT 0 AND ShowHideContact2TelNo3 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact2TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact2Email1)) GT 0 AND ShowHideContact2Email1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact2Email1)#?subject=#TN# - #LN#'>#Trim(Contact2Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact2Email2)) GT 0 AND ShowHideContact2Email2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact2Email2)#?subject=#TN# - #LN#'>#Trim(Contact2Email2)#</a>">
	</cfif>
</cfif>
<tr>
	<td colspan="2"><span class="pix10">#TextString#</span></td>
</tr>

<!---
*************
* Contact 3 *
*************
--->
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cfset TextString = "<b>Contact 3:</b>">
	<cfif Len(Trim(Contact3Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact3Name)#,">
	</cfif>
	<cfif Len(Trim(Contact3JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact3JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact3Address)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact3Address)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo1Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo1)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo2Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo2)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo3Descr)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo3)) GT 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact3Email1)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact3Email1)#?subject=#TN# - #LN#'>#Trim(Contact3Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact3Email2)) GT 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact3Email2)#?subject=#TN# - #LN#'>#Trim(Contact3Email2)#</a>">
	</cfif>
<cfelse>
	<cfset TextString = "<b>Contact 3:</b>">
	<cfif Len(Trim(Contact3Name)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact3Name)#,">
	</cfif>
	<cfif Len(Trim(Contact3JobDescr)) GT 0>
		<cfset TextString = "#TextString# #Trim(Contact3JobDescr)#,">
	</cfif>
	<cfif Len(Trim(Contact3Address)) GT 0 AND ShowHideContact3Address IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact3Address)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo1Descr)) GT 0 AND ShowHideContact3TelNo1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo1Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo1)) GT 0 AND ShowHideContact3TelNo1 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo1)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo2Descr)) GT 0 AND ShowHideContact3TelNo2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo2Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo2)) GT 0 AND ShowHideContact3TelNo2 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo2)#">
	</cfif>
	<cfif Len(Trim(Contact3TelNo3Descr)) GT 0 AND ShowHideContact3TelNo3 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[#Trim(Contact3TelNo3Descr)#]">
	</cfif>
	<cfif Len(Trim(Contact3TelNo3)) GT 0 AND ShowHideContact3TelNo3 IS 0 >
		<cfset TextString = "#TextString# #Trim(Contact3TelNo3)#">
	</cfif>
	<cfset TN = ReplaceList(TeamName, Chr(38), 'and')>
	<cfset LN = ReplaceList(LeagueName, Chr(38), 'and')>
	<cfif Len(Trim(Contact3Email1)) GT 0 AND ShowHideContact3Email1 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[H]<a href='mailto:#Trim(Contact3Email1)#?subject=#TN# - #LN#'>#Trim(Contact3Email1)#</a>">
	</cfif>
	<cfif Len(Trim(Contact3Email2)) GT 0 AND ShowHideContact3Email2 IS 0 >
		<cfset TextString = "#TextString#&nbsp;&nbsp;[W]<a href='mailto:#Trim(Contact3Email2)#?subject=#TN# - #LN#'>#Trim(Contact3Email2)#</a>">
	</cfif>
</cfif>	
<tr>
	<td colspan="2"><span class="pix10">#TextString#</span></td>
</tr>
<cfset ThisEmailString = "">
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cfif Len(Trim(Contact1Email1)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact1Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact1Email2)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact1Email2)#,">
	</cfif>
	<cfif Len(Trim(Contact2Email1)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact2Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact2Email2)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact2Email2)#,">
	</cfif>
	<cfif Len(Trim(Contact3Email1)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact3Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact3Email2)) GT 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact3Email2)#,">
	</cfif>
<cfelse>
	<cfif Len(Trim(Contact1Email1)) GT 0 AND ShowHideContact1Email1 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact1Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact1Email2)) GT 0 AND ShowHideContact1Email2 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact1Email2)#,">
	</cfif>
	<cfif Len(Trim(Contact2Email1)) GT 0 AND ShowHideContact2Email1 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact2Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact2Email2)) GT 0 AND ShowHideContact2Email2 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact2Email2)#,">
	</cfif>
	<cfif Len(Trim(Contact3Email1)) GT 0 AND ShowHideContact3Email1 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact3Email1)#,">
	</cfif>
	<cfif Len(Trim(Contact3Email2)) GT 0 AND ShowHideContact3Email2 IS 0 >
		<cfset ThisEmailString = "#ThisEmailString##Trim(Contact3Email2)#,">
	</cfif>
</cfif>

<!--- Need to be logged in to see this report 
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>
--->





<!---
<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif ThisTID IS NOT "#request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>
--->
		<cfif TRIM(OrdinalName) IS "">
			<cfset TeamText = "#TN# First Team">
		<cfelse>
			<cfset TeamText = "#TeamName# #OrdinalName#">
		</cfif>
		<cfset LenThisEmailString = Len(Trim(ThisEmailString))>
		<cfif LenThisEmailString GT 0 >
			<cfset ThisEmailString = Left(ThisEmailString, (LenThisEmailString-1))>
			<tr>
				<td>
					<table border="0" align="center" cellpadding="2" cellspacing="2" bgcolor="beige">
						<tr>
							<td height="40" colspan="2" align="center"><span class="pix10bold">#TeamText#: <a href="mailto:#ThisEmailString#?subject=#TN# - #LN#">Email Contacts</a></span></td>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>


</cfoutput>
