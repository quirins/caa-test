;; Zone dump (Knot DNS 2.4.0)
perenaster.com.    	0	SOA	li1486-112.members.linode.com. hostmaster.perenaster.com. 10 0 0 0 0
perenaster.com.    	0	NS	li1486-112.members.linode.com.
perenaster.com.    	0	NS	li327-22.members.linode.com.	
perenaster.com.		0	A 	139.162.169.112
perenaster.com.    	0	CAA	0 issue ";" 
perenaster.com.		0	CAA 	0 iodef "mailto:caa@perenaster.com"
perenaster.com.    	0	MX	10 nimbus.net.in.tum.de.
nsffm			0	A	139.162.169.112
nsffm			0	AAAA	2a01:7e01::f03c:91ff:fe79:63a8
nsnewark		0	A	66.228.46.22
nsnewark		0	AAAA	2600:3c03::f03c:91ff:fee2:82c2	
;; Written 16 records
;; Time 2017-08-30 16:54:29 CEST
