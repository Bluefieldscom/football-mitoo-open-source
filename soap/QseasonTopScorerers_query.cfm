<cfinclude template="QgetLeagueYearFromDates.cfm">

<!--- top twenty goalscorers in all competitions --->
<cfquery name="QGoalsScored" datasource="#variables.dsn#">

	SELECT 
		a.PlayerID as PlayerID ,
		COALESCE(SUM(a.GoalsScored),0) as Goals
	FROM
		appearance a
		INNER JOIN player p ON p.ID = a.PlayerID
	WHERE
		surname != "OwnGoal"
	GROUP BY
		PlayerID
	ORDER BY
		Goals DESC
	LIMIT 20
</cfquery>
<cfset i=1>
<cfloop query="QGoalsScored">
	<cfscript>
		QTopGoalsArray[#i#] = StructNew();
		QTopGoalsArray[#i#].player_id 			= #PlayerID#;
		QTopGoalsArray[#i#].goals 				= #Goals#;
		i++;
	</cfscript>
</cfloop>
