<?php

/**
  * Deals with services that relates to getting data about a player
  *
  * Currently contains:
  * getPlayerAppearances[]
  * and other methods
  */
class playerservice{
 
    
    	/**
	 * Get details of a player's appearances
	 * 
	 *
	 * @param int $player_id
	 * @param string $league_code
	 * @param string $start_date
	 * @param string $end_date
	 * @return player[]
	 */
	public function	getPlayerAppearances($player_id, $league_code, $start_date, $end_date)  {
		$data = players_manager::getPlayerAppearances($player_id, $league_code, $start_date, $end_date);
//p($data);die;
		return $data;
	}
	 
}
?>