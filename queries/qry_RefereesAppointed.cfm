<!--- called by MtchDay.cfm --->

<cfquery name="RefereesAppointed" datasource="#request.DSN#">
	SELECT f.ID as FID,  d.ID as DID, c1.ID as HomeID, c2.ID as AwayID, r.ID as RID, r.EmailAddress1, r.EmailAddress2, 
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
		r.Notes as RefNotes,
		r.Restrictions,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
         'Referee' as role, d.LongCol as Competition, k.LongCol as KORoundName, r.shortcol as refsort, 
		 t1.LongCol as HomeTeam, o1.LongCol as HomeOrdinal, t2.LongCol as AwayTeam, o2.LongCol as AwayOrdinal, 
		 CASE WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 THEN r.LongCol ELSE CONCAT(r.Surname, ", ", r.Forename) END as RefsName, r.PromotionCandidate, r.Restrictions, r.Level, r.Notes as RefNotes
		 FROM referee r 
		 	LEFT JOIN refavailable ra ON ra.RefereeID = r.ID AND ra.MatchDate = '#DateFormat(MDate,"YYYY-MM-DD")#' 
		 	LEFT JOIN fixture f ON f.RefereeID = r.ID  
		 	LEFT JOIN constitution c1 ON c1.ID = f.HomeID 
		 	LEFT JOIN constitution c2 ON c2.ID = f.AwayID 
		 	LEFT JOIN team t1 ON c1.TeamID = t1.ID 
		 	LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID 
		 	LEFT JOIN team t2 ON c2.TeamID = t2.ID 
		 	LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID 
		 	LEFT JOIN division d ON c1.DivisionID = d.ID 
		 	LEFT JOIN koround k ON f.KORoundID = k.ID  
		 where f.leaguecode = '#request.filter#' and f.FixtureDate='#DateFormat(MDate,"YYYY-MM-DD")#' and r.LongCol IS NOT NULL
	 and r.ShortCol IS NOT NULL UNION ALL
	SELECT f.ID as FID,  d.ID as DID, c1.ID as HomeID, c2.ID as AwayID, r.ID as RID, r.EmailAddress1, r.EmailAddress2, 
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
		r.Notes as RefNotes,
		r.Restrictions,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
		'Assistant 1' as role, d.LongCol as Competition, k.LongCol as KORoundName, r.shortcol as refsort, 
		t1.LongCol as HomeTeam, o1.LongCol as HomeOrdinal, t2.LongCol as AwayTeam, o2.LongCol as AwayOrdinal, 
		CASE WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 THEN r.LongCol ELSE CONCAT(r.Surname, ", ", r.Forename) END as RefsName, r.PromotionCandidate, r.Restrictions, r.Level, r.Notes as RefNotes 
		FROM referee r 
			LEFT JOIN refavailable ra ON ra.RefereeID = r.ID AND ra.MatchDate = '#DateFormat(MDate,"YYYY-MM-DD")#' 
			LEFT JOIN fixture f ON f.AsstRef1ID = r.ID  
			LEFT JOIN constitution c1 ON c1.ID = f.HomeID 
			LEFT JOIN constitution c2 ON c2.ID = f.AwayID 
			LEFT JOIN team t1 ON c1.TeamID = t1.ID 
			LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID 
			LEFT JOIN team t2 ON c2.TeamID = t2.ID 
			LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID 
			LEFT JOIN division d ON c1.DivisionID = d.ID 
			LEFT JOIN koround k ON f.KORoundID = k.ID  
		where f.leaguecode = '#request.filter#' and f.FixtureDate='#DateFormat(MDate,"YYYY-MM-DD")#' and r.LongCol IS NOT NULL and r.ShortCol IS NOT NULL UNION ALL
	SELECT f.ID as FID,  d.ID as DID, c1.ID as HomeID, c2.ID as AwayID, r.ID as RID, r.EmailAddress1, r.EmailAddress2, 
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
		r.Notes as RefNotes,
		r.Restrictions,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
		'Assistant 2' as role, d.LongCol as Competition, k.LongCol as KORoundName, r.shortcol as refsort, 
		t1.LongCol as HomeTeam, o1.LongCol as HomeOrdinal, t2.LongCol as AwayTeam, o2.LongCol as AwayOrdinal, 
		CASE WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 THEN r.LongCol ELSE CONCAT(r.Surname, ", ", r.Forename) END as RefsName, r.PromotionCandidate, r.Restrictions, r.Level, r.Notes as RefNotes 
		FROM referee r 
			LEFT JOIN refavailable ra ON ra.RefereeID = r.ID AND ra.MatchDate = '#DateFormat(MDate,"YYYY-MM-DD")#' 
			LEFT JOIN fixture f ON f.AsstRef2ID = r.ID  
			LEFT JOIN constitution c1 ON c1.ID = f.HomeID 
			LEFT JOIN constitution c2 ON c2.ID = f.AwayID 
			LEFT JOIN team t1 ON c1.TeamID = t1.ID 
			LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID 
			LEFT JOIN team t2 ON c2.TeamID = t2.ID 
			LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID 
			LEFT JOIN division d ON c1.DivisionID = d.ID 
			LEFT JOIN koround k ON f.KORoundID = k.ID  
	  	where f.leaguecode = '#request.filter#' and f.FixtureDate='#DateFormat(MDate,"YYYY-MM-DD")#' and r.LongCol IS NOT NULL and r.ShortCol IS NOT NULL UNION ALL
	SELECT f.ID as FID,  d.ID as DID, c1.ID as HomeID, c2.ID as AwayID, r.ID as RID, r.EmailAddress1, r.EmailAddress2, 		
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
		r.Notes as RefNotes,
		r.Restrictions,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
		'Fourth Official' as role, d.LongCol as Competition, k.LongCol as KORoundName, r.shortcol as refsort, 
		t1.LongCol as HomeTeam, o1.LongCol as HomeOrdinal, t2.LongCol as AwayTeam, o2.LongCol as AwayOrdinal, 
		CASE WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 THEN r.LongCol ELSE CONCAT(r.Surname, ", ", r.Forename) END as RefsName, r.PromotionCandidate, r.Restrictions, r.Level, r.Notes as RefNotes 
		FROM referee r 
			LEFT JOIN refavailable ra ON ra.RefereeID = r.ID AND ra.MatchDate = '#DateFormat(MDate,"YYYY-MM-DD")#' 
			LEFT JOIN fixture f ON f.FourthOfficialID = r.ID  
			LEFT JOIN constitution c1 ON c1.ID = f.HomeID 
			LEFT JOIN constitution c2 ON c2.ID = f.AwayID 
			LEFT JOIN team t1 ON c1.TeamID = t1.ID 
			LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID 
			LEFT JOIN team t2 ON c2.TeamID = t2.ID 
			LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID 
			LEFT JOIN division d ON c1.DivisionID = d.ID 
			LEFT JOIN koround k ON f.KORoundID = k.ID  
		where f.leaguecode = '#request.filter#' and f.FixtureDate='#DateFormat(MDate,"YYYY-MM-DD")#' and r.LongCol IS NOT NULL and r.ShortCol IS NOT NULL UNION ALL
	SELECT f.ID as FID,  d.ID as DID, c1.ID as HomeID, c2.ID as AwayID, r.ID as RID, r.EmailAddress1, r.EmailAddress2, 		
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
		r.Notes as RefNotes,
		r.Restrictions,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
		'Assessor' as role, d.LongCol as Competition, k.LongCol as KORoundName, r.shortcol as refsort, 
		t1.LongCol as HomeTeam, o1.LongCol as HomeOrdinal, t2.LongCol as AwayTeam, o2.LongCol as AwayOrdinal, 
		CASE WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0 THEN r.LongCol ELSE CONCAT(r.Surname, ", ", r.Forename) END as RefsName, r.PromotionCandidate, r.Restrictions, r.Level, r.Notes as RefNotes 
		FROM referee r 
			LEFT JOIN refavailable ra ON ra.RefereeID = r.ID AND ra.MatchDate = '#DateFormat(MDate,"YYYY-MM-DD")#' 
			LEFT JOIN fixture f ON f.AssessorID = r.ID  
			LEFT JOIN constitution c1 ON c1.ID = f.HomeID 
			LEFT JOIN constitution c2 ON c2.ID = f.AwayID 
			LEFT JOIN team t1 ON c1.TeamID = t1.ID 
			LEFT JOIN ordinal o1 ON c1.OrdinalID = o1.ID 
			LEFT JOIN team t2 ON c2.TeamID = t2.ID 
			LEFT JOIN ordinal o2 ON c2.OrdinalID = o2.ID 
			LEFT JOIN division d ON c1.DivisionID = d.ID 
			LEFT JOIN koround k ON f.KORoundID = k.ID  
		where f.leaguecode = '#request.filter#' and f.FixtureDate='#DateFormat(MDate,"YYYY-MM-DD")#' and r.LongCol IS NOT NULL and r.ShortCol IS NOT NULL
	order by  refsort, RefsName;
</cfquery>
