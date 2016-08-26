<!--- called by ListOfReferees.cfm --->

<CFQUERY NAME="QReferee2" dbtype="query">
	SELECT
		RefID ,
		RefereeName ,
		MediumCol ,
		RefDetails
	FROM 
	 	QReferee0
	ORDER BY
		MediumCol, RefereeName
</CFQUERY>
