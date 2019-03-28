xquery version "1.0";
<result>
{

for $Airport in doc("Flights-Data.xml")/doc/Airport
let $Flights := doc("Flights-Data.xml")/doc/Flight[date = "2005-12-24" and (source = $Airport/@airId or destination = $Airport/@airId)],
	$cnt := count($Flights) * 100
where $cnt != 0
order by $cnt descending
return <Airport> {$Airport/name} <count>{$cnt}</count> </Airport>
}
</result>