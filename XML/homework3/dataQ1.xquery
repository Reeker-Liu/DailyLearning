xquery version "1.0";

<result>
{
for $flight in doc("Flights-Data.xml")/doc/Flight
let $d := $flight/date
where $d = "2005-12-24"
return $flight
}
</result>