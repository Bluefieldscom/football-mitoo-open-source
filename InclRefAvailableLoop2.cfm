	<cfif (TRIM(CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')) EQ TRIM(variables.todays_date))>
		<!--- TRIM() required to make them match! --->	
		<cfset is_today = 1>
	<cfelse>
		<cfset is_today = 0>
	</cfif>
	<cfif is_today and ListFind(RefYesAvailableList, #daycount#)>
		<td class="RefYesAvailableToday">
			<cfoutput><a href="RefAvailableUpdDel.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=Y" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	<cfelseif is_today and ListFind(RefNotAvailableList, #daycount#)>
		<td class="RefNotAvailableToday">
			<cfoutput><a href="RefAvailableUpdDel.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=N" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	<cfelseif is_today>
		<td class="non-RefAvailableToday">
			<cfoutput><a href="RefAvailableAdd.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=0" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	<cfelseif ListFind(RefYesAvailableList, #daycount#)>
		<td class="RefYesAvailable">
			<cfoutput><a href="RefAvailableUpdDel.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=Y" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	<cfelseif ListFind(RefNotAvailableList, #daycount#)>
		<td class="RefNotAvailable">
			<cfoutput><a href="RefAvailableUpdDel.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=N" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	<cfelse>
		<td class="non-RefAvailable">
			<cfoutput><a href="RefAvailableAdd.cfm?LeagueCode=#LeagueCode#&match_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#&RefereeID=#URL.RefereeID#&Status=0" target="RefAvailable"><strong>#daycount#</strong></a><cfif ListFind(RefHasAppointmentList, #daycount#)><span class="pix13realblack">&bull;</span></cfif></cfoutput>
		</td>
	</cfif>
