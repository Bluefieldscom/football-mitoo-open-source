<!--- called by MtchDayOfficials.cfm --->
		<cfquery name="QRefCount0" datasource="#request.DSN#">
			SELECT 
				f.RefereeID as RID,
				CASE
				WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
				ELSE CONCAT(r.Surname, ", ",r.Forename)
				END
				as RefsName  
			FROM 
				fixture f,
				referee r
			WHERE 
				f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND f.fixturedate='#DateFormat(ThisDate, 'YYYY-MM-DD')#' 
				AND f.RefereeID=r.id 
				AND NOT r.restrictions LIKE '%NoDuplicateWarning%'
			HAVING
				Length(Trim(RefsName)) > 0
				
			UNION ALL
			SELECT 
				f.AsstRef1ID as RID,
				CASE
				WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
				ELSE CONCAT(r.Surname, ", ",r.Forename)
				END
				as RefsName  
			FROM 
				fixture f,
				referee r
			WHERE 
				f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND f.fixturedate='#DateFormat(ThisDate, 'YYYY-MM-DD')#' 
				AND f.AsstRef1ID=r.id 
				AND NOT r.restrictions LIKE '%NoDuplicateWarning%'
			HAVING
				Length(Trim(RefsName)) > 0
				
			UNION ALL
			SELECT 
				f.AsstRef2ID as RID,
				CASE
				WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
				ELSE CONCAT(r.Surname, ", ",r.Forename)
				END
				as RefsName  
			FROM 
				fixture f,
				referee r
			WHERE 
				f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND f.fixturedate='#DateFormat(ThisDate, 'YYYY-MM-DD')#' 
				AND f.AsstRef2ID=r.id 
				AND NOT r.restrictions LIKE '%NoDuplicateWarning%'
			HAVING
				Length(Trim(RefsName)) > 0
		</cfquery>

		<cfquery name="QRefCount1" dbtype="query">
			SELECT 
				RID,
				COUNT(RID) AS refcount, 
				RefsName
			FROM 
				QRefCount0
			GROUP BY
				RID,RefsName
			HAVING
				refcount > 1  
			ORDER BY 
				RefsName
		</cfquery>
 