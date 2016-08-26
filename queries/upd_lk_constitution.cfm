<!--- called by DeleteLKID.cfm  - get rid of any GUEST teams, 'League' or 'Withdrawn' teams from lk_constitution 

<CFQUERY NAME="Updlkconstitution" datasource="zmast">
	UPDATE
		lk_constitution
	SET #ThisYearsID# = NULL
	WHERE
		ID = #ListElement#
</CFQUERY>


--->
	
	
