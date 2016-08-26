<!--- called by ListOfReferees.cfm --->

<CFQUERY NAME="QReferee0" datasource="#request.DSN#" >
	SELECT
		ID as RefID ,
		CASE
			WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
			THEN LongCol
			ELSE CONCAT(Surname, ", ", Forename )
			END
			as RefereeName ,
		UCase(Trim(MediumCol)) as MediumCol,
		UCase(Trim(ShortCol)) as ShortCol,
		EmailAddress1,
		EmailAddress2, 
		CONCAT(
		
		<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
			CASE WHEN ShowHideAddress = 1 THEN CONCAT("== Address Hidden ==<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(AddressLine1)) > 0 THEN CONCAT(AddressLine1,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(AddressLine2)) > 0 THEN CONCAT(AddressLine2,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(AddressLine3)) > 0 THEN CONCAT(AddressLine3,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(PostCode)) > 0 THEN CONCAT(PostCode,"<br />") ELSE "" END,
			CASE WHEN ShowHideAddress = 1 THEN CONCAT("================<br />") ELSE "" END,
		<cfelse>
			CASE WHEN LENGTH(TRIM(AddressLine1)) > 0 AND ShowHideAddress = 0 THEN CONCAT(AddressLine1,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(AddressLine2)) > 0 AND ShowHideAddress = 0 THEN CONCAT(AddressLine2,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(AddressLine3)) > 0 AND ShowHideAddress = 0 THEN CONCAT(AddressLine3,"<br />") ELSE "" END,
			CASE WHEN LENGTH(TRIM(PostCode)) > 0 AND ShowHideAddress = 0 THEN CONCAT(PostCode,"<br />") ELSE "" END,
		</cfif>	
			
		CASE WHEN LENGTH(TRIM(HomeTel)) > 0 THEN CONCAT("Home: ",HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(WorkTel)) > 0 THEN CONCAT("Work: ",WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(MobileTel)) > 0 THEN CONCAT("Mobile: ",MobileTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(Notes)) > 0 THEN CONCAT(Notes,"<br />") ELSE "" END
		) 
		as RefDetails		
	FROM 
	 	referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND LongCol IS NOT NULL
</CFQUERY>

