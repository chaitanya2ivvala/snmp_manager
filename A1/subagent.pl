#! /usr/bin/perperl

use NetSNMP::agent (':all');
use NetSNMP::ASN qw(ASN_COUNTER);

sub counter {
  my ($handler, $registration_info, $request_info, $requests) = @_;
  my $request; 

  for($request = $requests; $request; $request = $request->next()) {
    my $oid = $request->getOID();
    if ($request_info->getMode() == MODE_GET) {
      if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) {

        $request->setValue(ASN_COUNTER, time);
      }
      if ($oid >  new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) {
       my @values;
  
   
     my $filename = '/tmp/A1/counters.conf';   
     my @last= split /[.]/,$oid;
     my $val = $last[-1] -1 ;
     
    open(my $fh, '<:encoding(UTF-8)', $filename);
     
    while (my $row = <$fh>) {
      
      
 @values = split(',', $row);

if ($values[0] == $val){
$y=$values[1]*time;
 $request->setValue(ASN_COUNTER, $y);
}
else{
@values = ();
}
}

       }
      }
   }
}
  
my $agent = new NetSNMP::agent();
$agent->register("a1", ".1.3.6.1.4.1.4171.40",
                 \&counter);
