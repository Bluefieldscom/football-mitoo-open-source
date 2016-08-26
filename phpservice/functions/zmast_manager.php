<?php
class zmast_manager
{ 


    public static function getleagueyear($league_id, $start_date, $end_date)
    { 
 
/// Get the current league year

$query = "SELECT 
		MAX(leagueCodeYear) AS leagueCodeYear
	   FROM 
		zmast.leagueinfo
	   WHERE
		leaguecodeprefix = '$league_id'
	   AND
		HideThisSeason  = 0
	AND
	(
		('$start_date' BETWEEN seasonStartDate AND seasonEndDate)
		OR
		('$end_date' BETWEEN seasonStartDate AND seasonEndDate)
	)";

$process = myQ($query); 
$result = myF($process);


if(isset($result["leagueCodeYear"])) return $result["leagueCodeYear"];
else
return null;

}


 public static function knockoutQuery($yearcode, $division_list){

if(!empty($division_list)){
    
    $try = explode(",",$division_list);
if (!isset($try[1])) {
              $div_list_query = " lkd.ID ='".$division_list."'";
            } else {
                $div_list_query = " lkd.ID IN (".$division_list.") ";
            }
            
     	
}

$query = "SELECT
		lkd.ID, d.Notes
	FROM
		division d
		JOIN zmast.lk_division lkd ON d.id = lkd.{$yearcode}id
	WHERE d.leaguecode = '$yearcode'
	{$div_list_query}";

$process = myQ($query); 

while($result = myO($process))
$_result[$result->ID] = $result->Notes;

return $_result;



}


}
?>