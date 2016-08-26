<!--- this is here simply for good order --->

<!--- OnRequestEnd.cfm 
This prevents my application from seeking another OnRequestEnd.cfm file 
elsewhere on the server, before giving up and not using one. That's 
apparently what CF does, and this file may add a tiny amount of speed.
--->

<cfset ExemptList = "testadverts.cfm,fmMap.cfm,BatchInput.cfm,BatchUpdate.cfm,banned.cfm,Counties.cfm,Calendar.cfm,CurrentSuspensions.cfm,RefereeCardsToday.cfm,DownloadDocuments.cfm,DownloadPictures.cfm,FixturesTxt.cfm,latest.cfm,ListOfLeagues.cfm,Noticeboard.cfm,TopCounts.cfm,RefAvailable.cfm,RefAvailableAdd.cfm,RefAvailableUpdDel.cfm,PtchAvailable.cfm,SeeMatchReport.cfm,ThisRefsHistory.cfm,SponsorT.cfm,VenueInformation.cfm,WhatUSay.cfm,XMLCounty.cfm,XMLLeague.cfm,XMLCompetition.cfm,XMLLeagueTable.cfm,webServices.cfc,EventCalendar.cfm,EventCalendarShow.cfm,HomeAwayTeamCommentsXLS.cfm,RefMarksXLS.cfm,AppearanceAnalysisXLS.cfm,PlayerDetailsXLS.cfm,CurrentRegistrationsXLS.cfm,ShowContacts.cfm,ShowNews.cfm,SeePhoto.cfm,MigrationSplash.cfm,del_OrphanedTeamDetails.cfm,EmailEnvelope.cfm">



<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
<cfelse>
	<cfif ListFindNoCase(ExemptList,Replace(CGI.path_translated,request.xpath, "")) IS 0>
		<cfinclude template="adverts/incl728x90BOTTOM.cfm">
	
	<!---
					<cfif DefaultYouthLeague IS 0> <!--- adult --->
						<cfinclude template="adverts/inclAdult468x60.cfm">
					<cfelse>           <!--- youth --->
						<cfinclude template="adverts/inclYouth468x60.cfm">
					</cfif>
	--->
	</cfif>
</cfif>


<cfinclude template="adverts/inclGoogleAnalytics.cfm">


<!---
<script type="text/javascript">
var pageTracker = _gat._getTracker("GOOGLE_ANALYTICS_ID");
pageTracker._trackPageview();
</script>
--->
<cfset ExemptList2 = "testadverts.cfm,fmMap.cfm,RefAvailable.cfm,RefAvailableAdd.cfm,RefAvailableUpdDel.cfm,PtchAvailable.cfm,EventCalendar.cfm,EventCalendarShow.cfm,EventCalendarAdd.cfm,EventCalendarUpdDel.cfm,Calendar.cfm,EmailEnvelope.cfm,Noticeboard.cfm">

<!---
					************************************** 
					* Help for InclSchedule01.cfm screen *
					**************************************
--->	
				
<cfif FindNoCase("UpdateForm.cfm", CGI.Script_Name)  AND ListFind("Silver,Skyblue",request.SecurityLevel)>
	<cfswitch expression="#TblName#">
		<cfcase value="Matches">
			<table width="10%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left"> 
						<cfset tooltiptext ="<div style='text-align:center;color:navy;text-decoration:none;background-color:ivory;'><br></div>">
						<cfif request.SportsmanshipMarksOutOfHundred IS "0" > 
							<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;color:navy;text-decoration:none;background-color:ivory;'>Sportsmanship Marks are currently out of 10.<br>Contact us to change to 100.<br><br></div>">
						<cfelse>
							<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;color:navy;text-decoration:none;background-color:ivory;'>Sportsmanship Marks are currently out of 100.<br>Contact us to change to 10.<br><br></div>">
						</cfif>
						<cfif ClubsCanInputSportsmanshipMarks IS 1>
							<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;color:navy;text-decoration:none;background-color:ivory;'>Clubs are allowed to enter marks for their opponents' sportsmanship.<br>Contact us to prevent.<br><br></div>">
						<cfelse>
							<cfset tooltiptext = "#tooltiptext#<div style='text-align:left;color:navy;text-decoration:none;background-color:ivory;'>Clubs are prevented from entering marks for their opponents' sportsmanship.<br>Contact us to allow.<br><br></div>">
						</cfif>
							<cfset tooltiptext = Replace(tooltiptext, "'", "\'", "ALL")>
							<cfoutput>
								<img src="help.gif" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='ivory';this.T_FONTSIZE='13px';this.T_PADDING=5;this.T_WIDTH=800;return escape('#TooltipText#')"> 
							</cfoutput>
					</td>
				</tr>
			</table>
		</cfcase>
	</cfswitch>
	<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

</cfif>



<cfif ListFindNoCase(ExemptList2,Replace(CGI.path_translated,request.xpath, "")) IS 0>
	<table width="100%" border="0"  cellpadding="0" cellspacing="0">
	</table>
</cfif>

<script type="text/javascript">
var _sf_async_config={uid:16912,domain:"football.mitoo.co.uk"};
(function(){
  function loadChartbeat() {
    window._sf_endpt=(new Date()).getTime();
    var e = document.createElement('script');
    e.setAttribute('language', 'javascript');
    e.setAttribute('type', 'text/javascript');
    e.setAttribute('src',
       (("https:" == document.location.protocol) ? "https://a248.e.akamai.net/chartbeat.download.akamai.com/102508/" : "http://static.chartbeat.com/") +
       "js/chartbeat.js");
    document.body.appendChild(e);
  }
  var oldonload = window.onload;
  window.onload = (typeof window.onload != 'function') ?
     loadChartbeat : function() { oldonload(); loadChartbeat(); };
})();

</script>

<script type="text/javascript">
setTimeout(function(){var a=document.createElement("script");
var b=document.getElementsByTagName("script")[0];
a.src=document.location.protocol+"//dnn506yrbagrg.cloudfront.net/pages/scripts/0022/0145.js?"+Math.floor(new Date().getTime()/3600000);
a.async=true;a.type="text/javascript";b.parentNode.insertBefore(a,b)}, 1);
</script>

</body>
</html>

