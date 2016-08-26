<!--- called by ListOfReferees.cfm --->

<CFQUERY NAME="QReferee1" dbtype="query">
	SELECT
		RefID ,
		RefereeName ,
		MediumCol ,
		RefDetails ,
		EmailAddress1 ,
		EmailAddress2
	FROM 
	 	QReferee0
	ORDER BY
		ShortCol, RefereeName
</CFQUERY>
