xquery version "1.0";
<result>
{
let $Airports := 

for $Airport in doc("Flights-Data.xml")/doc/Airport
let $cnt := count(doc("Flights-Data.xml")/doc/Flight[date = "2005-12-24" and (source = $Airport/@airId or destination = $Airport/@airId)])
order by $cnt descending
return <Airport> {$Airport/name} <count>{$cnt}</count> </Airport>

return $Airports[1]
}
</result>