# CAA Issuance Tests

We conduct controlled experiments to analyze whether CAs hone the CAA record that has recently come into effect. 

We conduct 1 round of tests right at CAA record effectiveness (around September 9), and a round of re-tests a month later (October 10th).

## Test Domain Setups

We set up several test domains to check various corner cases of CAA deployment.  
This list has some overlap with the nice work at https://caatestsuite.com/  

Zone files can be found under zonefiles/.

 


| Domain | Setup                                    | Expected CA Behavior        | FQDNs                                  | Zone                                     |
| ------ | ---------------------------------------- | --------------------------- | -------------------------------------- | ---------------------------------------- |
| D1     | Zone signed, CAA: 0 issue ";"            | Refuse                      | crossbear.net, gazebear.net            | http://dnsviz.net/d/gazebear.net/Wd9tkA/dnssec/ |
| D2 [1] | Zone signed, Timeout on CAA record       | Refuse                      | crossbear.org, gazebear.org            | http://dnsviz.net/d/gazebear.org/Wd9rVw/dnssec/ |
| D3     | Not signed, issue permitted, but critical flag and nonexistent  CAA record set | Refuse                      | measr.net, gazebear.mobi               | http://dnsviz.net/d/gazebear.mobi/Wd9rQw/dnssec/ |
| D4     | Not signed, timeout on CAA record        | Retry, then Refuse or Issue | perenaster.com, gazebear.info          | http://dnsviz.net/d/gazebear.info/Wd9q7g/dnssec/ |
| D5     | www --> D1                               | Refuse                      | www.gazebear.online, www.gazebear5.com | http://dnsviz.net/d/www.gazebear.online/WeR_8w/dnssec/ , http://dnsviz.net/d/www.gazebear5.com/WeCB8A/dnssec/ |
| D6     | www --> www.D1                           | Refuse or Issue             | www.gazebear.pet, www.gazebear6.com    | (informational test)                     |
| D7     | hash-ca, issue permissive                | Issue                       | HASH.gazebear.site                     | (informational test)                     |
| D8     | hash-ca, issue denied                    | Reject                      | HASH.gazebear.site                     | (informational test)                     |



For case D4, RFC and CAB Ballot permit a CA to issue. However, CAs may (and maybe should) be more conservative and decide to refuse to issue after a timeout no the CAA record.

[1] More explanation on D2: The zonefile contains an "issue ;" CAA record, and all CAA replies for that zone are dropped. As the zone is signed, even in case of a non-dropped reply, no CA would be authorized to issue. 



## CA Test Results 



The first result indicates the result of the first test in September 2017, the second result the re-test in October 2017. 

For example (Refused/Issued) indicates that a CA refused to issue in the first test in September, but issued in the re-test in October.



