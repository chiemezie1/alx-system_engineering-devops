# 0x07-networking_basics

## Open Systems Interconnection (OSI)
OSI is an abstract model to describe layered communication and computer network design. The idea is to segregate the different parts of what make communication possible.

It is organized from the lowest level to the highest level:

- The lowest level: layer 1 which is for transmission on physical layers with electrical impulse, light or radio signal
- The highest level: layer 7 which is for application specific communication like SNMP for emails, HTTP for your web browser, etc

Keep in mind that the OSI model is a concept, it’s not even tangible. The OSI model doesn’t perform any functions in the networking process. It is a conceptual framework so we can better understand complex interactions that are happening. Most of the functionality in the OSI model exists in all communications systems.

### Layer architecture OSI model

| Layer |  |  | Protocol data unit (PDU) | Function |
| --- | --- | --- | --- | --- |
| Hostlayers | 7 | Application | Data | High-level protocols such as for resource sharing or remote file access, e.g. HTTP. |
|  | 6 | Presentation |  | Translation of data between a networking service and an application; including character encoding, data compression and encryption/decryption |
|  | 5 | Session |  | Managing communication sessions, i.e., continuous exchange of information in the form of multiple back-and-forth transmissions between two nodes |
|  | 4 | Transport | Segment, Datagram | Reliable transmission of data segments between points on a network, including segmentation, acknowledgement and multiplexing |
| Medialayers | 3 | Network | Packet | Structuring and managing a multi-node network, including addressing, routing and traffic control |
|  | 2 | Data link | Frame | Transmission of data frames between two nodes connected by a physical layer |
|  | 1 | Physical | Bit, Symbol | Transmission and reception of raw bit streams over a physical medium |


## Types of network
LAN connect local devices together, WAN connects LANs together, and WANs are operating over the Internet.

### LAN: Local Area Network
A LAN connects network devices over a relatively short distance. A networked office building, school, or home usually contains a single LAN, though sometimes one building contains a few small LANs (perhaps one per room), and occasionally a LAN spans a group of nearby buildings. In TCP/IP networking, a LAN is often, but not always, implemented as a single IP subnet.
In addition to operating in a limited space, LANs are also typically owned, controlled, and managed by a single person or organization. These networks also tend to use certain connectivity technologies, primarily Ethernet and Token Ring.

### WAN: Wide Area Network
A WAN spans a large physical distance. The internet is the largest WAN, spanning the Earth.
A WAN is a geographically-dispersed collection of LANs. A network device called a router connects LANs to a WAN. In IP networking, the router maintains both a LAN address and a WAN address.
A WAN differs from a LAN in several important ways. Most WANs (like the internet) aren't owned by a single organization. Instead, WANs exist under collective or distributed ownership and management.
WANs tend to use technology like ATM, Frame Relay, and X.25 for connectivity over the longer distances.
