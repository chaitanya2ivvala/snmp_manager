#! /usr/bin/python
from easysnmp import Session
from math import ceil
import sys
import time
import easysnmp
authlist = sys.argv
#print authlist
#print len(sys.argv)

auth = str(authlist[1]).split(":")
freq = float(authlist[2])
freqtim = 1/freq
samples = authlist[3]
samcnt = 0
x = []
y =[]
time1 = ''
time2 =''
final = []
final2 = []
temp =[]
temp2 =[]
sysup = ['1.3.6.1.2.1.1.3.0']
oidslist = authlist[4:len(authlist)]
oids = sysup + oidslist

def snmpreq():

    for i in range(1,len(oids)):
        if temp[i].value!="NOSUCHINSTANCE" and temp2[i].value!="NOSUCHINSTANCE":
            y =int(temp[i].value)
            snmptype =str(temp[i].snmp_type)
            x =int(temp2[i].value)
            if (x > y) and snmptype == "COUNTER":
                k = ((2**32 +y) - x)/(time1 - time2)
                final.append(k)
            elif (x > y) and snmptype == "COUNTER64":
                k = ((2**64 +y) - x)/(time1 - time2)
                final.append(k)
            else:
                k = (y - x)/(time1 - time2)
                final.append(k)
        else:
            print initial,"|" 
    
    if len(final)!=0:
        final2 = [str(get) for get in final]
        print initial ,'|', ("| " . join(final2))

beforestart = time.time()



while (samcnt != int(samples)):
    initial = time.time()
    try:
	  session = Session(hostname=auth[0], remote_port = auth[1], community=auth[2], version=2,timeout=5,retries=1)
	  temp = session.get(oids)
    except easysnmp.exceptions.EasySNMPTimeoutError:
          #print "timeout"
          continue
         
    
    if len(temp) == len(temp2):
        if int(temp[0].value)<int(temp2[0].value):
           print "reeboot"
           temp=[]
           temp2=[]
           t0=time.time()
        else:
         if freqtim < 1:
            time1 =float(temp[0].value)/100
            time2 =float(temp2[0].value)/100
         else:
            time1 =int(temp[0].value)/100
            time2 =int(temp2[0].value)/100
         snmpreq()
         samcnt = samcnt+1
    temp2 = temp[:]
    del final[:]
    endtime =time.time() 
    k1 =ceil((endtime - beforestart)/freqtim)
    sleep1 = (beforestart +k1*freqtim) - endtime
    if sleep1<=0.0:
        sleep1 = (beforestart+(k1+1)*freqtim) - endtime
        time.sleep(sleep1)
        #print "kgjj"
    else:
        sleep1 = (beforestart+k1*freqtim) - endtime
        time.sleep(sleep1)
    

