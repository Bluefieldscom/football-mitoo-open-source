<?php

/**
  * Deals with services that relates to getting data about a division
  *
  * Currently contains:
  * and other methods
  */
class divisionservice{



	/**
	 * Returns recent competition table for a given division
	 *
	 * @param int $division_id
	 * @param string $league_code [OPTIONAL]
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @return table[]
	 */
	public function	getDivisionTable($division_id,$league_code,$start_date,$end_date,$limit="50") {
		$data = divisions_manager::getDivisionTable($division_id,$league_code,$start_date,$end_date,$limit);
//p($data);die;
		return $data;
	}
	
    
    	/**
	 * Returns recent competition table for a given division
	 *
	 * @param int $division_id
	 * @param string $league_code [OPTIONAL]
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @return form[]
	 */
	public function	getDivisionForm($division_id,$league_code,$start_date,$end_date,$limit="50") {
		$data = divisions_manager::getDivisionForm($division_id,$league_code,$start_date,$end_date,$limit);
//p($data);die;
		return $data;
	}
	
    
    
    
	/**
	 * Returns Top scorers for selected division categories
	 *
	 * @param int $division_id
	 * @param string $league_code [OPTIONAL]
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $start [OPTIONAL]
	 * @return player[]
	 */
	public function	getDivisionTopScorers($division_id,$league_code,$start_date,$end_date,$start=0) {
		$data = divisions_manager::getDivisionTopScorers($division_id,$league_code,$start_date,$end_date,$start);
//p($data);die;
		return $data;
	}
    
    
    
    	/**
	 * This Get fixtures for a division (or set of divisions in divisions_list)
	 * @param string $division_id
	 * @param string $league_code [OPTIONAL]
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @param string $order [OPTIONAL]
	 * @return fixture[]
	 */
	public function	getDivisionFixtures($division_id,$league_code,$start_date,$end_date,$limit,$order="DESC") {
		$data = divisions_manager::getDivisionFixtures($division_id,$league_code,$start_date,$end_date,$limit,$order);
//p($data);die;
		return $data;
	}
	
    
      
    	/**
	 * This Get fixture dates for a division (or set of divisions in divisions_list)
	 * @param string $division_id
	 * @param string $league_code [OPTIONAL]
	 * @param string $start_date
	 * @param string $end_date
	 * @param int $limit [OPTIONAL]
	 * @param string $order [OPTIONAL]
	 * @return fixturedate[]
	 */
	public function	getDivisionFixtureDates($division_id,$league_code,$start_date,$end_date,$limit,$order="DESC") {
		$data = divisions_manager::getDivisionFixtureDates($division_id,$league_code,$start_date,$end_date,$limit,$order);
//p($data);die;
		return $data;
	}



}
?>