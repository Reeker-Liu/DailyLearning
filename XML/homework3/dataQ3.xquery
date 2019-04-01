xquery version "1.0";
<result>
{
for $Airport in doc("Flights-Data.xml")/doc/Airport
let $Flights := doc("Flights-Data.xml")/doc/Flight[date = "2005-12-24" and (source = $Airport/@airId or destination = $Airport/@airId)],
	$Reservations := doc("Flights-Data.xml")/doc/Reservation[flightRef = $Flights/@flightId],
	$Passengers := doc("Flights-Data.xml")/doc/Passenger[passportnumber = $Reservations/passRef],
	$cnt := count($Passengers)
where $cnt > 0
order by $cnt descending
return <Airport> {$Airport/name} <count>{$cnt}</count> </Airport>
}
</result>