| CA                                       | D1                                       | D2                                       | D3                                       | D4                                       | D5                                       | D6                         | D7/D8         | Contact              |      |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | -------------------------- | ------------- | -------------------- | ---- |
| **RapidSSL** [1]   (GeoTrust/Thawte/Symantec) | Refused/Refused                          | Refused/[**Issued**](https://crt.sh/?id=228963368) ([Zone](http://dnsviz.net/d/gazebear.org/Wd4lKA/dnssec/)) | Refused/Refused                          | Refused/[**Issued**](https://crt.sh/?id=228965187) | -/Refused                                | --/Issued                  | Issued        | 13.10.17, 11:43 CEST |      |
| Comodo InstantSSL                        | [**Issued**](https://crt.sh/?id=208456003)/Refused | [**Issued**](https://crt.sh/?id=208486485)/[**Issued**](https://crt.sh/?id=229495637) ([Zone](http://dnsviz.net/d/gazebear.org/Wd8zAQ/dnssec/))/Pending | [**Issued**](https://crt.sh/?id=208486489)/Refused | [**Issued**](https://crt.sh/?id=208486495)/[**Issued**](https://crt.sh/?id=229513301) ([Zone](http://dnsviz.net/d/gazebear.info/Wd9FKQ/dnssec/)) | -/Refused                                | -/Issued                   | -/Issued      | 13.10.17, 11:47 CEST |      |
| LetsEncrypt                              | Refused/Refused                          | Refused/Refused                          | Refused/Refused                          | Refused/Refused                          | -/Refused                                | -/Issued                   | -/Issued      | No need              |      |
| GoDaddy                                  | Refused/Refused                          | Refused/Refused                          | Refused/Refused                          | [**Issued**](https://crt.sh/?id=208554363)/[**Issued**](https://certspotter.com/api/v0/certs/98fe0bf8fc9b41a750366df04d6c756ba9f033f4e0720377c47766eab114ea14) | -/Refused                                | -/Issued                   | D8: Refused   | No need              |      |
| Startcom                                 | Refused/Pending                          | [**Issued**](https://crt.sh/?id=206719317)/[**Issued**](https://crt.sh/?id=229543202) | Refused/Pending                          | Refused/[**Issued**](https://crt.sh/?id=229552818) | -/[**Issued**](https://crt.sh/?id=232316961)([Zone](http://dnsviz.net/d/www.gazebear.online/WeR_8w/dnssec/)) | -/Issued (submitted to CT) | -/Issued      | 16.10.17, 15:15 CEST |      |
| Buypass [2]                              | Refused/Refused                          | [**Issued**](https://crt.sh/?id=208455849)/Refused | Refused/Refused (measr.net)              | Cancelled/[**Issued**](https://certspotter.com/api/v0/certs/98fe0bf8fc9b41a750366df04d6c756ba9f033f4e0720377c47766eab114ea14) | -/Refused                                | -/ Refused (gb6.com)       | D8: Refused   | No need              |      |
| Certum                                   | Refused/Refused                          | [**Issued**](https://crt.sh/?id=209378608)/Refused | Refused/[**Issued**](https://crt.sh/?id=229822803) ([Zone](http://dnsviz.net/d/gazebear.mobi/Wd9rQw/dnssec/)) | [**Issued**](https://crt.sh/?id=209403143)/[**Issued**](https://crt.sh/?id=232400028) | -/[**Issued**](https://crt.sh/?id=230122233) ([Zone](http://dnsviz.net/d/www.gazebear.online/Wd9tig/dnssec/)) | -/Issued                   | -/Issued      | 16.10.17, 14:16 CEST |      |
| **Sum**                                  | 1/0                                      | 4/3                                      | 1/1                                      | 3/6                                      | -/2                                      | -/6                        | informational |                      |      |
| Digicert [3]                             | Refused/-                                | --                                       | --                                       | --                                       |                                          |                            |               |                      |      |
| Network Solution [3]                     | Pending/-                                | --                                       | --                                       | --                                       |                                          |                            |               |                      |      |




[1] Other Symantec brands with same backend as RapidSSL not tested individually. FIrst refusal might have been due to missing locality in CSR, we validated second-round CSRs using [this checker](https://cryptoreport.geotrust.com/checker/views/csrCheck.jsp)

[2] First test for D4 cancelled after 2 days in pending, likely in wake of our bug report for D2. 

[3] Due to the high cost of certificates and lengthy validation process, we only tested the basic case for DigiCert and Network Solutions.





Discussion on D2](https://groups.google.com/forum/#!topic/mozilla.dev.security.policy/-o-qkJzPe5Q)

[Comodo First Round Bug Report](https://bugzilla.mozilla.org/show_bug.cgi?id=1398545)



We will update this page as more information becomes available.
You are very welcome to contact us through email/phone as listed on https://www.net.in.tum.de/members/scheitle/



Links:

RapidSSL/GeoTrust/Symantec/Thawte

https://www.freessl.com/freessl/#product-trials

Comodo:

https://www.instantssl.com/free-ssl-certificate.html?track=3338

https://secure.instantssl.com/products/SSLIdASignup1a

Certum

https://en.sklep.certum.pl/test_certificates

CSR checker:

https://cryptoreport.geotrust.com/checker/views/csrCheck.jsp