<?php
class teams_manager
{

    /*Get list of fixture for a $team_id
    limited to divisions in the $divisions_id list
    */
    public static function getFixtures($team_id, $start_date, $end_date, $limit, $order ="", $league_id = null, $division_id)
    {


        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_id, $start_date, $end_date);

        //Terminate process if league year is not found
        if (is_null($yearcode)) {
            return array();
        }


        //Lets get all the consitutions of this team
        $query = "SELECT id FROM fm{$yearcode}.constitution WHERE teamID IN 
	(
		SELECT teamID FROM fm{$yearcode}.constitution fc JOIN zmast.lk_constitution zl ON zl.{$yearcode}id = fc.id AND zl.id = '$team_id'
	)";


        $result = myQ($query);

        if ($result) {
            while ($constit_temp = myF($result)) {
                $constit_list[] = $constit_temp["id"];

            }
        }


        //p($constit_list);die;

        if (empty($constit_list)) {
            return array();
        } else {
            //p($constit_list);die;

            if (count($constit_list) == 1) {
                $c_filter = " ='" . $constit_list["id"] . "'";
            } else {
                $c_filter = " IN (" . implode(",", $constit_list) . ") ";
            }
        }



        $knockout_q = zmast_manager::knockoutQuery($yearcode, $division_id);

        $lkdid_list = isset($knockout_q["ID"]) ? $knockout_q["ID"] : null;
        $notes_list = isset($knockout_q["Notes"]) ? $knockout_q["Notes"] : null;

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


        $query = "SELECT 
		f.ID as fixture_id,
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS fixture_date,
		f.Result As fixture_result,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) as fixture_home_goals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) as fixture_away_goals,
		v.LongCol as venue_name,
		zlkc1.ID as fixture_home_id,
		zlkc2.ID as fixture_away_id,
		t1.longcol as temp_home,
		t2.longcol as temp_away,
		ko.longcol AS knockout_desc,
		f.fixturenotes As fixture_notes,
		IF(ISNULL(f.KOTime),'',f.KOTime) AS kotime,
		zlkd.id as umbrella_id,
		d1.longcol AS divisionname,
		d1.notes As  notes,
        e.EventText
	FROM
		fm{$yearcode}.fixture f 


		INNER JOIN fm{$yearcode}.koround ko ON ko.id=f.KORoundID
		INNER JOIN fm{$yearcode}.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm{$yearcode}.team t1 ON t1.ID=c1.TeamID
		INNER JOIN fm{$yearcode}.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm{$yearcode}.team t2 ON t2.ID=c2.TeamID
		INNER JOIN fm{$yearcode}.division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN fm{$yearcode}.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm{$yearcode}.venue v on v.ID = pa.VenueID
	
	
		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.{$yearcode}id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.{$yearcode}id
		
		LEFT JOIN zmast.lk_division zlkd ON d1.id = zlkd.{$yearcode}id
        LEFT JOIN fm{$yearcode}.event e ON e.eventdate = f.FixtureDate AND e.leaguecode =  '{$league_id}'
	WHERE
		
{$div_args}
		d1.leaguecode = '{$league_id}'
		
	 AND
		(c1.ID $c_filter OR c2.ID $c_filter)  
		AND
		f.FixtureDate BETWEEN '{$start_date}' AND '{$end_date}'
AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))
AND f.Result != 'T'
	ORDER BY
		f.FixtureDate {$order}, umbrella_id, temp_home ASC
	 LIMIT {$limit} ";

        //p($query);die;

        $process = myQ($query);
        //echo mysql_error();
        while ($result = myO($process)) {
            $temp_result = new fixture();
            

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
 
 
        
        
        $detail = (object)array_merge((array )$temp_result, (array )$result);
        

            //p($detail);die;
            $data[] = $detail;
        }


        //p((object)$data);die;

        return $data;

    }



    	/**
	 * This method is called to find and return fixture dates for a team identified by $team_id within a certain date range; noturized by $start_date and $end_date
	 * fixtures can be filtered by certain competions by passing the desired competition in the $division_id_list
	 *
	 * @param int $team_id
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @param string $order [OPTIONAL]
	 * @param string $league_code [OPTIONAL]
	 * @param string $divisions_id [OPTIONAL]
	 * @return fixturedate[]
	 */


   public static function getFixtureDates($team_id, $start_date, $end_date, $limit, $order ="", $league_id = null, $division_id)
    {


        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_id, $start_date, $end_date);

        //Terminate process if league year is not found
        if (is_null($yearcode)) {
            return array();
        }


        //Lets get all the consitutions of this team
        $query = "SELECT id FROM fm{$yearcode}.constitution WHERE teamID IN 
	(
		SELECT teamID FROM fm{$yearcode}.constitution fc JOIN zmast.lk_constitution zl ON zl.{$yearcode}id = fc.id AND zl.id = '$team_id'
	)";


        $result = myQ($query);

        if ($result) {
            while ($constit_temp = myF($result)) {
                $constit_list[] = $constit_temp["id"];

            }
        }


        //p($constit_list);die;

        if (empty($constit_list)) {
            return array();
        } else {
            //p($constit_list);die;

            if (count($constit_list) == 1) {
                $c_filter = " ='" . $constit_list["id"] . "'";
            } else {
                $c_filter = " IN (" . implode(",", $constit_list) . ") ";
            }
        }



        $knockout_q = zmast_manager::knockoutQuery($yearcode, $division_id);

        $lkdid_list = isset($knockout_q["ID"]) ? $knockout_q["ID"] : null;
        $notes_list = isset($knockout_q["Notes"]) ? $knockout_q["Notes"] : null;


        if (!empty($division_id)) {
            $div_list_query = "zlkd.id  IN ($division_id) AND ";
        }


        $query = "
        
        	SELECT 
		DATE_FORMAT(f.FixtureDate, '%Y-%m-%d') AS FixtureDate
	FROM
		fm{$yearcode}.fixture f 
		INNER JOIN fm{$yearcode}.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm{$yearcode}.team t1 ON t1.ID=c1.TeamID
		INNER JOIN fm{$yearcode}.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm{$yearcode}.team t2 ON t2.ID=c2.TeamID
		INNER JOIN fm{$yearcode}.division d1 ON c1.DivisionID = d1.ID

		LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.{$yearcode}id
		LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.{$yearcode}id
		
		LEFT JOIN zmast.lk_division zlkd ON d1.id = zlkd.{$yearcode}id
	WHERE
		{$div_list_query}
		d1.leaguecode = '{$league_id}'
	
	 AND
		(c1.ID $c_filter OR c2.ID $c_filter)  
		AND
		f.FixtureDate BETWEEN '{$start_date}' AND '{$end_date}'
  AND (d1.notes NOT REGEXP 'hidedivision' OR ISNULL(d1.notes))      
	ORDER BY
		f.FixtureDate {$order}
	 LIMIT {$limit} ";

        //p($query);die;

       $process = myQ($query);

        $data = null;
        while ($result = MyO($process)) {
            $temp_data = new fixturedate();
             $_temp_data = (object)array_merge((array )$temp_data, (array )$result);
            $data[] = $_temp_data;
        }


        //p((object)$data);die;

        return $data;

    }


    
    /**
	 * Get details of a fixture
	 * 
	 *
	 * @param int $fixture_id
	 * @param string $league_code
	 * @param string $start_date
	 * @param string $end_date
	 * @return fixture
	 */
    public static function getFixture($fixture_id, $league_code, $start_date, $end_date) 
    {
    
    
    
    
if(!$fixture_id)
return array();
    
    //Let us get the year code
    $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);    
        
