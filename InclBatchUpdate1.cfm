<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfset ErrorText = "">
<cfset InptCount = 0>

<cfoutput>
	
	<CFLOOP index="I" from="2" to="500" step="1">
		<!--- PerfectLine is a flag ... Posit the line is good.... --->
		<cfset PerfectLine = "Yes" >
		<cfset LineString = #Trim(GetToken(Form.BatchInput, I, CHR(10) )) #>
		<!--- Check the opening curly brace --->
		<cfif PerfectLine IS "Yes">
			<cfif Left(LineString,1) IS NOT "{" >
				<cfset PerfectLine = "No" >
			<cfelse>
				<cfset ErrorText = "#ErrorText##LineString#<BR>">
			</cfif>
		</cfif>
		
		<!--- Check the LeagueCode --->
		<cfif PerfectLine IS "Yes">
			<cfset BLeagueCode = #GetToken(Linestring, 1, "," )#>
			<cfset BLeagueCode = #Replace(BLeagueCode, "{", "", "ALL")#>			
			<cfif BLeagueCode IS NOT LeagueCode  >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">LeagueCodeerror: #BLeagueCode# <BR><BR></span>'>
			</cfif>
		</cfif>
		
		<!--- Check the TeamID --->
		<cfif PerfectLine IS "Yes">
			<cfset BTeamID = GetToken(Linestring, 1, "}" ) >
			<cfset BTeamID = Reverse(BTeamID) >
			<cfset BTeamID = GetToken(BTeamID, 1, "," ) >
			<cfset BTeamID = Trim(Reverse(BTeamID)) >
			<cfif IsNumeric(BTeamID) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">TeamID error: #BTeamID# <BR><BR></span>'>				
			</cfif>
		</cfif>

		
		<!--- Check the Surname --->
		<cfif PerfectLine IS "Yes">
			<cfset Surname = #GetToken(Linestring, 1, "]")#>
			<cfset Surname = #Reverse(Surname)#>
			<cfset Surname = #GetToken(Surname, 1, "[")#>
			<cfset Surname = #Trim(Reverse(Surname))#>
		</cfif>
		<!--- Check the Forename --->
		<cfif PerfectLine IS "Yes">
			<cfset Forename = #GetToken(Linestring, 2, "]")#>
			<cfset Forename = #Reverse(Forename)#>
			<cfset Forename = #GetToken(Forename, 1, "[")#>
			<cfset Forename = #Trim(Reverse(Forename))#>
		</cfif>
		<!--- Check the DOB --->
		<cfif PerfectLine IS "Yes">
			<cfset DOB = #GetToken(Linestring, 3, "]")#>
			<cfset DOB = #Reverse(DOB)#>
			<cfset DOB = #GetToken(DOB, 1, "[")#>
			<cfset DOB = #Trim(Reverse(DOB))#>
			<cfif Trim(DOB) IS "">
			<!--- a blank DOB is acceptable --->
			<cfelse>
				<cfset yyyy = Left(DOB,4) >
				<cfif IsNumeric(yyyy) IS "No" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif Mid(DOB,5,1) IS NOT "-" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfset mm = Trim(Mid(DOB,6,2)) >
				<cfif IsNumeric(mm) IS "No" >
					<cfset PerfectLine = "No" >
				<cfelseif mm GT 12 >
					<cfset PerfectLine = "No" >
				<cfelseif mm LT 1 >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif Mid(DOB,8,1) IS NOT "-" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfset dd = Trim(Mid(DOB,9,2)) >
				<cfif IsNumeric(dd) IS "No" >
					<cfset PerfectLine = "No" >
				<cfelseif dd GT 31 >
					<cfset PerfectLine = "No" >
				<cfelseif dd LT 1 >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif PerfectLine IS "No">
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">DOB error: #DOB# <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>
		<!--- Check the Player Reg No --->
		<cfif PerfectLine IS "Yes">
			<cfset PlayerRegNo = #GetToken(Linestring, 4, "]")#>
			<cfset PlayerRegNo = #Reverse(PlayerRegNo)#>
			<cfset PlayerRegNo = #GetToken(PlayerRegNo, 1, "[")#>
			<cfset PlayerRegNo = #Trim(Reverse(PlayerRegNo))#>
			<cfif IsNumeric(PlayerRegNo) IS "No" >
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Player Reg No error: #PlayerRegNo# <BR><BR></span>'>				
			</cfif>
		</cfif>
		<!--- Check the Player Notes --->
		<cfif PerfectLine IS "Yes">
			<cfset PlayerNotes = #GetToken(Linestring, 5, "]")#>
			<cfset PlayerNotes = #Reverse(PlayerNotes)#>
			<cfset PlayerNotes = #GetToken(PlayerNotes, 1, "[")#>
			<cfset PlayerNotes = #Trim(Reverse(PlayerNotes))#>
		</cfif>
		<!--- Check the First Day --->
		<cfif PerfectLine IS "Yes">
			<cfset FirstDay  = #GetToken(Linestring, 6, "]")#>
			<cfset FirstDay = #Reverse(FirstDay)#>
			<cfset FirstDay = #GetToken(FirstDay, 1, "[")#>
			<cfset FirstDay = #Trim(Reverse(FirstDay))#>
			<cfif Trim(FirstDay) IS "">
			<!--- a blank DOB is acceptable --->
			<cfelse>
				<cfset yyyy = Left(FirstDay,4) >
				<cfif IsNumeric(yyyy) IS "No" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif Mid(FirstDay,5,1) IS NOT "-" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfset mm = Trim(Mid(FirstDay,6,2)) >
				<cfif IsNumeric(mm) IS "No" >
					<cfset PerfectLine = "No" >
				<cfelseif mm GT 12 >
					<cfset PerfectLine = "No" >
				<cfelseif mm LT 1 >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif Mid(FirstDay,8,1) IS NOT "-" >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfset dd = Trim(Mid(FirstDay,9,2)) >
				<cfif IsNumeric(dd) IS "No" >
					<cfset PerfectLine = "No" >
				<cfelseif dd GT 31 >
					<cfset PerfectLine = "No" >
				<cfelseif dd LT 1 >
					<cfset PerfectLine = "No" >
				</cfif>
				<cfif PerfectLine IS "No">
					<cfset ErrorText = '#ErrorText# <span class="pix10boldred">First Day error: #FirstDay# <BR><BR></span>'>
				</cfif>
			</cfif>
		</cfif>
		<!--- Check the Registration Type --->
		<cfif PerfectLine IS "Yes">
			<cfset RegistrationType = #GetToken(Linestring, 7, "]")#>
			<cfset RegistrationType = #Reverse(RegistrationType)#>
			<cfset RegistrationType = #GetToken(RegistrationType, 1, "[")#>
			<cfset RegistrationType = #Trim(Reverse(RegistrationType))#>
			<cfif RegistrationType IS "Non-Contract">
			<cfelseif RegistrationType IS "Contract">
			<cfelseif RegistrationType IS "On Loan">
			<cfelse>
				<cfset PerfectLine = "No">
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Registration Type error: #RegistrationType# <BR><BR></span>'>
			</cfif>
		</cfif>
		<!--- Check the FAN --->
		<cfif PerfectLine IS "Yes">
			<cfset FAN = #GetToken(Linestring, 8, "]")#>
			<cfset FAN = #Reverse(FAN)#>
			<cfset FAN = #GetToken(FAN, 1, "[")#>
			<cfset FAN = #Trim(Reverse(FAN))#>
			<cfif FAN IS "">
			<cfelseif IsNumeric(FAN)>
			<cfelse>
				<cfset PerfectLine = "No">
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">FAN error: #FAN# <BR><BR></span>'>
			</cfif>
		</cfif>
		<cfif PerfectLine IS "Yes">
			<cfinclude template="queries/qry_QPlayerRegNo.cfm">		
			
			<cfif QPlayerRegNo.RecordCount IS NOT 0>
				<cfset PerfectLine = "No" >
				<cfset ErrorText = '#ErrorText# <span class="pix10boldred">Player Reg. No. #PlayerRegNo# is already used by #QPlayerRegNo.Forename# <u>#QPlayerRegNo.Surname#</u><BR><BR></span>'>
			</cfif>
		</cfif>
		
		<cfif PerfectLine IS "Yes">
			<cfset MediumCol = #DOB#>
			<cfset ShortCol  = #PlayerRegNo#>
			<cfset Notes     = #PlayerNotes#>
			<cfinclude template="queries/ins_Player.cfm">
			<!--- Get the ID of this new row in the Player table --->
			<cfinclude template="queries/qry_QPlayerRegNo.cfm">
			<cfif QPlayerRegNo.RecordCount IS NOT 1>
				Batch Input processing aborted......
				<cfabort >
			</cfif>
			<cfset PlayerID = #QPlayerRegNo.ID#>
			<cfif RegistrationType IS "Non-Contract">
				<cfset RegType = "A">
			<cfelseif RegistrationType IS "Contract">
				<cfset RegType = "B">
			<cfelseif RegistrationType IS "Short Loan">
				<cfset RegType = "C">
			<cfelseif RegistrationType IS "Long Loan">
				<cfset RegType = "D">
			<cfelseif RegistrationType IS "Work Experience">
				<cfset RegType = "E">
			<cfelseif RegistrationType IS "Lapsed">
				<cfset RegType = "G">
			<cfelseif RegistrationType IS "Temporary">
				<cfset RegType = "F">
			<cfelse>
				<cfset RegType = "X">
			</cfif>
			<cfinclude template="queries/ins_RegisterBatch.cfm">
			
			
			<cfset ErrorText = '#ErrorText# <span class="pix10boldgreen">Updated OK <BR><BR></span>'>
			<cfset InptCount = InptCount + 1>
		</cfif>															

	</cfloop>
</cfoutput>	
	

<cfoutput>
	<span class="pix18bold">Batch Input Report<BR><BR></span>

	
	<cfif Trim(ErrorText) IS "">
		<span class="pix13">Nothing to report.<BR><BR></span>
	<cfelse>
		<span class="pix13">#ErrorText#<BR><BR></span>
		
		<span class="pix18boldgreen">Input Total #InptCount#<BR><BR></span>
		
	</cfif>
	
	<span class="pix18bold">Please press the "Back" button on your browser to continue.....</span>
</cfoutput>
