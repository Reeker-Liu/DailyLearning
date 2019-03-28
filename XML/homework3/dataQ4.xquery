xquery version "1.0";
<result>
{
for $Flight in doc("Flights-Data.xml")/doc/Flight
let $Passenger := doc("Flights-Data.xml")/doc/Passenger[name = "Santa Claus"],
	$Reservation := doc("Flights-Data.xml")/doc/Reservation[passRef = $Passenger/passportnumber]
where $Flight/@flightId = $Reservation/flightRef
return $Flight/destination
}
</result>