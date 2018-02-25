#!/usr/bin/perl 



 


sub my_receiver {
    print "** Trap Received:\n";      
    $TRAP_FILE = "traps.all.log";    

    open(TRAPFILE, ">> $TRAP_FILE");
    foreach my $x (@{$_[1]}) { 
        printf "  %-30s type=%-2d value=%s\n", $x->[0], $x->[2], $x->[1]; 
        printf TRAPFILE "  %-30s type=%-2d value=%s\n", $x->[0], $x->[2], $x->[1];
        }
    print(TRAPFILE "\n----------\n");
    close(TRAPFILE); 
        $file = `perl mytrapd.pl $fqdn $value`;
        
        
      }

NetSNMP::TrapReceiver::register("all", \&my_receiver) || 
warn "failed to register our perl trap handler\n";
print STDERR "Loaded the example perl snmptrapd handler\n";
