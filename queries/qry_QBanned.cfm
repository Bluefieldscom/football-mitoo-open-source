<!--- called by CheckRule12SineDie.cfm --->
<cfquery Name="QBanned" datasource="zmast">
	SELECT
		Surname,
		Forename,
		DateOfBirth,
		StartDate,
		Address,
		npd
	FROM
		banned
	WHERE
		surname = '#QSurnamesDobs.surname#'
		AND DateOfBirth = '#dateformat(QSurnamesDobs.DOB, 'YYYY-MM-DD')#'
</cfquery>
