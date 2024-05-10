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

## MAC and IP address

### Media Access Control (MAC) Address
A MAC address is a string of characters that identifies a device on a network. It’s tied to a key connection device in your computer called the network interface card, or NIC. The NIC is essentially a computer circuit card that makes it possible for your computer to connect to a network. A NIC turns data into an electrical signal that can be transmitted over the network.

Every NIC has a hardware address that’s known as a MAC address. Whereas IP addresses are associated with a networking software called TCP/IP, MAC addresses are linked to the hardware of network adapters.

Manufacturers assign a MAC address to a network adapter when it is produced. It is hardwired or hard-coded onto your computer’s NIC and is unique to it. Something called the Address Resolution Protocol (ARP) translates an IP address into a MAC address. Think of the ARP as a passport that takes data from an IP address through an actual piece of computer hardware.

### Internet Protocol (IP) Address
IP address is the unique identifying number assigned to every device connected to the internet. An IP address definition is a numeric label assigned to devices that use the internet to communicate.

#### IPv4 and IPv6 Addresses

There are two flavors of IP Addresses that can be used on a network. The first, and the version that the Internet and most routers are currently configured for, is IPv4 or Internet Protocol version 4. This version uses 32-bit addresses, which limits the amount of addresses to 4,294,967,296 possible unique addresses. Some of these addresses, about 290 million, are also reserved for special purposes. Due to the popular growth of the Internet there has been concern that the pool of possible addresses would be exhausted in the near future. With this in mind, a new version of IP addresses was developed called IPv6, or Internet Protocol version 6, that would change the address size from 32-bit address to 128-bit addresses. This change would allow for generous IP address allocations to networks without any foreseeable problem with the amount of addresses available. In order to use IPv6 addresses, though, existing routers and hardware would need to be upgraded or configured to use this new version of IP addresses.

## UDP and TCP
TCP/IP is a suite of protocols used by devices to communicate over the Internet and most local networks. It is named after two of it's original protocols---the Transmission Control Protocol (TCP) and the Internet Protocol (IP). TCP provides apps a way to deliver (and receive) an ordered and error-checked stream of information packets over the network. The User Datagram Protocol (UDP) is used by apps to deliver a faster stream of information by doing away with error-checking. When configuring some network hardware or software, you may need to know the difference.

### **What They Have In Common**

Both TCP and UDP are protocols used for sending bits of data---known as packets---over the Internet. Both protocols build on top of the IP protocol. In other words, whether you're sending a packet via TCP or UDP, that packet is sent to an IP address. These packets are treated similarly, as they're forwarded from your computer to intermediary routers and on to the destination.

TCP and UDP aren't the only protocols that work on top of IP. However, they are the most widely used.

### **How TCP Works**

TCP is the most commonly used protocol on the Internet.

When you request a web page in your browser, your computer sends TCP packets to the web server's address, asking it to send the web page back to you. The web server responds by sending a stream of TCP packets, which your web browser stitches together to form the web page. When you click a link, sign in, post a comment, or do anything else, your web browser sends TCP packets to the server and the server sends TCP packets back.

TCP is all about reliability---packets sent with TCP are tracked so no data is lost or corrupted in transit. This is why file downloads don't become corrupted even if there are network hiccups. Of course, if the recipient is completely offline, your computer will give up and you'll see an error message saying it can't communicate with the remote host.

TCP achieves this in two ways. First, it orders packets by numbering them. Second, it error-checks by having the recipient send a response back to the sender saying that it has received the message. If the sender doesn't get a correct response, it can resend the packets to ensure the recipient receives them correctly.

### **How UDP Works**

The UDP protocol works similarly to TCP, but it throws out all the error-checking stuff. All the back-and-forth communication introduce latency, slowing things down.

When an app uses UDP, packets are just sent to the recipient. The sender doesn't wait to make sure the recipient received the packet---it just continues sending the next packets. If the recipient misses a few UDP packets here and there, they are just lost---the sender won't resend them. Losing all this overhead means the devices can communicate more quickly.

UDP is used when speed is desirable and error correction isn't necessary. For example, UDP is frequently used for live broadcasts and online games.

For example, let's say you're watching a live video stream, which are often broadcast using UDP instead of TCP. The server just sends a constant stream of UDP packets to computers watching. If you lose your connection for a few seconds, the video may freeze or get jumpy for a moment and then skip to the current bit of the broadcast. If you experience minor packet-loss, the video or audio may be distorted for a moment as the video continues to play without the missing data.

This works similarly in online games. If you miss some UDP packets, player characters may appear to teleport across the map as you receive the newer UDP packets. There's no point in requesting the old packets if you missed them, as the game is continuing without you. All that matters is what's happening right now on the game server---not what happened a few seconds ago. Ditching TCP's error correction helps speed up the game connection and reduce latency.

### **So What?**

Whether an application uses TCP or UDP is up to its developer, and the choice depends on what an application needs. Most apps need the error-correction and robustness of TCP, but some applications need the speed and reduced overhead of UDP. If you fire up a network analysis tool like Wireshark, you can see the different types of packets traveling back and forth.

Unless you're a network administrator or software developer, this shouldn't doesn't affect you too much. If you're configuring your router or firewall software and you're not sure whether an application uses TCP or UDP, you can generally select the "Both" option to have your router or firewall apply the same rule to both TCP and UDP traffic.

##