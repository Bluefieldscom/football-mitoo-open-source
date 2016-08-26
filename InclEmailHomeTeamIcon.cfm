<cfoutput>
<cfif ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >

	<cfif KOTime IS "" >
		<cfset KOTimeString = "">
	<cfelse>
	  <cfset KOTimeString =  "Kick Off #TimeFormat(KOTime, 'h:mm TT')#" >
	</cfif> 


	<cfif PA_ID IS "">
		<cfset VenueString = "">
	<cfelseif PA_ID IS 0>
		<cfset VenueString = "">
	<cfelse>
		<cfinclude template="queries/qry_QVenueDetails.cfm">	
		<cfif QVenueDetails.RecordCount GT 0>
			<cfset VenueString = "#URLEncodedFormat(QVenueDetails.LongCol)#">
			<cfif Len(Trim(QVenueDetails.AddressLine1)) GT 0>
				<cfset VenueString = "#VenueString#, #URLEncodedFormat(QVenueDetails.AddressLine1)#">
			</cfif>
			<cfif Len(Trim(QVenueDetails.AddressLine2)) GT 0>
				<cfset VenueString = "#VenueString#, #URLEncodedFormat(QVenueDetails.AddressLine2)#">
			</cfif>
			<cfif Len(Trim(QVenueDetails.AddressLine3)) GT 0>
				<cfset VenueString = "#VenueString#, #URLEncodedFormat(QVenueDetails.AddressLine3)#">
			</cfif>
			<cfif Len(Trim(QVenueDetails.PostCode)) GT 0>
				<cfset VenueString = "#VenueString# #URLEncodedFormat(QVenueDetails.PostCode)#">
			</cfif>
			<cfif Len(Trim(QVenueDetails.VenueTel)) GT 0>
				<cfset VenueString = "#VenueString#, #URLEncodedFormat(QVenueDetails.VenueTel)#">
			</cfif>


			<cfif request.fmEmail IS "Web">
				<cfif Len(Trim(QVenueDetails.MapURL)) GT 0>
					<cfset VenueString = "#VenueString#%0d%0asee map #ReplaceList(QVenueDetails.MapURL, Chr(38), '^')# (NOTE: you must replace ^ with ampersand for link to work)">
				</cfif>
			<cfelse>
				<cfif Len(Trim(QVenueDetails.MapURL)) GT 0>
					<cfset VenueString = "#VenueString#%0d%0asee map #URLEncodedFormat(QVenueDetails.MapURL)#">
				</cfif>
			</cfif>




			<cfset VenueString = "#VenueString#%0d%0a">
		<cfelse>
			<cfset VenueString = "Venue NOT FOUND - ERROR">
		</cfif>
	</cfif>
	<cfset MatchOfficialsString = "">
	<cfif RefsName IS NOT "">
		<cfset RefsNameString = "Ref: #RefsFullName#">
		<cfset RefsNotesString = "#ReplaceList(RefsNotes, Chr(34), Chr(32))#" > <!--- speech mark "  to space --->
		<cfset RefsNotesString = "#ReplaceList(RefsNotesString, Chr(38), Chr(32))#" > <!--- ampersand &  to space --->
		<cfset RefsEmailString = "#RefsEmail1# #IIF(RefsEmail2 IS "",DE(""),DE(" also #RefsEmail2#"))#" >
		<cfset MatchOfficialsString = "#MatchOfficialsString#%0d%0a#RefsNameString# #RefsNotesString#%0d%0a">
	</cfif>
	<cfif AR1Name IS NOT "">
		<cfset AR1NameString = "Asst1: #AR1FullName#">
		<cfset AR1NotesString = "#ReplaceList(AR1Notes, Chr(34), Chr(32))#" > <!--- speech mark "  to space --->
		<cfset AR1NotesString = "#ReplaceList(AR1NotesString, Chr(38), Chr(32))#" > <!--- ampersand &  to space --->
		<cfset AR1EmailString = "#AR1Email1# #IIF(AR1Email2 IS "",DE(""),DE(" also #AR1Email2#"))#" >
		<cfset MatchOfficialsString = "#MatchOfficialsString#%0d%0a#AR1NameString# #AR1NotesString#%0d%0a">
	</cfif>
	<cfif AR2Name IS NOT "">
		<cfset AR2NameString = "Asst2: #AR2FullName#">
		<cfset AR2NotesString = "#ReplaceList(AR2Notes, Chr(34), Chr(32))#" > <!--- speech mark "  to space --->
		<cfset AR2NotesString = "#ReplaceList(AR2NotesString, Chr(38), Chr(32))#" > <!--- ampersand &  to space --->
		<cfset AR2EmailString = "#AR2Email1# #IIF(AR2Email2 IS "",DE(""),DE(" also #AR2Email2#"))#" >
		<cfset MatchOfficialsString = "#MatchOfficialsString#%0d%0a#AR2NameString# #AR2NotesString#%0d%0a">
	</cfif>
	<cfif FourthOfficialName IS NOT "">
		<cfset FourthOfficialNameString = "4th: #FourthOfficialFullName#">
		<cfset FourthOfficialNotesString = "#ReplaceList(FourthOfficialNotes, Chr(34), Chr(32))#" > <!--- speech mark "  to space --->
		<cfset FourthOfficialNotesString = "#ReplaceList(FourthOfficialNotesString, Chr(38), Chr(32))#" > <!--- ampersand &  to space --->
		<cfset FourthOfficialEmailString = "#FourthOfficialEmail1# #IIF(FourthOfficialEmail2 IS "",DE(""),DE(" also #FourthOfficialEmail2#"))#" >
		<cfset MatchOfficialsString = "#MatchOfficialsString#%0d%0a#FourthOfficialNameString# #FourthOfficialNotesString#%0d%0a">
	</cfif>
	<cfif AssessorName IS NOT "">
		<cfset AssessorNameString = "Assessor: #AssessorFullName#">
		<cfset AssessorNotesString = "#ReplaceList(AssessorNotes, Chr(34), Chr(32))#" > <!--- speech mark "  to space --->
		<cfset AssessorNotesString = "#ReplaceList(AssessorNotesString, Chr(38), Chr(32))#" > <!--- ampersand &  to space --->
		<cfset AssessorEmailString = "#AssessorEmail1# #IIF(AssessorEmail2 IS "",DE(""),DE(" also #AssessorEmail2#"))#" >
		<cfset MatchOfficialsString = "#MatchOfficialsString#%0d%0a#AssessorNameString# #AssessorNotesString#%0d%0a">
	</cfif>
	<cfset EmailString = "">
	<cfset MatchString = "#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal#">
	<cfset MatchString = ReplaceList(MatchString, Chr(34), Chr(32))> <!--- speech mark "  to space --->
	<cfset MatchString = ReplaceList(MatchString, Chr(38), 'and' )> <!--- ampersand &  to space --->
	<cfset MatchString = URLEncodedFormat(MatchString)>
	
	<cfset CompetitionString = ReplaceList(DivName1, Chr(34), Chr(32))> <!--- speech mark "  to space --->
	<cfset CompetitionString = ReplaceList(CompetitionString, Chr(38), 'and' )> <!--- ampersand &  to space --->
	
	<cfset EmailSubject = URLEncodedFormat("Match Date: #DateFormat(MDate, 'DD MMM')# - #CompetitionString# - #LeagueName# - SENT: #DateFormat(Now(), 'DDDD, DD MMMM YYYY')# at #TimeFormat(Now(), 'HH:MM')#")>
	<cfset EmailBody = "#URLEncodedFormat(KOTimeString)#%0d%0a#VenueString#%0d%0a#URLEncodedFormat(FixtureNotes)#%0d%0a%0d%0a#MatchString#%0d%0a#MatchOfficialsString#">
	

	<!--- added May 2009 --->
										<!---
											****************
											* HOME DETAILS *
											****************
										--->
	<cfset HomeDetails = "">
	<cfset ThisTeamID=HomeTeamID>
	<cfset ThisOrdinalID=HomeOrdinalID>
	<cfinclude template="queries/qry_TeamDetails.cfm">	
	<cfif QTeamDetails.RecordCount IS 1>
		<cfset HomeDetails = "=Home Team=%0d%0a">
		<!---
		<cfset HomeDetails = "#HomeDetails#H: Shirt: #QTeamDetails.ShirtColour1#, Shorts: #QTeamDetails.ShortsColour1#, Socks: #QTeamDetails.SocksColour1#%0d%0a">
		<cfset HomeDetails = "#HomeDetails#A: Shirt: #QTeamDetails.ShirtColour2#, Shorts: #QTeamDetails.ShortsColour2#, Socks: #QTeamDetails.SocksColour2#%0d%0a">
		--->
		<cfset HomeDetails = "#HomeDetails#%0d%0aContact 1:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact1JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact1JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset HomeDetails = "#HomeDetails##JobDescr##QTeamDetails.Contact1Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact1Address AND Len(Trim(QTeamDetails.Contact1Address)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact1Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact1TelNo1 AND Len(Trim(QTeamDetails.Contact1TelNo1)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact1TelNo1Descr# #QTeamDetails.Contact1TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact1TelNo2 AND Len(Trim(QTeamDetails.Contact1TelNo2)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact1TelNo2Descr# #QTeamDetails.Contact1TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact1TelNo3 AND Len(Trim(QTeamDetails.Contact1TelNo3)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact1TelNo3Descr# #QTeamDetails.Contact1TelNo3#%0d%0a">
		</cfif>
		<cfset HomeDetails = "#HomeDetails#%0d%0aContact 2:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact2JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact2JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset HomeDetails = "#HomeDetails##JobDescr##QTeamDetails.Contact2Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact2Address AND Len(Trim(QTeamDetails.Contact2Address)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact2Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact2TelNo1 AND Len(Trim(QTeamDetails.Contact2TelNo1)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact2TelNo1Descr# #QTeamDetails.Contact2TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact2TelNo2 AND Len(Trim(QTeamDetails.Contact2TelNo2)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact2TelNo2Descr# #QTeamDetails.Contact2TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact2TelNo3 AND Len(Trim(QTeamDetails.Contact2TelNo3)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact2TelNo3Descr# #QTeamDetails.Contact2TelNo3#%0d%0a">
		</cfif>
		<cfset HomeDetails = "#HomeDetails#%0d%0aContact 3:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact3JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact3JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset HomeDetails = "#HomeDetails##JobDescr##QTeamDetails.Contact3Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact3Address AND Len(Trim(QTeamDetails.Contact3Address)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact3Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact3TelNo1 AND Len(Trim(QTeamDetails.Contact3TelNo1)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact3TelNo1Descr# #QTeamDetails.Contact3TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact3TelNo2 AND Len(Trim(QTeamDetails.Contact3TelNo2)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact3TelNo2Descr# #QTeamDetails.Contact3TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact3TelNo3 AND Len(Trim(QTeamDetails.Contact3TelNo3)) GT 0 >
			<cfset HomeDetails = "#HomeDetails##QTeamDetails.Contact3TelNo3Descr# #QTeamDetails.Contact3TelNo3#%0d%0a">
		</cfif>
		
		<cfset HomeDetails = ReplaceList(HomeDetails, Chr(34), Chr(32))> <!--- speech mark "  to space --->
		<cfset HomeDetails = ReplaceList(HomeDetails, Chr(38), 'and' )> <!--- ampersand &  to space --->

		<cfset EmailAddressee = QTeamDetails.Contact1Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact1Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact2Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact2Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact3Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact3Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	</cfif>
										<!---
											****************
											* AWAY DETAILS *
											****************
										--->
	<cfset AwayDetails = "">
	<cfset ThisTeamID=AwayTeamID>
	<cfset ThisOrdinalID=AwayOrdinalID>
	<cfinclude template="queries/qry_TeamDetails.cfm">	
	<cfif QTeamDetails.RecordCount IS 1>
		<cfset AwayDetails = "=Away Team=%0d%0a">
		<!---
		<cfset AwayDetails = "#AwayDetails#H: Shirt: #QTeamDetails.ShirtColour1#, Shorts: #QTeamDetails.ShortsColour1#, Socks: #QTeamDetails.SocksColour1#%0d%0a">
		<cfset AwayDetails = "#AwayDetails#A: Shirt: #QTeamDetails.ShirtColour2#, Shorts: #QTeamDetails.ShortsColour2#, Socks: #QTeamDetails.SocksColour2#%0d%0a">
		--->
		<cfset AwayDetails = "#AwayDetails#%0d%0aContact 1:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact1JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact1JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset AwayDetails = "#AwayDetails##JobDescr##QTeamDetails.Contact1Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact1Address AND Len(Trim(QTeamDetails.Contact1Address)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact1Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact1TelNo1 AND Len(Trim(QTeamDetails.Contact1TelNo1)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact1TelNo1Descr# #QTeamDetails.Contact1TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact1TelNo2 AND Len(Trim(QTeamDetails.Contact1TelNo2)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact1TelNo2Descr# #QTeamDetails.Contact1TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact1TelNo3 AND Len(Trim(QTeamDetails.Contact1TelNo3)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact1TelNo3Descr# #QTeamDetails.Contact1TelNo3#%0d%0a">
		</cfif>
		<cfset AwayDetails = "#AwayDetails#%0d%0aContact 2:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact2JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact2JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset AwayDetails = "#AwayDetails##JobDescr##QTeamDetails.Contact2Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact2Address AND Len(Trim(QTeamDetails.Contact2Address)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact2Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact2TelNo1 AND Len(Trim(QTeamDetails.Contact2TelNo1)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact2TelNo1Descr# #QTeamDetails.Contact2TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact2TelNo2 AND Len(Trim(QTeamDetails.Contact2TelNo2)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact2TelNo2Descr# #QTeamDetails.Contact2TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact2TelNo3 AND Len(Trim(QTeamDetails.Contact2TelNo3)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact2TelNo3Descr# #QTeamDetails.Contact2TelNo3#%0d%0a">
		</cfif>
		<cfset AwayDetails = "#AwayDetails#%0d%0aContact 3:%0d%0a">
		<cfif Len(Trim(QTeamDetails.Contact3JobDescr)) GT 0><cfset JobDescr="#QTeamDetails.Contact3JobDescr#: "><cfelse><cfset JobDescr=""></cfif>
		<cfset AwayDetails = "#AwayDetails##JobDescr##QTeamDetails.Contact3Name#%0d%0a">
		<!---
		<cfif NOT QTeamDetails.ShowHideContact3Address AND Len(Trim(QTeamDetails.Contact3Address)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact3Address#%0d%0a">
		</cfif>
		--->
		<cfif NOT QTeamDetails.ShowHideContact3TelNo1 AND Len(Trim(QTeamDetails.Contact3TelNo1)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact3TelNo1Descr# #QTeamDetails.Contact3TelNo1#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact3TelNo2 AND Len(Trim(QTeamDetails.Contact3TelNo2)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact3TelNo2Descr# #QTeamDetails.Contact3TelNo2#%0d%0a">
		</cfif>
		<cfif NOT QTeamDetails.ShowHideContact3TelNo3 AND Len(Trim(QTeamDetails.Contact3TelNo3)) GT 0 >
			<cfset AwayDetails = "#AwayDetails##QTeamDetails.Contact3TelNo3Descr# #QTeamDetails.Contact3TelNo3#%0d%0a">
		</cfif>
		
		<cfset AwayDetails = ReplaceList(AwayDetails, Chr(34), Chr(32))> <!--- speech mark "  to space --->
		<cfset AwayDetails = ReplaceList(AwayDetails, Chr(38), 'and' )> <!--- ampersand &  to space --->

		<cfset EmailAddressee = QTeamDetails.Contact1Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact1Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact2Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact2Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact3Email1 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
		<cfset EmailAddressee = QTeamDetails.Contact3Email2 >
		<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	</cfif>
	
	<cfset EmailAddressee = RefsEmail1 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = RefsEmail2 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AR1Email1 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AR1Email2 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AR2Email1 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AR2Email2 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = FourthOfficialEmail1 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = FourthOfficialEmail2 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AssessorEmail1 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	<cfset EmailAddressee = AssessorEmail2 >
	<cfif LEN(TRIM(EmailAddressee)) GT 0 ><cfset EmailString = "#EmailString##EmailAddressee#,"></cfif>
	
	<cfset EmailString = TRIM(EmailString)>


	<!--- added June 2011 --->
										<!---
											**************
											* CC DETAILS *
											**************
										--->
	<cfset CCPeople = " and <br>">
	<cfset CCAddress = "">
	<cfinclude template="queries/qry_QCommittee.cfm">	
	<cfif QCommittee.RecordCount GT 0>
		<cfloop query="QCommittee">
			<cfif CCEmailAddress1 IS 1 OR CCEmailAddress2 IS 1 >
				<cfset CCPeople = "#CCPeople##MemberName#<br>" >
			</cfif>
			<cfif CCEmailAddress1 IS 1 AND Len(Trim(EmailAddress1)) GT 0 >
				<cfset CCAddress = "#CCAddress##EmailAddress1#," >
			</cfif>
			<cfif CCEmailAddress2 IS 1 AND Len(Trim(EmailAddress2)) GT 0 >
				<cfset CCAddress = "#CCAddress##EmailAddress2#," >
			</cfif>
		</cfloop>
		<cfif CCPeople IS " and <br>">
			<cfset CCPeople = "">
		</cfif>
		<cfif LEN(CCAddress) GT 2>
			<cfset CCAddress = Left(CCAddress, LEN(CCAddress)-1)> <!--- remove final comma --->		
		</cfif>
	</cfif>

	
	
	<cfif LEN(EmailString) GT 0 >
		<cfif request.fmEmail IS "Web">
		<!--- use this for web based email such as Gmail  --->
			<cfset EmailString = Left(EmailString, LEN(EmailString)-1)> <!--- remove final comma --->
			<cfset EmailBody = "#EmailBody#%0d%0a#HomeDetails#%0d%0a#AwayDetails#"> 
			<cfif CCAddress IS "">
				<cfset MailToString = "mailto:#EmailString#?subject=#EmailSubject#%26body=#EmailBody#" >
			<cfelse>
				<cfset MailToString = "mailto:#EmailString#?subject=#EmailSubject#%26body=#EmailBody#" >
				<cfset MailToString = "#MailToString#%26cc=#CCAddress#" >
			</cfif>
		<cfelseif request.fmEmail IS "Desktop">
			<!--- use this for client based email such as Outlook or Thunderbird  ---> 
			<cfset EmailString = Left(EmailString, LEN(EmailString)-1)> <!--- remove final comma --->
			<cfset EmailBody = "#EmailBody#%0d%0a#HomeDetails#%0d%0a#AwayDetails#"> 
			<cfif CCAddress IS "">
				<cfset MailToString = "mailto:#EmailString#?subject=#EmailSubject#&body=#EmailBody#" >
			<cfelse>
				<cfset MailToString = "mailto:#EmailString#?subject=#EmailSubject#&body=#EmailBody#" >
				<cfset MailToString = "#MailToString#&cc=#CCAddress#" >
			</cfif>
		<cfelse>
			ERROR 37 - InclEmailHoeTeamIcon.cfm
			<cfabort>
		</cfif>

		
		<cfset TooltipText="Currently set to <u>#request.fmEmail# Based</u> email.<br><br><u><em>IMPORTANT: tell us what kind of email program you use! - see new Email option on Home screen</em></u><br><br> Open an email to the home team contacts, away team contacts and the match officials">
		<cfif Len(Trim(CCPeople)) GT 0>
			<cfset TooltipText = "#TooltipText##CCPeople#" >
		</cfif>
					
		<a href="#MailToString#" target="_blank" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=400;return escape('#TooltipText#')"><img src="gif/EmailEnvelope.gif" border=0 align="absmiddle"></a>

		<cfif LEN(MailToString) GT 1800 >WARNING - email too long
		</cfif>

	</cfif>
</cfif>
</cfoutput>
