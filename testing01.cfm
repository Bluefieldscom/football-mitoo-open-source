REDUNDANT CODE

<cfabort>



<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfset ThisYear = #LeagueCodeYear# >
<cfset PreviousYear = #LeagueCodeYear#-1 >
<cfset spanset = " ,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0">

<cfquery name="QTeam01" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol as TeamName
	FROM
		team
	WHERE 
		LeagueCode='#LeagueCodePrefix#'
		AND NOT (ShortCol='Guest')
		AND NOT (Left(Notes,7)='NoScore')
	ORDER BY
		LongCol
</cfquery>

<table class="leagueTable">
		<tr>
			<cfoutput>
				<td valign="top"><span class="pix10bold">2009 Team</span></td>
				<td valign="top"<span class="pix10bold">2009ID</span></td>
				<td valign="top"<span class="pix10bold">lk_team<br>2008ID</span></td>
				<td valign="top"<span class="pix10bold">fm2008 ID<br>Team<br>spelling<br>exact match</span></td>
				<td valign="top"<span class="pix10bold">check1</span></td>
				<td valign="top"<span class="pix10bold">check2</span></td>
				
			</cfoutput>
		</tr>

	<cfloop query="QTeam01">
		<cfquery name="QTeam02" datasource="zmast">
			SELECT
				2008id
			FROM
				lk_team
			WHERE 
				2009id = #QTeam01.ID#
		</cfquery>
		<cfquery name="QTeam03" datasource="#request.DSN#">
			SELECT
				id
			FROM
				fm2008.team
			WHERE 
				LeagueCode='#LeagueCodePrefix#'
				AND longcol = '#TeamName#'
		</cfquery>
		<tr>
			<cfoutput>
				<td><span class="pix13realblack">#TeamName#</span></td>
				<td><span class="pix13realblack">#ID#</span></td>
				<cfif QTeam02.RecordCount IS 0>
					<td><span class="pix13realblack">NOT FOUND</span></td>
				<cfelseif QTeam02.RecordCount IS 1>
					<cfif QTeam02.2008ID IS ''>
						<td><span class="pix13bold">NULL</span></td>
					<cfelse>
						<td><span class="pix13realblack">#QTeam02.2008ID#</span></td>
					</cfif>
					
				<cfelse>
				error
				<cfabort>
				
				</cfif>
				<td><span class="pix13realblack">#QTeam03.id#</span></td>
				<cfif QTeam02.2008ID IS '' AND QTeam03.id IS NOT ''>
					<td bgcolor="white"><span class="pix13boldred">MISSING</span></td>
				<cfelse>
					<td><span class="pix13boldred">&nbsp;</span></td>
				</cfif>
				<cfif QTeam02.2008ID IS '' AND QTeam03.id IS ''>
					<td>
						<cfset CountVar = 1>
						<table border="1" cellpadding="2" cellspacing="0">
							<cfloop condition="GetToken(TeamName, CountVar) IS NOT ''">
								<tr>
								<cfset SearchTerm = Trim(ReplaceList(GetToken(TeamName, CountVar),"(,),-,=,',_,&", " , , , , , , "))>
								
									<cfquery name="QTeam04" datasource="zmast">
										SELECT
											count(*) as cntr
										FROM
											fm2008.team t8
										WHERE 
											t8.LeagueCode='#LeagueCodePrefix#'
											AND t8.longcol LIKE '%#SearchTerm#%'
											AND NOT (t8.ShortCol='Guest')
											AND NOT (Left(t8.Notes,7)='NoScore')
											
									</cfquery>
								<td><span class="pix10">#SearchTerm#</span></td>
								<cfif QTeam04.cntr GT 0>
									<td><span class="pix13boldred">#QTeam04.cntr#</span></td>
								<cfelse>
									<td><span class="pix13boldred">&nbsp;</span></td>
								</cfif>
								
								</tr>
								<cfset CountVar = CountVar + 1>
							</cfloop>
						</table>
					</td>
				</cfif>
			</cfoutput>
		</tr>
	</cfloop>
</table>


