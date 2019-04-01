xquery version "1.0";

<result>
{
for $flight in doc("Flights-Data.xml")/doc/Flight
where $flight/date = "2005-12-24" and $flight/source = "NPL"
return $flight
}
</result>