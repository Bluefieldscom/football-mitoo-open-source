<?php

/**
  * Deals with services that relates to getting data about a team
  *
  * Currently contains:
  * getFixtures[]
  * and other methods
  */
class teamservice{

	/**
	 * This method is called to find and return fixtures for a team identified by $team_id within a certain date range; noturized by $start_date and $end_date
	 * fixtures can be filtered by certain competions by passing the desired competition in the $division_id_list
	 *
	 * @param int $team_id
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @param string $order [OPTIONAL]
	 * @param string $league_code [OPTIONAL]
	 * @param string $divisions_id [OPTIONAL]
	 * @return fixture[]
	 */
	public function	getFixtures($team_id,$start_date,$end_date,$limit="50",$order="DESC",$league_code,$divisions_id) {
		$data = teams_manager::getFixtures($team_id,$start_date,$end_date,$limit,$order,$league_code,$divisions_id);
//p($data);die;
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
	public function	getFixtureDates($team_id,$start_date,$end_date,$limit="50",$order="DESC",$league_code,$divisions_id) {
		$data = teams_manager::getFixtureDate($team_id,$start_date,$end_date,$limit,$order,$league_code,$divisions_id);
//p($data);die;
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
	public function	getFixture($fixture_id, $league_code, $start_date, $end_date)  {
		$data = teams_manager::getFixture($fixture_id, $league_code, $start_date, $end_date);
//p($data);die;
		return $data;
	}
	 
}
?>