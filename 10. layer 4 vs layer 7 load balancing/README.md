# Difference between layer 4 and layer 7 load balancing.



| Layer 4                                                 |                           Layer 7                            |
| :------------------------------------------------------ | :----------------------------------------------------------: |
| Applies to both UDP and TCP traffic                     |            Applies to TCP based traffic like HTTP            |
| Can't see the content of the packet, so **more secure** | Can see the content of the packet and make necessary decision based on that so **less secure** |
| Can't do smart load balancing based on content          |                     Offers smart routing                     |
| Simply forwards the packets so no caching               |                       Provides caching                       |
| Is less expensive                                       |                      Is more expensive                       |
| Does not decrypt                                        |                     Requires decrypting                      |
| Stateful                                                |                         Not stateful                         |
| Ideal for simple packet level load balancing            |         Ideal for path content based load balancing          |
| Faster                                                  |                            Slower                            |
| Uses NAT                                                |                                                              |

