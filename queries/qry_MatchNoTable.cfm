<!--- called by NewSeason.cfm --->

<cfquery name="QMatchNoTable" datasource="#NewDatabase#">
	SELECT id FROM matchno
</cfquery>
<cfquery name="QPitchNoTable" datasource="#NewDatabase#">
	SELECT id FROM pitchno
</cfquery>
<cfquery name="QPitchStatusTable" datasource="#NewDatabase#">
	SELECT id FROM pitchstatus
</cfquery>

<!--- CHECKING TO SEE IF THESE THREE TABLES EXIST when running New Season --->