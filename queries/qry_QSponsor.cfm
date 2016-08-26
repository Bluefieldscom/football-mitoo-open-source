<!--- called by ClubList.cfm --->

<CFQUERY name="QSponsor" dbtype="query">
	SELECT
		ID as SponsorID,
		Button as SponsorButton
	FROM
		QSponsorInfo
	WHERE
		TID = #ListGetAt(IDList, RowN)#
</CFQUERY>