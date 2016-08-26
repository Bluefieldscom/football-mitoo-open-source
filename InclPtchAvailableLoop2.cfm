	<cfif (TRIM(CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')) EQ TRIM(variables.todays_date))>
		<!--- TRIM() required to make them match! --->	
		<cfset is_today = 1>
	<cfelse>
		<cfset is_today = 0>
	</cfif>
	<!--- ========================================================================= just happens that it is today ================================= --->
	
	
	<cfif is_today and ListFind(OKDayList, daycount)> <!--- green --->
		<cfset idx = ListFind(OKDayList, daycount) >
		<td class="PtchOKAvailableToday" >
			<cfset ThisID = ListGetAt(OKPitchavailableIDList, idx) >
			<cfset ThisStatusID = ListGetAt(OKPitchStatusIDList, idx ) >
			<cfset ThisPitchNoID = ListGetAt(OKPitchNoIDList, idx ) >
			<cfset ThisVenueID = ListGetAt(OKVenueIDList, idx ) >
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<cfoutput><strong>#daycount#</strong></cfoutput>  
			<cfelse>
				<cfoutput><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ThisID#&TeamID=#ThisTeamID#&OrdinalID=#ThisOrdinalID#&VenueID=#ThisVenueID#&PitchNoID=#ThisPitchNoID#&PitchStatusID=#ThisStatusID#&LeagueCode=#LeagueCode#&PA=Team&FixtureDate=#DateFormat('#int_Yr#-#int_Mnth#-#daycount#','YYYY-MM-DD')#&month_to_view=#int_Mnth#&year_to_view=#int_Yr#" target="_parent"><strong>#daycount#</strong></a></cfoutput>  
			</cfif>
		</td>
	<cfelseif is_today and ListFind(BADDayList, daycount)> <!--- pink --->
		<cfset idx = ListFind(BADDayList, daycount) >
		<td class="PtchNotOKAvailableToday">
			<cfset ThisID = ListGetAt(BADPitchavailableIDList, idx) >
			<cfset ThisStatusID = ListGetAt(BADPitchStatusIDList, idx ) >
			<cfset ThisPitchNoID = ListGetAt(BADPitchNoIDList, idx ) >
			<cfset ThisVenueID = ListGetAt(BADVenueIDList, idx ) >
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<cfoutput><strong>#daycount#</strong><br>problem</cfoutput>  
			<cfelse>
				<cfoutput><a href="PitchAvailableList.cfm?TblName=PitchAvailable&VenueID=#ThisVenueID#&LeagueCode=#LeagueCode#&PA=Venue" target="_parent"><strong>#daycount#</strong></a><br>problem</cfoutput> 
			</cfif>
		</td>
	<cfelseif is_today> <!--- grey --->
		<td class="non-PtchAvailableToday">
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<cfoutput><strong>#daycount#</strong></cfoutput>  
			<cfelse>
				<cfoutput><a href="UpdateForm.cfm?TblName=PitchAvailable&TeamID=#ThisTeamID#&OrdinalID=#ThisOrdinalID#&VenueID=#QTeamDetails.VenueID#&PitchNoID=#QTeamDetails.PitchNoID#&PitchStatusID=0&LeagueCode=#LeagueCode#&PA=Team&FixtureDate=#DateFormat('#int_Yr#-#int_Mnth#-#daycount#','YYYY-MM-DD')#&month_to_view=#int_Mnth#&year_to_view=#int_Yr#" target="_parent"><strong>#daycount#</strong></a></cfoutput>   
			</cfif>
		</td>
	<!--- ========================================================================= not today ================================= --->
	<cfelseif ListFind(OKDayList, daycount)> <!--- green --->
		<cfset idx = ListFind(OKDayList, daycount) >
		<td class="PtchOKAvailable" >
			<cfset ThisID = ListGetAt(OKPitchavailableIDList, idx) >
			<cfset ThisStatusID = ListGetAt(OKPitchStatusIDList, idx ) >
			<cfset ThisPitchNoID = ListGetAt(OKPitchNoIDList, idx ) >
			<cfset ThisVenueID = ListGetAt(OKVenueIDList, idx ) >
			<cfif ListFind("Yellow",request.SecurityLevel) >
			 	<span class="dropt">
				<cfoutput><a href="" ><strong>#daycount#</strong></a></cfoutput>  
				<span style="width:150px;"><cfoutput>#Replace(ListGetAt(OKVenueNameList, idx ),"'"," ","ALL")# pitch #ListGetAt(OKPitchNumberList, idx)#</cfoutput></span></span> 
			<cfelse>
			 	<span class="dropt">
				<cfoutput><a href="UpdateForm.cfm?TblName=PitchAvailable&id=#ThisID#&TeamID=#ThisTeamID#&OrdinalID=#ThisOrdinalID#&VenueID=#ThisVenueID#&PitchNoID=#ThisPitchNoID#&PitchStatusID=#ThisStatusID#&LeagueCode=#LeagueCode#&PA=Team&FixtureDate=#DateFormat('#int_Yr#-#int_Mnth#-#daycount#','YYYY-MM-DD')#&month_to_view=#int_Mnth#&year_to_view=#int_Yr#" target="_parent"><strong>#daycount#</strong></a></cfoutput>  
				<span style="width:150px;"><cfoutput>#Replace(ListGetAt(OKVenueNameList, idx ),"'"," ","ALL")# pitch #ListGetAt(OKPitchNumberList, idx)#</cfoutput></span></span> 
			
			</cfif>
		</td>
	<cfelseif ListFind(BADDayList, daycount)> <!--- pink --->
		<cfset idx = ListFind(BADDayList, daycount) >
		<td class="PtchNotOKAvailable">
			<cfset ThisID = ListGetAt(BADPitchavailableIDList, idx) >
			<cfset ThisStatusID = ListGetAt(BADPitchStatusIDList, idx ) >
			<cfset ThisPitchNoID = ListGetAt(BADPitchNoIDList, idx ) >
			<cfset ThisVenueID = ListGetAt(BADVenueIDList, idx ) >
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<cfoutput><strong>#daycount#</strong><br>problem</cfoutput>  
			<cfelse>
				<cfoutput><a href="PitchAvailableList.cfm?TblName=PitchAvailable&VenueID=#ThisVenueID#&LeagueCode=#LeagueCode#&PA=Venue" target="_parent"><strong>#daycount#</strong></a><br>problem</cfoutput> 
			</cfif>
		</td>
	<cfelse> <!--- grey --->
		<td class="non-PtchAvailable">
			<cfif ListFind("Yellow",request.SecurityLevel) >
				<cfoutput><strong>#daycount#</strong></cfoutput>  
			<cfelse>
				<cfoutput><a href="UpdateForm.cfm?TblName=PitchAvailable&TeamID=#ThisTeamID#&OrdinalID=#ThisOrdinalID#&VenueID=#QTeamDetails.VenueID#&PitchNoID=#QTeamDetails.PitchNoID#&PitchStatusID=0&LeagueCode=#LeagueCode#&PA=Team&FixtureDate=#DateFormat('#int_Yr#-#int_Mnth#-#daycount#','YYYY-MM-DD')#&month_to_view=#int_Mnth#&year_to_view=#int_Yr#" target="_parent"><strong>#daycount#</strong></a></cfoutput>
			</cfif>	
		</td>
	</cfif>
	