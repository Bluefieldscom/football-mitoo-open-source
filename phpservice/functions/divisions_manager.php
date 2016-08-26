<?php
class divisions_manager
{


    /**
     * Return recent competition table for a given division
     *
     * @param int $division_id
     * @param string $league_code [OPTIONAL]
     * @param string $start_date
     * @param string $end_date
     * @param int $limit [OPTIONAL]
     * @return data[]
     */

    public static function getDivisionTable($division_id, $league_code, $start_date, $end_date, $limit)
    {

        if (!$division_id)
            return array();


        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();

        $query = "SELECT
		d.Notes,
		d.LongCol AS CompetitionDescription
	FROM
		division d
		JOIN zmast.lk_division lkd ON d.id = lkd.{$yearcode}id
	WHERE
		lkd.ID = '{$division_id}'";

        $process = myQ($query);
        $result = MyO($process);


        if (isset($result->Notes) && preg_match("/KO/i", $result->Notes)) {
            $KO = true;
        }

        // HideGoals will suppress Goals For, Goals Against and Goal Difference columns
        if (isset($result->Notes) && preg_match("/HideGoals/i", $result->Notes)) {
            $HideGoals = true;
        }

        if (isset($result->Notes) && preg_match("/HideGoalDiff/i", $result->Notes)) {
            $HideGoalDiff = true;
        }

        if (isset($result->Notes) && preg_match("/HideDivision/i", $result->Notes)) {
            $HideDivision = true;
        }

        if (isset($result->Notes) && preg_match("/SuppressTable/i", $result->Notes)) {
            $SuppressTable = true;
        }


        if (isset($result->CompetitionDescription) && ( preg_match("/Friendly/i", $result->CompetitionDescription) || preg_match("/Miscellaneous/i", $result->CompetitionDescription))) {
            $SuppressLeagueTable = true;
        }

        if (isset($SuppressTable) || isset($SuppressLeagueTable) || isset($HideDivision) ||     isset($KO)) {
            return array();
        }


        $query = "SELECT
		zmlkc.id AS team_id,
		t.longcol AS temp_name,
		l.PointsAdjustment AS league_table_points_adjust,
		l.HomeGamesPlayed AS league_table_home_games_played,
		l.HomeGamesWon AS league_table_home_games_won,
		l.HomeGamesDrawn AS league_table_home_games_drawn,
		l.HomeGamesLost AS league_table_home_games_lost,
		l.HomeGoalsFor AS league_table_home_goals_for,
		l.HomeGoalsAgainst AS league_table_home_goals_against,
		l.HomePoints AS league_table_home_points,
		l.HomePointsAdjust AS league_table_home_goals_against,
		l.AwayGamesPlayed AS league_table_away_games_played,
		l.AwayGamesWon AS league_table_away_games_won,
		l.AwayGamesDrawn AS league_table_away_games_drawn,
		l.AwayGamesLost AS league_table_away_games_lost,
		l.AwayGoalsFor AS league_table_away_goals_for,
		l.AwayGoalsAgainst AS league_table_away_goals_against,
		l.AwayPoints AS league_table_away_points,
		l.AwayPointsAdjust AS league_table_away_points_adjust
	FROM
		fm{$yearcode}.leaguetable 			 AS l
		INNER JOIN fm{$yearcode}.constitution AS c ON c.ID=l.ConstitutionID
		INNER JOIN fm{$yearcode}.team         AS t ON t.ID=c.teamid
		INNER JOIN fm{$yearcode}.division 	 AS d1 ON c.DivisionID = d1.ID
	
		LEFT JOIN zmast.lk_constitution 	AS zmlkc ON zmlkc.{$yearcode}id = c.ID
		LEFT JOIN zmast.lk_division 		AS zmlkd ON zmlkd.{$yearcode}id = d1.ID
	WHERE
		l.DivisionID = zmlkd.{$yearcode}id
		AND zmlkd.id = {$division_id}
	ORDER BY
		l.Rank
	LIMIT {$limit}";


        $process = myQ($query);

        $data = null;
        while ($result = MyO($process)) {
            $temp_data = new table();

            if (isset($HideGoals)) {
                $result->league_table_away_goals_for = null;
                $result->league_table_away_goals_against = null;
                $result->league_table_home_goals_for = null;
                $result->league_table_home_goals_against = null;
            }

            $_temp_data = (object)array_merge((array )$temp_data, (array )$result);
            $data[] = $_temp_data;
        }

        if (!$data)
            return array();

        return $data;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
     * Return recent competition table for a given division
     *
     * @param int $division_id
     * @param string $league_code [OPTIONAL]
     * @param string $start_date
     * @param string $end_date
     * @param int $limit [OPTIONAL]
     * @return data[]
     */

    public static function  getDivisionTopScorers($division_id,$league_code,$start_date,$end_date,$start)
    {
      if (!$division_id)
            return array();


        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();

 
    
    $query =	"
    
    	SELECT
		TeamName AS team_name,
        team_id,
        division_name,
		OrdinalName AS ordinal_name,
		MAX(FixtureDate) as most_recent_date_played,
		PlayerID AS player_id,
		Surname AS player_last_name,
        Forename AS player_first_name, 
		COUNT(PlayerID) as played,
		SUM(GoalsScored) as goals 
	FROM
	(SELECT
		 FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
        zlkc.id As team_id,
		t.LongCol as TeamName,
		d1.LongCol as division_name,
		o.LongCol as OrdinalName, 
		a.GoalsScored 		
	FROM
		fm{$yearcode}.team t
		JOIN fm{$yearcode}.register r ON t.ID = r.TeamID
		JOIN fm{$yearcode}.player p ON p.ID = r.PlayerID
		JOIN fm{$yearcode}.appearance a ON (a.PlayerID = p.ID AND a.HomeAway = 'H')
		JOIN fm{$yearcode}.fixture f ON f.ID = a.FixtureID
		JOIN fm{$yearcode}.constitution c ON c.ID = f.HomeID
	JOIN fm{$yearcode}.division d1 ON c.DivisionID = d1.ID
		JOIN fm{$yearcode}.ordinal o ON o.ID = c.OrdinalID 
			JOIN zmast.lk_constitution zlkc ON zlkc.{$yearcode}id = c.ID
			JOIN zmast.lk_division zlkd ON zlkd.id = {$division_id}
	WHERE 
			c.DivisionID = zlkd.{$yearcode}id AND  
		a.leaguecode = '{$league_code}'
		AND	(CURRENT_DATE BETWEEN 
				CASE
				WHEN r.FirstDay IS NULL
				THEN '1900-01-01'
				ELSE r.FirstDay
				END
			 AND 
				CASE
				WHEN r.LastDay IS NULL
				THEN '2999-12-31'
				ELSE r.LastDay
				END )
	UNION ALL
	SELECT
		FixtureDate,
		a.PlayerID,
		p.Surname, p.Forename,
        zlkc.id As team_id,
		t.LongCol as TeamName,
		d1.LongCol as division_name,
		o.LongCol as OrdinalName, 
		a.GoalsScored
	FROM
		fm{$yearcode}.team t
		JOIN fm{$yearcode}.register r ON t.ID = r.TeamID
		JOIN fm{$yearcode}.player p ON p.ID = r.PlayerID
		JOIN fm{$yearcode}.appearance a ON (a.PlayerID = p.ID AND a.HomeAway = 'A')
		JOIN fm{$yearcode}.fixture f ON f.ID = a.FixtureID
		JOIN fm{$yearcode}.constitution c ON c.ID = f.AwayID
	JOIN fm{$yearcode}.division d1 ON c.DivisionID = d1.ID
		JOIN fm{$yearcode}.ordinal o ON o.ID = c.OrdinalID 
			JOIN zmast.lk_constitution zlkc ON zlkc.{$yearcode}id = c.ID
			JOIN zmast.lk_division zlkd ON zlkd.id ={$division_id}
	WHERE 
			c.DivisionID = zlkd.{$yearcode}id AND  
		a.leaguecode = '{$league_code}'
		AND	(CURRENT_DATE BETWEEN 
				CASE
				WHEN r.FirstDay IS NULL
				THEN '1900-01-01'
				ELSE r.FirstDay
				END
			 AND 
				CASE
				WHEN r.LastDay IS NULL
				THEN '2999-12-31'
				ELSE r.LastDay
				END)
                ) temp
                GROUP BY
		temp.TeamName, temp.OrdinalName, temp.PlayerID, temp.Surname, temp.Forename
	HAVING
		SUM(GoalsScored) > 0 
	ORDER BY
		Goals DESC, temp.Surname, temp.Forename
        LIMIT {$start}, 10
        ";
                
 $process = myQ($query);

$data = null;
while ($result = MyO($process)) {
                
$temp_data = new player();
$result->fixture_date = date("Y-m-d", strtotime($result->fixture_date));
$result->division = $division_id;

$_temp_data = (object)array_merge((array )$temp_data, (array )$result);
$data[] = $_temp_data;
}                
     
// p($data);die; 
     
     return $data;          
                
                
    
}
 
    
    
    
    
    
    
    
    
    
    
    
    
    
        /**
     * Return form table of a division
     *
     * @param int $division_id
     * @param string $league_code [OPTIONAL]
     * @param string $start_date
     * @param string $end_date
     * @param int $limit [OPTIONAL]
     * @return form[]
     */

    public static function getDivisionForm($division_id, $league_code, $start_date, $end_date, $limit)
    {

        if (!$division_id)
            return array();


        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();

        $query = "SELECT
		d.Notes,
		d.LongCol AS CompetitionDescription
	FROM
		division d
		JOIN zmast.lk_division lkd ON d.id = lkd.{$yearcode}id
	WHERE
		lkd.ID = '{$division_id}'";

        $process = myQ($query);
        $result = MyO($process);


        if (isset($result->Notes) && preg_match("/KO/i", $result->Notes)) {
            $KO = true;
        }

        // HideGoals will suppress Goals For, Goals Against and Goal Difference columns
        if (isset($result->Notes) && preg_match("/HideGoals/i", $result->Notes)) {
            $HideGoals = true;
        }

        if (isset($result->Notes) && preg_match("/HideGoalDiff/i", $result->Notes)) {
            $HideGoalDiff = true;
        }

        if (isset($result->Notes) && preg_match("/HideDivision/i", $result->Notes)) {
            $HideDivision = true;
        }

        if (isset($result->Notes) && preg_match("/SuppressTable/i", $result->Notes)) {
            $SuppressTable = true;
        }


        if (isset($result->CompetitionDescription) && preg_match("/Friendly/i", $result->
            CompetitionDescription)) {
            $SuppressLeagueTable = true;
        }

        if (isset($result->CompetitionDescription) && ( preg_match("/Friendly/i", $result->CompetitionDescription) || preg_match("/Miscellaneous/i", $result->CompetitionDescription))) {
            return array();
        }


      
        $query = "SELECT
			zlkc1.id as team_id,
			t.longcol as temp_team,
				
				(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_home_games_played,
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_away_games_played,
		
		
			(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_home_goals_for,
			(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_away_goals_for,
			(SELECT COALESCE(SUM(f.HomeGoals),0) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_home_goals_against,
			(SELECT COALESCE(SUM(f.AwayGoals),0) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.Result IS NULL) as form_away_goals_against,
				
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') AND f.HomeID = c.ID 
				AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as form_home_wins,
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as form_away_wins,
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as form_home_draws,
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals = f.AwayGoals) as form_away_draws,				
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.HomeID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals < f.AwayGoals) as form_home_defeats,
			(SELECT COUNT(f.ID) FROM fm{$yearcode}.fixture AS f 
				WHERE  (FixtureDate BETWEEN '{$start_date}' AND '{$end_date}') 
				AND f.AwayID = c.ID AND f.HomeGoals IS NOT NULL AND f.AwayGoals IS NOT NULL AND f.HomeGoals > f.AwayGoals) as form_away_defeats
	
		FROM
			fm{$yearcode}.constitution AS c
			INNER JOIN fm{$yearcode}.team AS t ON t.id=c.teamid
			LEFT JOIN zmast.lk_constitution zlkc1 ON c.ID = zlkc1.{$yearcode}id
			LEFT JOIN zmast.lk_division zlkd ON zlkd.id = '{$division_id}'
			
		WHERE
			c.DivisionID = zlkd.{$yearcode}id
		LIMIT {$limit}
        ";
 


        $process = myQ($query);

        $data = null;
        while ($result = MyO($process)) {
            $temp_data = new form();

           /* if (isset($HideGoals)) {
                $result->league_table_away_goals_for = null;
                $result->league_table_away_goals_against = null;
                $result->league_table_home_goals_for = null;
                $result->league_table_home_goals_against = null;
            }
*/
            $_temp_data = (object)array_merge((array )$temp_data, (array )$result);
            $data[] = $_temp_data;
        }

        if (!$data)
            return array();

        return $data;
    }
    
    
    
    
    
    
    
    
    /**
     * Return fixtures for a division set
     *
     * @param int $division_id
     * @param string $league_code [OPTIONAL]
     * @param string $start_date
     * @param string $end_date
     * @param string $order [OPTIONAL]
     * @param int $limit [OPTIONAL]
     * @return data[]
     */

    public static function getDivisionFixtures($division_id,$league_code,$start_date,$end_date,$limit,$order)
    {
        
        $data = null;
        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();
                      
            
            
            
        $knockout_q = zmast_manager::knockoutQuery($yearcode, $division_id);
       
        
            
        if (empty($division_id)) {
            $div_args = null;
        } else {
            //p($constit_list);die;
            $try = explode(",",$division_id);

            if (!isset($try[1])) {
                $div_args = " zlkd.id ='".$division_id."' AND";
            } else {
                $div_args = " zlkd.id IN (".$division_id.") AND";
            }
        }
                     
                    

$query = "	SELECT 
		f.ID as fixture_id,
	   f.FixtureDate AS fixture_date,
		f.Result AS fixture_result,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as fixture_home_goals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as fixture_away_goals,
		v.LongCol as fixture_venue_name,
		zlkc1.ID as fixture_home_id,
		zlkc2.ID as fixture_away_id,
		t1.longcol AS temp_home,
		t2.longcol AS temp_away,
		ko.longcol AS knockout_desc,
		f.fixturenotes AS fixture_notes,
		IF(ISNULL(f.KOTime),'',f.KOTime) AS KOTime,
		zlkd.id AS umbrella_id,
		d1.longcol AS division_name,
        e.EventText
	FROM
		fm{$yearcode}.fixture f 
		
		INNER JOIN fm{$yearcode}.koround ko ON ko.id=f.KORoundID
		
		INNER JOIN fm{$yearcode}.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm{$yearcode}.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm{$yearcode}.division d1 ON c1.DivisionID = d1.ID
		
		INNER JOIN fm{$yearcode}.team t1 ON c1.TeamID = t1.ID
		INNER JOIN fm{$yearcode}.team t2 ON c2.TeamID = t2.ID
		
		LEFT JOIN fm{$yearcode}.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm{$yearcode}.venue v on v.ID = pa.VenueID
	
		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.{$yearcode}id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.{$yearcode}id
	
		LEFT JOIN zmast.lk_division zlkd ON d1.ID = zlkd.{$yearcode}id
        LEFT JOIN fm{$yearcode}.event e ON e.eventdate = f.FixtureDate AND e.leaguecode =  '{$league_code}'
	
	WHERE {$div_args}       
		f.FixtureDate BETWEEN '{$start_date}' AND '{$end_date}'
		AND 
		d1.leaguecode = '{$league_code}'

  AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
AND f.Result != 'T'
	ORDER BY 
		f.FixtureDate {$order}, umbrella_id/*, temp_home ASC*/
	LIMIT {$limit}"; 

        $process = myQ($query);

        $data = null;
        while ($result = MyO($process)) {
            $temp_data = new fixture();
  
  
$HideGoals = null;
$HideGoalDiff = null;
$HideDivision = null; 


if(preg_match("/hide_fixtures/i", $result->EventText)){
    continue;
}
 
 
 if(isset($knockout_q[$result->umbrella_id])){
    
if(preg_match("/HideDivision/i", $knockout_q[$result->umbrella_id])){
    $HideDivision = true;
    }
    
    if(preg_match("/HideGoals/i", $knockout_q[$result->umbrella_id])){
    $HideGoals = true;
    }
    
    if(preg_match("/HideGoalDiff/i", $knockout_q[$result->umbrella_id])){
    $HideGoalDiff = true;
    }
    
 }
 
 
 
 if(($HideDivision || $HideGoals) && !is_null($result->fixture_home_goals) && !is_null($result->fixture_away_goals)){
    $result->fixture_home_goals = "Played";
    $result->fixture_home_goals = null;
    $result->fixture_home_goals = null;
 }
                 
  
        
        
            $_temp_data = (object)array_merge((array )$temp_data, (array )$result);
            $data[] = $_temp_data;
        }
        
         

        if (!$data)
            return array();

        return $data;
    }
    
    
    
    
    
    
    
    
    /**
     * Return fixture dates for a division set
     *
     * @param int $division_id
     * @param string $league_code [OPTIONAL]
     * @param string $start_date
     * @param string $end_date
     * @param string $order [OPTIONAL]
     * @param int $limit [OPTIONAL]
     * @return data[]
     */

    public static function getDivisionFixtureDates($division_id,$league_code,$start_date,$end_date,$limit,$order)
    {
        
        $data = null;
        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();
                      
                      
        if (empty($division_id)) {
            $div_args = null;
        } else {
            //p($constit_list);die;
            $try = explode(",",$division_id);

            if (!isset($try[1])) {
                $div_args = " zlkd.id ='".$division_id."' AND";
            } else {
                $div_args = " zlkd.id IN (".$division_id.") AND";
            }
        }
                      
                      
                      
    $query =  "SELECT DISTINCT 
		 FixtureDate AS fixture_date
	FROM
		fm{$yearcode}.fixture f 
		INNER JOIN fm{$yearcode}.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm{$yearcode}.division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN zmast.lk_division zlkd ON d1.ID = zlkd.{$yearcode}id
	WHERE {$div_args} 
		f.leaguecode = '{$league_code}'	
		AND
		f.FixtureDate BETWEEN '{$start_date}' AND '{$end_date}'
	 	 
AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
	ORDER BY
		f.FixtureDate {$order}	 
		LIMIT {$limit}";
       
     $process = myQ($query);

        $data = null;
        while ($result = MyO($process)) {
            $temp_data = new fixturedate();
             $_temp_data = (object)array_merge((array )$temp_data, (array )$result);
            $data[] = $_temp_data;
        }

             
         

        if (!$data)
            return array();

        return $data;
    }
    


}
?>