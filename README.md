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



| CA                | D1                                       | D2                                       | D3                                       | D4                                       | Comment                                  |
| ----------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| RapidSSL          | Refused                                  | Refused                                  | Refused                                  | Refused                                  | same backend as GeoTrust                 |
| GeoTrust          | Refused                                  | Refused                                  | Refused                                  | Refused                                  |                                          |
| Comodo InstantSSL | [**Issued**](https://crt.sh/?id=208456003) | [**Issued**](https://crt.sh/?id=208486485) | [**Issued**](https://crt.sh/?id=208486489) | [**Issued**](https://crt.sh/?id=208486495) | No CAA checks visible at DNS server      |
| LetsEncrypt       | Refused                                  | Refused                                  | Refused                                  | Refused                                  |                                          |
| GoDaddy           | Refused                                  | Refused                                  | Refused                                  | [**Issued**](https://crt.sh/?id=208554363) | D4 issued after 5 minutes of 51 retries from 4 source IP addresses. |
| Startcom          | Refused                                  | [**Issued**](https://crt.sh/?id=206719317) | Refused                                  | Refused                                  |                                          |
| Buypass           | Refused                                  | [**Issued**](https://crt.sh/?id=208455849) | Refused                                  | Cancelled                                | D4 cancelled after 2 days pending in wake of our bug report for D2. |
| Certum            | Refused                                  | [**Issued**](https://crt.sh/?id=209378608) | Refused                                  | [**Issued**](https://crt.sh/?id=209403143) | D4 retried 24 seconds, 7 retries, 1 source IP, towards 1NS. |
| Digicert          | Refused                                  | --                                       | --                                       | --                                       | not all cases tested due to high costs and lengthy organization validation |
| Network Solution  | Pending                                  | --                                       | --                                       | --                                       |                                          |



[Discussion on D2](https://groups.google.com/forum/#!topic/mozilla.dev.security.policy/-o-qkJzPe5Q)

[Comodo Bug Report](https://bugzilla.mozilla.org/show_bug.cgi?id=1398545)



We will update this page as more information becomes available.
You are very welcome to contact us through email/phone as listed on https://www.net.in.tum.de/members/scheitle/
