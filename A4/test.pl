#!/usr/bin/perl
use DBI;
use Net::SNMP qw(:ALL);
use NetSNMP::TrapReceiver;
my $d;
my $b;
my $driv   = "SQLite";
my $database = "macho.db";
my $dat = "DBI:$driv:dbname=$database";

my $db = DBI->connect($dat)
   or die $DBI::errstr;
print "Opened database successfully\n";
my $create = qq(CREATE TABLE IF NOT EXISTS mahesh
   (  devicename        TEXT    NOT NULL,
      presentstatus     INT     NOT NULL,
      presenttime       INT     NOT NULL,
      oldstatus         INT     NOT NULL,
      oldtime           INT     NOT NULL););

my $mca = $db->do($create);
if($mca < 0) {
   print $DBI::errstr;
} else {
   print "Table created successfully\n";
}

sub my_receiver          
                                    {
foreach my $x (@{$_[1]}) 
                         { 
if ("$x->[0]" eq ".1.3.6.1.4.1.41717.10.1")
{
    $d = $x->[1];
    $tm = time(); 
}
if ("$x->[0]" eq ".1.3.6.1.4.1.41717.10.2")
{
    $b = $x->[1];
}
$d =~ s/\"//gs;           }
print "$d\n";
print "$b\n";
print "$tm\n";
my $DSN = q/dbi:ODBC:SQLSERVER/;
my $cou = $db->selectrow_array('SELECT COUNT(*) FROM mahesh');
print "$cou\n";
    if ($cou!=0)
      {
        $f = qq(SELECT * from mahesh;);
        $fp = $db->prepare( $f );
        $fg = $fp->execute() or die $DBI::errstr;
        my $count = 0;
        while(my @row = $fp->fetchrow_array()) 
          {    
            my $dev = $row[0];
            my $stat = $row[1];
            my $tim = $row[2];
            if ($dev eq $d)
              {
                my $updt = qq(UPDATE mahesh set devicename = '$d', presentstatus='$b',presenttime= '$tm',oldstatus='$stat', oldtime= presenttime where devicename ='$d';);
                my $updtg = $db->do($updt) or die $DBI::errstr;
                print "Trap UPDATE\n";
                $count = $count + 1;
              }
            else
              {
              }
           }
        if ($count == 0)
          {
            my $insrt = qq(INSERT OR IGNORE INTO mahesh (devicename,presentstatus, presenttime,oldstatus,oldtime) VALUES ('$d', '$b', '$tm', '$b', '$tm'));
            my $insrtg = $db->do($insrt) or die $DBI::errstr;
            print "New Trap\n";
          }
        }
    else
      {
        my $insrt = qq(INSERT INTO mahesh (devicename,presentstatus, presenttime,oldstatus,oldtime) VALUES ('$d', '$b', '$tm', '$b', '$tm'));
        my $insrtg = $db->do($insrt) or die $DBI::errstr;
        print "First Trap\n";
      }

@dang=();
@fail=();
$sql="SELECT devicename,presenttime,oldstatus,oldtime FROM mahesh WHERE presentstatus = 2 AND oldstatus!=3";
my $sth=$db->prepare($sql);
$res=$sth->execute();
$s=1;
$g=1;
while(@t=$sth->fetchrow_array){
push(@dang,'.1.3.6.1.4.1.41717.30.'.($g),OCTET_STRING,$t[$s-1],'.1.3.6.1.4.1.41717.30.'.($g+1),TIMETICKS,$t[$s],'.1.3.6.1.4.1.41717.30.'.($g+2),INTEGER,$t[$s+1],'.1.3.6.1.4.1.41717.30.'.($g+3),TIMETICKS,$t[$s+2]);
#print "$t[$s-1],$t[$s],$t[$s+1],$t[$s+2] \n";
$g=$g+4;
}
print "@dang \n";

$sql="SELECT devicename,presenttime,oldstatus,oldtime FROM mahesh WHERE presentstatus = 3";
my $sth=$db->prepare($sql);
$res=$sth->execute();
$r=1;
while(@t=$sth->fetchrow_array){
push(@fail,'.1.3.6.1.4.1.41717.20.'.($r),OCTET_STRING,$t[$r-1],'.1.3.6.1.4.1.41717.20.'.($r+1),TIMETICKS,$t[$r],'.1.3.6.1.4.1.41717.20.'.($r+2),INTEGER,$t[$r+1],'.1.3.6.1.4.1.41717.20.'.($r+3),TIMETICKS,$t[$r+2]);
#print "$t[$s-1],$t[$s],$t[$s+1],$t[$s+2] \n";

}
print "@fail \n";
push(@fail,@dang);


$sql = "SELECT * from anm";
        $fetprep = $db->prepare($sql);
        $fetg= $fetprep->execute();
        while(my @r = $fetprep->fetchrow_array) 
          {    
            $ip=$r[0];
            $port=$r[1];
            $commu=$r[2];
          
            

my ($session, $error) = Net::SNMP->session(
   -community => $commu,
   -hostname  => $ip,
   -port      => $port,
);

if (!defined($session)) {
   printf("ERROR: %s.\n", $error);
   exit1;
}
else {
print "sessioncreated\n";
     }
my $Trap = $session->trap(-varbindlist => \@fail);
if (!defined($Trap)){
print ("TRAP not received\n" . $session->error());
                    }
else{
print ("TRAP received\n");
    }
            }

                         }
NetSNMP::TrapReceiver::register("all", \&my_receiver) || 
warn "failed to register our perl trap handler\n";
print STDERR " OK Running successfully\n";

