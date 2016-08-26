	<cfif (TRIM(CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')) EQ TRIM(variables.todays_date))>
		<!--- TRIM() required to make them match! --->	
		<cfset is_today = 1>
	<cfelse>
		<cfset is_today = 0>
	</cfif>
	<cfif is_today and ListFind(eventlist, #daycount#)>
		<td class="todayevent">
			<cfoutput><a href="EventCalendarShow.cfm?LeagueCode=#LeagueCode#&event_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#" target="EventCalendar"><strong>#daycount#</strong></a></cfoutput>
		</td>
	<cfelseif is_today>
		<td class="today">
			<cfoutput><a href="EventCalendarAdd.cfm?LeagueCode=#LeagueCode#&event_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#" target="EventCalendar"><strong>#daycount#</strong></a></cfoutput>
		</td>
	<cfelseif ListFind(eventlist, #daycount#)>
		<td class="event">
			<cfoutput><a href="EventCalendarShow.cfm?LeagueCode=#LeagueCode#&event_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#" target="EventCalendar"><strong>#daycount#</strong></a></cfoutput>
		</td>
	<cfelse>
		<td class="non-event">
			<cfoutput><a href="EventCalendarAdd.cfm?LeagueCode=#LeagueCode#&event_date=#CreateODBCDate('#int_Yr#-#int_Mnth#-#daycount#')#" target="EventCalendar"><strong>#daycount#</strong></a></cfoutput>
		</td>
	</cfif>
