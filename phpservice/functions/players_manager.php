<?php
class players_manager
{

    /* Get details of a player's appearance
    * @param int $player_id
    * @param string $league_code
    * @param string $start_date
    * @param string $end_date
    * @return details[]]
    */

    public static function getPlayerAppearances($player_id, $league_code, $start_date,
        $end_date)
    {

        if (!$player_id)
            return array();

        //Let us get the year code
        $yearcode = zmast_manager::getleagueyear($league_code, $start_date, $end_date);

        if (!$yearcode)
            return array();


        $query = "	SELECT
		p.id as player_id,
		p.mediumCol as player_dob,
		p.forename AS player_forename,
		p.surname player_surname,
		FixtureDate AS fixture_date ,
		f.ID as fixture_id ,
		f.HomeGoals AS fixture_home_goals ,
		f.AwayGoals AS fixture_away_goals ,
		t1.LongCol as home_temp ,
		t2.LongCol as away_temp ,
		zlkc1.ID as fixture_home_team_id,
		zlkc2.ID as fixture_away_team_id,
		a.GoalsScored AS player_goals_scored ,
		a.HomeAway AS player_homeaway,
		a.Card as fixture_cards,
		a.StarPlayer as fixture_starplayer
	FROM
		fm{$yearcode}.appearance a
		
	INNER JOIN fm{$yearcode}.fixture f ON f.id=a.fixtureid
	INNER JOIN fm{$yearcode}.player p ON p.id=a.playerid
	
	INNER JOIN fm{$yearcode}.constitution c1 ON c1.id=f.homeid
	INNER JOIN fm{$yearcode}.team t1 ON t1.id=c1.teamid
	
	INNER JOIN fm{$yearcode}.constitution c2 ON c2.id=f.awayid
	INNER JOIN fm{$yearcode}.team t2 ON t2.id=c2.teamid
	
	LEFT JOIN zmast.lk_constitution zlkc1 ON c1.ID = zlkc1.{$yearcode}id
	LEFT JOIN zmast.lk_constitution zlkc2 ON c2.ID = zlkc2.{$yearcode}id
	
	WHERE
		p.ID = {$player_id}
	ORDER BY
		f.FixtureDate";

        $process = myQ($query);

        while ($result = MyO($process)) {
            $temp_data = new player();
            $result->fixture_date = date("Y-m-d", strtotime($result->fixture_date));
            $result->player_homeaway = $result->player_home_away;
            $_temp_data = (object)array_merge((array)$temp_data, (array)$result);
            $data[] = $_temp_data;
       }


        if (!$data)
            return array();


       // p($data);die;
        return $data;


    }


}
?>