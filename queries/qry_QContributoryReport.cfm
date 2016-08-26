<!--- called by ContributoryReport.cfm --->

<cfquery name="QContributoryReport" datasource="#request.DSN#">
	SELECT
		DISTINCT 
		
					CASE
				WHEN o.longcol IS NULL THEN t.longcol
				ELSE CONCAT(t.longcol, ' ', o.longcol)
			END
			 as TeamName,
		 c.ID,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND HomeClubOfficialsBenches='Excellent') as HomeClubOfficialsBenchesExcellent,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND HomeClubOfficialsBenches='Good') as HomeClubOfficialsBenchesGood,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND HomeClubOfficialsBenches='Satisfactory') as HomeClubOfficialsBenchesSatisfactory,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND HomeClubOfficialsBenches='Poor') as HomeClubOfficialsBenchesPoor,
		
		(select COUNT(*) FROM fixture WHERE  AwayID = c.ID AND AwayClubOfficialsBenches='Excellent') as AwayClubOfficialsBenchesExcellent,
		(select COUNT(*) FROM fixture WHERE  AwayID = c.ID AND AwayClubOfficialsBenches='Good') as AwayClubOfficialsBenchesGood,
		(select COUNT(*) FROM fixture WHERE  AwayID = c.ID AND AwayClubOfficialsBenches='Satisfactory') as AwayClubOfficialsBenchesSatisfactory,
		(select COUNT(*) FROM fixture WHERE  AwayID = c.ID AND AwayClubOfficialsBenches='Poor') as AwayClubOfficialsBenchesPoor,

		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND StateOfPitch='Excellent') as StateOfPitchExcellent,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND StateOfPitch='Good') as StateOfPitchGood,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND StateOfPitch='Satisfactory') as StateOfPitchSatisfactory,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND StateOfPitch='Poor') as StateOfPitchPoor,
  	 	 	 	 	
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND ClubFacilities='Excellent') as ClubFacilitiesExcellent,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND ClubFacilities='Good') as ClubFacilitiesGood,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND ClubFacilities='Satisfactory') as ClubFacilitiesSatisfactory,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND ClubFacilities='Poor') as ClubFacilitiesPoor,
					
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND Hospitality='Excellent') as HospitalityExcellent,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND Hospitality='Good') as HospitalityGood,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND Hospitality='Satisfactory') as HospitalitySatisfactory,
		(select COUNT(*) FROM fixture WHERE  HomeID = c.ID AND Hospitality='Poor') as HospitalityPoor

	FROM
		division AS d,
		constitution AS c,
		team AS t,		
		ordinal AS o
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">

		AND t.ID NOT IN
			(SELECT ID 
				FROM team 
				WHERE 
					LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
					AND (LEFT(Notes,7) = 'NoScore' 
					OR ShortCol = 'GUEST' 
					OR LongCol IS NULL )) 
		AND c.TeamID = t.ID 
		AND c.OrdinalID = o.ID 
		AND c.DivisionID = d.ID 

	ORDER BY
		 TeamName,  c.ID
</cfquery>

