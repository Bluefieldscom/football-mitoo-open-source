<!--- called by RefsPromotionReport.cfm --->

<cfquery name="QRefsID" datasource="#DataSrce#">
	SELECT
		ID as RID,
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		ELSE CONCAT(Forename, " ", Surname)
		END
		as RName
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	HAVING
		RName LIKE '%#TRIM(form.RefsSurname)#%'
	ORDER BY
		RName <!--- LongCol --->
</cfquery>

