<!--- called by InclEmailHomeTeamIcon.cfm --->

<cfquery name="QVenueDetails" datasource="#request.DSN#">
SELECT
		v.LongCol,
		v.AddressLine1,
		v.AddressLine2,
		v.AddressLine3,
		v.PostCode,
		v.VenueTel,
		v.MapURL	
FROM
		pitchavailable AS h,
		venue AS v
WHERE
		h.id=#PA_ID#
		AND h.VenueID = v.ID 
</cfquery>

