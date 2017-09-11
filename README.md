# CAA Issuance Tests

We conduct controlled experiments to analyze whether CAs hone the CAA record that has recently come into effect. 

## Test Domain Setups

We set up 4 test domains to check various corner cases of CAA deployment.  
Another nice list of possible corner cases is here: https://caatestsuite.com/  

The zone files can be found under zonefiles/.

 


| Domain | Setup                                    | Expected CA Behavior        |
| ------ | ---------------------------------------- | --------------------------- |
| D1     | Zone signed, CAA: 0 issue ";"            | Refuse                      |
| D2     | Zone signed, Timeout on CAA record       | Refuse                      |
| D3     | Not signed, issue permitted, but critical flag and nonexistent  CAA record set | Refuse                      |
| D4     | Not signed, timeout on CAA record        | Retry, then Refuse or Issue |



For case D4, RFC and CAB Ballot permit a CA to issue. However, CAs may (and maybe should) be more conservative and decide to refuse to issue after a timeout no the CAA record.



## CA test results



| CA                | D1         | D2         | D3         | D4         | Comment                                  |
| ----------------- | ---------- | ---------- | ---------- | ---------- | ---------------------------------------- |
| RapidSSL          | Refused    | Refused    | Refused    | Refused    | same backend as GeoTrust                 |
| GeoTrust          | Refused    | Refused    | Refused    | Refused    |                                          |
| Comodo InstantSSL | **Issued** | **Issued** | **Issued** | **Issued** | No CAA checks visible at DNS server      |
| LetsEncrypt       | Refused    | Refused    | Refused    | Refused    |                                          |
| GoDaddy           | Refused    | Pending    | Refused    | Issued     |                                          |
| Startcom          | Pending    | **Issued** | Pending    | Pending    |                                          |
| Buypass           | Refused    | **Issued** | Refused    | Pending    |                                          |
| Certum            | Pending    | Pending    | Pending    | Pending    | appears to check, pending for 3 days now |



We will update this page as more information becomes available.
You are very welcome to contact us through email/phone as listed on https://www.net.in.tum.de/members/scheitle/