if(!$yearcode)
return array();
        
        
        
        
        
 $query = "	SELECT 
		zmlkc1.id AS fixture_home_team_id,
		zmlkc2.id AS fixture_away_team_id,
		t1.longcol AS temp_home,
		t2.longcol AS temp_away,

		f.HomeTeamNotes AS fixture_home_team_notes,
		f.AwayTeamNotes AS fixture_away_team_notes,
		f.fixturenotes AS fixture_notes,
		IF(ISNULL(f.KOTime),'',f.KOTime) AS KOTime,
			
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
				THEN r.LongCol
			ELSE CONCAT(LEFT(r.Forename,1), \". \", r.Surname)
		END
		AS referee_name ,
		CASE
			WHEN LENGTH(TRIM(r1.Forename)) = 0 AND LENGTH(TRIM(r1.Surname)) = 0
				THEN r1.LongCol
			ELSE CONCAT(LEFT(r1.Forename,1), \". \", r1.Surname)
		END
		AS referee_asst1_name,
		CASE
			WHEN LENGTH(TRIM(r2.Forename)) = 0 AND LENGTH(TRIM(r2.Surname)) = 0
				THEN r2.LongCol
			ELSE CONCAT(LEFT(r2.Forename,1), \". \", r2.Surname)
		END
		AS referee_asst2_name,
	 f.FixtureDate AS fixture_date ,
		
		f.Attendance AS attendance ,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.HomeGoals) AS fixture_home_goals,
		IF(f.Result IN('H','A','D') AND f.HomeGoals=0 AND f.AwayGoals=0, NULL,f.AwayGoals) AS fixture_away_goals,
		f.HomePointsAdjust ,
		f.AwayPointsAdjust ,
		f.ID AS fixture_id,
		f.LeagueCode AS LeagueCode,
		f.pitchAvailableID,
		v.LongCol AS venue_name,
		m.notes AS match_report,
		(SELECT leagueName FROM zmast.leagueinfo AS zmli WHERE zmli.LeagueCodePrefix = f.LeagueCode LIMIT 1) AS leaguename,
		f.result as fixture_result
	FROM
		fm{$yearcode}.fixture f
		INNER JOIN fm{$yearcode}.koround k ON k.ID = f.KORoundID
		INNER JOIN fm{$yearcode}.constitution c1 ON c1.ID = f.HomeID
		INNER JOIN fm{$yearcode}.constitution c2 ON c2.ID = f.AwayID
		INNER JOIN fm{$yearcode}.team t1 ON c1.TeamID = t1.ID
		INNER JOIN fm{$yearcode}.team t2 ON c2.TeamID = t2.ID
		INNER JOIN fm{$yearcode}.ordinal o1 ON c1.OrdinalID = o1.ID
		INNER JOIN fm{$yearcode}.ordinal o2 ON c2.OrdinalID = o2.ID
		INNER JOIN fm{$yearcode}.division d1 ON c1.DivisionID = d1.ID
		LEFT JOIN fm{$yearcode}.pitchavailable pa ON pa.ID = f.pitchAvailableID
		LEFT JOIN fm{$yearcode}.venue v ON v.ID = pa.VenueID
		LEFT JOIN fm{$yearcode}.referee r ON r.ID = f.RefereeID
		LEFT JOIN fm{$yearcode}.referee r1 ON r1.ID = f.AsstRef1ID
		LEFT JOIN fm{$yearcode}.referee r2 ON r2.ID = f.AsstRef2ID
		LEFT JOIN fm{$yearcode}.matchreport m ON m.shortcol = f.ID
		
		LEFT JOIN zmast.lk_constitution	AS zmlkc1 ON zmlkc1.{$yearcode}id = c1.ID
		LEFT JOIN zmast.lk_constitution	AS zmlkc2 ON zmlkc2.{$yearcode}id = c2.ID

	WHERE
		f.id = {$fixture_id}";      
        
$process = myQ($query);
$result = MyO($process);


if(!$result)
return array();

$result->fixture_date = date("Y-m-d",strtotime($result->fixture_date));

$temp_result = new fixture();
$detail = (object)array_merge((array )$temp_result, (array )$result);




////Player and lineup details for home and away
$query = "SELECT
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Surname = '' THEN 'xxxxxxxxxx' 
		ELSE p.Surname
	END
	as player_last_name,
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Forename = '' THEN 'xxxxxxxxxx' 
		ELSE p.Forename
	END
	as player_first_name,
	p.ID as player_id  ,
	a.GoalsScored as goals ,
	a.Card as card ,
	a.StarPlayer as star,
	s.ActualShirtNumber as shirt_number
FROM
	player AS p, 
	appearance AS a,
	shirtnumber AS s
WHERE
	p.LeagueCode = '{$detail->LeagueCode}'
	AND a.FixtureID = '{$fixture_id}'
	AND a.HomeAway = 'A' 
	AND a.PlayerID = p.ID
	AND s.AppearanceID=a.ID
ORDER BY
	player_last_name, player_first_name";
    
    
$process = myQ($query);

$_temp_data = null;
$data = null;
while($result = MyO($process)){
    
$temp_data = new team();
$result->played = "yes";
$_temp_data = (object)array_merge((array )$temp_data, (array )$result);
$data[] = $_temp_data;
 
}

$detail->away_team = $data;




 

////Player and lineup details for home and away
$query = "SELECT
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Surname = '' THEN 'xxxxxxxxxx' 
		ELSE p.Surname
	END
	as player_last_name,
	CASE
		WHEN p.shortcol = 0 THEN '        OG' 
		WHEN p.Forename = '' THEN 'xxxxxxxxxx' 
		ELSE p.Forename
	END
	as player_first_name,
	p.ID as player_id  ,
	a.GoalsScored as goals ,
	a.Card as card ,
	a.StarPlayer as star,
	s.ActualShirtNumber as shirt_number
FROM
	player AS p, 
	appearance AS a,
	shirtnumber AS s
WHERE
	p.LeagueCode = '{$detail->LeagueCode}'
	AND a.FixtureID = '{$fixture_id}'
	AND a.HomeAway = 'H' 
	AND a.PlayerID = p.ID
	AND s.AppearanceID=a.ID
ORDER BY
	player_last_name, player_first_name";
    
    
$process = myQ($query);
$_temp_data = null;
$data = null;
while($result = MyO($process)){
    
$temp_data = new team();
$result->played = "yes";
$_temp_data = (object)array_merge((array )$temp_data, (array )$result);
$data[] = $_temp_data;
}

$detail->home_team = $data;


return $detail;
//p($detail);die;
        
        
}



}
?>