<!--- called by DeleteLKID.cfm  - get rid of any GUEST teams, 'League' or 'Withdrawn' teams from lk_constitution 
<CFQUERY NAME="Dellkconstitution" datasource="zmast">
	DELETE FROM
		lk_constitution
	WHERE
		ID IN (#InList#)
</CFQUERY>
--->
	
	
