<!--- called by TeamHist.cfm, TeamHistALL.cfm --->
<link href="/fmstyle.css" rel="stylesheet" type="text/css">
<tr>
	<td>
		<cfif HomeAway IS "H"> 
			<cfinclude template="queries/qry_QGoalscorersH.cfm">
			<cfif QGoalscorersH.RecordCount GT 0>
				<cfset HomeGoalscorersSurnameList=ValueList(QGoalscorersH.PlayerSurname)>
				<cfset HomeGoalscorersForenameList=ValueList(QGoalscorersH.PlayerForename)>
				<cfset HomeGoalscoredList=ValueList(QGoalscorersH.GoalsScored)>
				<cfif ListGetAt(HomeGoalscorersSurnameList, 1) IS 'Own Goal'>
					<cfif ListGetAt(HomeGoalscoredList, 1) GT 2>
						<span class="pix10navy">
							<cfoutput>OG(#ListGetAt(HomeGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelseif ListGetAt(HomeGoalscoredList, 1) GT 1>
						<span class="pix10navy">
							<cfoutput>OG(#ListGetAt(HomeGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelse>
						<span class="pix10navy">
							<cfoutput>OG</cfoutput>
						</span>
					</cfif>
				<cfelse>
					<cfif ListGetAt(HomeGoalscoredList, 1) GT 2>
						<span class="pix10red">
							<cfoutput>#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#(#ListGetAt(HomeGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelseif ListGetAt(HomeGoalscoredList, 1) GT 1>
						<span class="pix10">
							<cfoutput>#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#(#ListGetAt(HomeGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelse>
						<span class="pix10">
							<cfoutput>#Left(ListGetAt(HomeGoalscorersForenameList, 1),1)#.#ListGetAt(HomeGoalscorersSurnameList, 1)#</cfoutput>
						</span>
					</cfif>
				</cfif>
				<cfloop index="w" from="2" to="#QGoalscorersH.RecordCount#" step="1">
					<cfif ListGetAt(HomeGoalscorersSurnameList, w) IS 'Own Goal'>
							<cfif ListGetAt(HomeGoalscoredList, w) GT 1>
								<span class="pix10navy">
									<cfoutput>&nbsp;OG(#ListGetAt(HomeGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelse>
								<span class="pix10navy">
									<cfoutput>&nbsp;OG</cfoutput>
								</span>
							</cfif>
					<cfelse>
							<cfif ListGetAt(HomeGoalscoredList, w) GT 2>
								<span class="pix10red">
									<cfoutput>&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#(#ListGetAt(HomeGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelseif ListGetAt(HomeGoalscoredList, w) GT 1>
								<span class="pix10">
									<cfoutput>&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#(#ListGetAt(HomeGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelse>
								<span class="pix10">
									<cfoutput>&nbsp;#Left(ListGetAt(HomeGoalscorersForenameList, w),1)#.#ListGetAt(HomeGoalscorersSurnameList, w)#</cfoutput>
								</span>
							</cfif>
					</cfif>
				</cfloop>
			</cfif>
		<cfelseif HomeAway IS "A"> 
			<cfinclude template="queries/qry_QGoalscorersA.cfm">
			<cfif QGoalscorersA.RecordCount GT 0>
				<cfset AwayGoalscorersSurnameList=ValueList(QGoalscorersA.PlayerSurname)>
				<cfset AwayGoalscorersForenameList=ValueList(QGoalscorersA.PlayerForename)>
				<cfset AwayGoalscoredList=ValueList(QGoalscorersA.GoalsScored)>
				<cfif ListGetAt(AwayGoalscorersSurnameList, 1) IS 'Own Goal'>
					<cfif ListGetAt(AwayGoalscoredList, 1) GT 2>
						<span class="pix10navy">
							<cfoutput>OG(#ListGetAt(AwayGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelseif ListGetAt(AwayGoalscoredList, 1) GT 1>
						<span class="pix10navy">
							<cfoutput>OG(#ListGetAt(AwayGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelse>
						<span class="pix10navy">
							<cfoutput>OG</cfoutput>
						</span>
					</cfif>
				<cfelse>
					<cfif ListGetAt(AwayGoalscoredList, 1) GT 2>
						<span class="pix10red">
							<cfoutput>#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#(#ListGetAt(AwayGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelseif ListGetAt(AwayGoalscoredList, 1) GT 1>
						<span class="pix10">
							<cfoutput>#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#(#ListGetAt(AwayGoalscoredList, 1)#)</cfoutput>
						</span>
					<cfelse>
						<span class="pix10">
							<cfoutput>#Left(ListGetAt(AwayGoalscorersForenameList, 1),1)#.#ListGetAt(AwayGoalscorersSurnameList, 1)#</cfoutput>
						</span>
					</cfif>
				</cfif>
				
				<cfloop index="w" from="2" to="#QGoalscorersA.RecordCount#" step="1">
					<cfif ListGetAt(AwayGoalscorersSurnameList, w) IS 'Own Goal'>
							<cfif ListGetAt(AwayGoalscoredList, w) GT 1>
								<span class="pix10navy">
									<cfoutput>&nbsp;OG(#ListGetAt(AwayGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelse>
								<span class="pix10navy">
									<cfoutput>&nbsp;OG</cfoutput>
								</span>
							</cfif>
					<cfelse>
							<cfif ListGetAt(AwayGoalscoredList, w) GT 2>
								<span class="pix10red">
									<cfoutput>&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#(#ListGetAt(AwayGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelseif ListGetAt(AwayGoalscoredList, w) GT 1>
								<span class="pix10">
									<cfoutput>&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#(#ListGetAt(AwayGoalscoredList, w)#)</cfoutput>
								</span>
							<cfelse>
								<span class="pix10">
									<cfoutput>&nbsp;#Left(ListGetAt(AwayGoalscorersForenameList, w),1)#.#ListGetAt(AwayGoalscorersSurnameList, w)#</cfoutput>
								</span>
							</cfif>
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		<!--- Home Team's Star Player --->
		<cfif QHomeStarPlayer.RecordCount GT 0 AND HomeAway IS "H">
			<cfinclude template="queries/qry_QStarPlayerH.cfm">
			<cfif QStarPlayerH.RecordCount GT 0>
				<cfoutput query="QStarPlayerH">
					&nbsp;<img src="images/icon_star_home.png" border="0" align="top"><span class="pix10navy"><em>#Left(PlayerForename, 1)#.#PlayerSurname#</em></span>
				</cfoutput>
			</cfif>
		</cfif>
		<!--- Away Team's Star Player --->
		<cfif QAwayStarPlayer.RecordCount GT 0 AND HomeAway IS "A">
			<cfinclude template="queries/qry_QStarPlayerA.cfm">
			<cfif QStarPlayerA.RecordCount GT 0>
				<cfoutput query="QStarPlayerA">
					&nbsp;<img src="images/icon_star_away.png" border="0" align="top"><span class="pix10navy"><em>#Left(PlayerForename, 1)#.#PlayerSurname#</em></span>
				</cfoutput>
			</cfif>
		</cfif>
	</td>
</tr>			