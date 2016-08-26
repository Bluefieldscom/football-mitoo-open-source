<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=TeamDetails.xls">
<cfset ThisColSpan = 4 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Team Details</strong></td></tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_QTeamDetails.cfm">
<cfoutput>
<table border="1">
</cfoutput>
<cfoutput query="QTeamDetails">
	<tr>
		<td width="100%"  colspan="#ThisColSpan#" align="center" bgcolor="silver"><strong>#TeamName#</strong></td>
	</tr>

	
	<!--- Contact1 --->
	<cfset Contact1Text1 = "">
	<cfif Len(Trim(Contact1TelNo1Descr)) GT 0 >
		<cfset Contact1Text1 = "#Contact1TelNo1Descr#:">
	</cfif>
	<cfif Len(Trim(Contact1TelNo1)) GT 0 >
		<cfset Contact1Text1 = "<br>#Contact1Text1# #Contact1TelNo1#">
	</cfif>
	
	<cfset Contact1Text2 = "">
	<cfif Len(Trim(Contact1TelNo2Descr)) GT 0 >
		<cfset Contact1Text2 = "#Contact1TelNo2Descr#:">
	</cfif>
	<cfif Len(Trim(Contact1TelNo2)) GT 0 >
		<cfset Contact1Text2 = "<br>#Contact1Text2# #Contact1TelNo2#">
	</cfif>
	
	<cfset Contact1Text3 = "">
	<cfif Len(Trim(Contact1TelNo3Descr)) GT 0 >
		<cfset Contact1Text3 = "#Contact1TelNo3Descr#:">
	</cfif>
	<cfif Len(Trim(Contact1TelNo3)) GT 0 >
		<cfset Contact1Text3 = "<br>#Contact1Text3# #Contact1TelNo3#">
	</cfif>
	
	<cfif Len(Trim("#Contact1JobDescr##Contact1Name##Contact1Text1##Contact1Text2##Contact1Text3#")) GT 0 >
		<tr>
			<td colspan="#ThisColSpan#" align="center" valign="top">Contact1</td>
		</tr>
		<tr>	
			<td colspan="#ThisColSpan#" ><cfif Len(Trim(Contact1JobDescr)) GT 0 >#Contact1JobDescr#:<cfelse></cfif> #Contact1Name#<cfif Len(Trim(Contact1Address)) GT 0 ><br>#Contact1Address#<cfelse></cfif>#Contact1Text1##Contact1Text2##Contact1Text3#<cfif Len(Trim(Contact1Email1)) GT 0><br>Home email: <font face="Courier New, Courier, mono">#Contact1Email1#</font></cfif><cfif Len(Trim(Contact1Email2)) GT 0><br>Work email: <font face="Courier New, Courier, mono">#Contact1Email2#</font></cfif></td> 
		</tr>
	</cfif>
	
	<!--- Contact2 --->
	<cfset Contact2Text1 = "">
	<cfif Len(Trim(Contact2TelNo1Descr)) GT 0 >
		<cfset Contact2Text1 = "#Contact2TelNo1Descr#:">
	</cfif>
	<cfif Len(Trim(Contact2TelNo1)) GT 0 >
		<cfset Contact2Text1 = "<br>#Contact2Text1# #Contact2TelNo1#">
	</cfif>
	<cfset Contact2Text2 = "">
	<cfif Len(Trim(Contact2TelNo2Descr)) GT 0 >
		<cfset Contact2Text2 = "#Contact2TelNo2Descr#:">
	</cfif>
	<cfif Len(Trim(Contact2TelNo2)) GT 0 >
		<cfset Contact2Text2 = "<br>#Contact2Text2# #Contact2TelNo2#">
	</cfif>
	<cfset Contact2Text3 = "">
	<cfif Len(Trim(Contact2TelNo3Descr)) GT 0 >
		<cfset Contact2Text3 = "#Contact2TelNo3Descr#:">
	</cfif>
	<cfif Len(Trim(Contact2TelNo3)) GT 0 >
		<cfset Contact2Text3 = "<br>#Contact2Text3# #Contact2TelNo3#">
	</cfif>
	<cfif Len(Trim("#Contact2JobDescr##Contact2Name##Contact2Text1##Contact2Text2##Contact2Text3#")) GT 0 >
		<tr>
			<td colspan="#ThisColSpan#" align="center" valign="top">Contact2</td>
		</tr>
		<tr>	
			<td colspan="#ThisColSpan#" ><cfif Len(Trim(Contact2JobDescr)) GT 0 >#Contact2JobDescr#:<cfelse></cfif> #Contact2Name#<cfif Len(Trim(Contact2Address)) GT 0 ><br>#Contact2Address#<cfelse></cfif>#Contact2Text1##Contact2Text2##Contact2Text3#<cfif Len(Trim(Contact2Email1)) GT 0><br>Home email: <font face="Courier New, Courier, mono">#Contact2Email1#</font></cfif><cfif Len(Trim(Contact2Email2)) GT 0><br>Work email: <font face="Courier New, Courier, mono">#Contact2Email2#</font></cfif></td> 
		</tr>
	</cfif>
	<!--- Contact3 --->
	<cfset Contact3Text1 = "">
	<cfif Len(Trim(Contact3TelNo1Descr)) GT 0 >
		<cfset Contact3Text1 = "#Contact3TelNo1Descr#:">
	</cfif>
	<cfif Len(Trim(Contact3TelNo1)) GT 0 >
		<cfset Contact3Text1 = "<br>#Contact3Text1# #Contact3TelNo1#">
	</cfif>
	<cfset Contact3Text2 = "">
	<cfif Len(Trim(Contact3TelNo2Descr)) GT 0 >
		<cfset Contact3Text2 = "#Contact3TelNo2Descr#:">
	</cfif>
	<cfif Len(Trim(Contact3TelNo2)) GT 0 >
		<cfset Contact3Text2 = "<br>#Contact3Text2# #Contact3TelNo2#">
	</cfif>
	<cfset Contact3Text3 = "">
	<cfif Len(Trim(Contact3TelNo3Descr)) GT 0 >
		<cfset Contact3Text3 = "#Contact3TelNo3Descr#:">
	</cfif>
	<cfif Len(Trim(Contact3TelNo3)) GT 0 >
		<cfset Contact3Text3 = "<br>#Contact3Text3# #Contact3TelNo3#">
	</cfif>
	<cfif Len(Trim("#Contact3JobDescr##Contact3Name##Contact3Text1##Contact3Text2##Contact3Text3#")) GT 0 >
		<tr>
			<td colspan="#ThisColSpan#" align="center" valign="top">Contact3</td>
		</tr>
		<tr>	
			<td colspan="#ThisColSpan#" ><cfif Len(Trim(Contact3JobDescr)) GT 0 >#Contact3JobDescr#:<cfelse></cfif> #Contact3Name#<cfif Len(Trim(Contact3Address)) GT 0 ><br>#Contact3Address#<cfelse></cfif>#Contact3Text1##Contact3Text2##Contact3Text3#<cfif Len(Trim(Contact3Email1)) GT 0><br>Home email: <font face="Courier New, Courier, mono">#Contact3Email1#</font></cfif><cfif Len(Trim(Contact3Email2)) GT 0><br>Work email: <font face="Courier New, Courier, mono">#Contact3Email2#</font></cfif></td> 
		</tr>
	</cfif>
	
	<tr>
		<td width="100%" colspan="#ThisColSpan#">HOME<br>Shirts: #ShirtColour1#<br>Shorts: #ShortsColour1#<br>Socks: #SocksColour1#</td>
	</tr>
	<tr>
		<td colspan="#ThisColSpan#">AWAY<br>Shirts: #ShirtColour2#<br>Shorts: #ShortsColour2#<br>Socks: #SocksColour2#</td>
	</tr>
	<cfset ThisVenueID = venueid >
	<cfif ThisVenueID GT 0 >
		<cfinclude template="queries/qry_QVenueInformation.cfm">
		<tr>
			<td colspan="#ThisColSpan#" align="center" valign="top">Venue</td>
		</tr>
		<cfset ThisAddressText = '' >
		<cfif Len(Trim(QVenueInformation.AddressLine1)) GT 0 >
			<cfset ThisAddressText = "#ThisAddressText#, #Trim(QVenueInformation.AddressLine1)#" >
		</cfif>
		<cfif Len(Trim(QVenueInformation.AddressLine2)) GT 0 >
			<cfset ThisAddressText = "#ThisAddressText#, #Trim(QVenueInformation.AddressLine2)#" >
		</cfif>
		<cfif Len(Trim(QVenueInformation.AddressLine3)) GT 0 >
			<cfset ThisAddressText = "#ThisAddressText#, #Trim(QVenueInformation.AddressLine3)#" >
		</cfif>
		<cfif Len(Trim(QVenueInformation.PostCode)) GT 0 >
			<cfset ThisAddressText = "#ThisAddressText# #Trim(QVenueInformation.PostCode)#" >
		</cfif>
		<tr>
			<td width="100%" colspan="#ThisColSpan#">#QVenueInformation.VenueDescription##ThisAddressText#</td>
		</tr>
		<cfif Len(Trim(QVenueInformation.VenueTel)) GT 0 >
			<tr>
				<td width="100%" colspan="#ThisColSpan#">Tel: #QVenueInformation.VenueTel#</td>
			</tr>
		</cfif>
	</cfif>

</cfoutput>
</table>
