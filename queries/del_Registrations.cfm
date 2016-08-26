<!--- called from JABDeleteRegistrations.cfm --->

<!--- delete all the registrations for a team - but we can only do this pre-season before any games have been played and before appearances have been added --->


<!--- get the name of the team --->
<cfquery name="QStep1" datasource="#request.DSN#" >
	SELECT LongCol FROM team WHERE ID = #TeamID#
</cfquery>
<cfset ThisTeam = "[#QStep1.LongCol#] ">
<!--- check to see if there are any appearances for this team, if so, abort --->
<cfquery name="QStep2" datasource="#request.DSN#" >
	SELECT * FROM appearance WHERE LeagueCode='#request.filter#' AND PlayerID IN (SELECT PlayerID FROM register WHERE TeamID=#TeamID#) limit 1
</cfquery>
<cfif QStep2.RecordCount GT 0>
	<cfoutput>
		#ThisTeam# - found Player Appearances so can't delete registrations - Press Back Button on Browser</cfoutput>
	<cfabort>
</cfif>

<!--- update the relevant player records with the name of the team in square brackets before deleting the registrations --->
<cfquery name="QStep3" datasource="#request.DSN#" >
	UPDATE
		player
	SET
		notes=Concat('#ThisTeam#', notes) 
	WHERE
		ID IN (SELECT PlayerID FROM register WHERE TeamID=#TeamID#)
		<!--- AND ID NOT IN (SELECT PlayerID FROM appearance WHERE LeagueCode='#request.filter#') --->
		
</cfquery>
  
<cfquery name="QDeleteR" datasource="#request.DSN#" >
	DELETE FROM
		register
	WHERE
		TeamID = #TeamID#
		<!--- AND PlayerID NOT IN (SELECT PlayerID FROM appearance WHERE LeagueCode='#request.filter#') --->
</cfquery>
