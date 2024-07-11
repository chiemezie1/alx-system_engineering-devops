## HAProxy 

There are many terms and concepts that are important when discussing load balancing and proxying. You’ll go over commonly used terms in the following subsections.

Before you get into the basic types of load balancing, you should begin with a review of ACLs, backends, and frontends.

### Access Control List (ACL)

In relation to load balancing, ACLs are used to test some condition and perform an action (e.g. select a server, or block a request) based on the test result. Use of ACLs allows flexible network traffic forwarding based on a variety of factors like pattern-matching and the number of connections to a backend, for example.

Example of an ACL:

```
acl url_blog path_beg /blog

```

This ACL is matched if the path of a user’s request begins with `/blog`. This would match a request of `http://yourdomain.com/blog/blog-entry-1`, for example.

For a detailed guide on ACL usage, check out the [HAProxy Configuration Manual](https://www.haproxy.com/documentation/hapee/latest/configuration/acls/syntax/).

### [Backend](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#backend)

A backend is a set of servers that receives forwarded requests. Backends are defined in the *backend* section of the HAProxy configuration. In its most basic form, a backend can be defined by:

- which load balance algorithm to use
- a list of servers and ports

A backend can contain one or many servers in it. Generally speaking, adding more servers to your backend will increase your potential load capacity by spreading the load over multiple servers. Increased reliability is also achieved through this manner, in case some of your backend servers become unavailable.

Here is an example of a two backend configuration, `web-backend` and `blog-backend` with two web servers in each, listening on port 80:

```
backend web-backend
   balance roundrobin
   server web1 web1.yourdomain.com:80 check
   server web2 web2.yourdomain.com:80 check

backend blog-backend
   balance roundrobin
   mode http
   server blog1 blog1.yourdomain.com:80 check
   server blog1 blog1.yourdomain.com:80 check

```

`balance roundrobin` line specifies the load balancing algorithm, which is detailed in the [Load Balancing Algorithms](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#load-balancing-algorithms) section.

`mode http` specifies that layer 7 proxying will be used, which is explained in the [Types of Load Balancing](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#types-of-load-balancing) section.

The `check` option at the end of the `server` directives specifies that health checks should be performed on those backend servers.

### [Frontend](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#frontend)

A frontend defines how requests should be forwarded to backends. Frontends are defined in the `frontend` section of the HAProxy configuration. Their definitions are composed of the following components:

- a set of IP addresses and a port (e.g. 10.1.1.7:80, *:443, etc.)
- ACLs
- `use_backend` rules, which define which backends to use depending on which ACL conditions are matched, and/or a `default_backend` rule that handles every other case

A frontend can be configured to various types of network traffic, as explained in the next section.

## [Types of Load Balancing](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#types-of-load-balancing)

Now that you have an understanding of the basic components that are used in load balancing, you can move into the basic types of load balancing.

### [No Load Balancing](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#no-load-balancing)

A simple web application environment with no load balancing might look like the following:

!https://assets.digitalocean.com/articles/HAProxy/web_server.png

No Load Balancing

In this example, the user connects directly to your web server, at `yourdomain.com` and there is no load balancing. If your single web server goes down, the user will no longer be able to access your web server. Additionally, if many users are trying to access your server simultaneously and it is unable to handle the load, they may have a slow experience or they may not be able to connect at all.

### [Layer 4 Load Balancing](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#layer-4-load-balancing)

The simplest way to load balance network traffic to multiple servers is to use layer 4 (transport layer) load balancing. Load balancing this way will forward user traffic based on IP range and port (i.e. if a request comes in for `http://yourdomain.com/anything`, the traffic will be forwarded to the backend that handles all the requests for `yourdomain.com` on `port 80`). For more details on layer 4, check out the *TCP* subsection of our [Introduction to Networking](https://www.digitalocean.com/community/tutorials/an-introduction-to-networking-terminology-interfaces-and-protocols#protocols).

Here is a diagram of a simple example of layer 4 load balancing:

!https://assets.digitalocean.com/articles/HAProxy/layer_4_load_balancing.png

Layer 4 Load Balancing

The user accesses the load balancer, which forwards the user’s request to the *web-backend* group of backend servers. Whichever backend server is selected will respond directly to the user’s request. Generally, all of the servers in the *web-backend* should be serving identical content–otherwise the user might receive inconsistent content. Note that both web servers connect to the same database server.

### [Layer 7 Load Balancing](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#layer-7-load-balancing)

Another, more complex way to load balance network traffic is to use layer 7 (application layer) load balancing. Using layer 7 allows the load balancer to forward requests to different backend servers based on the content of the user’s request. This mode of load balancing allows you to run multiple web application servers under the same domain and port. For more details on layer 7, check out the *HTTP* subsection of our [Introduction to Networking](https://www.digitalocean.com/community/tutorials/an-introduction-to-networking-terminology-interfaces-and-protocols#protocols).

Here is a diagram of a simple example of layer 7 load balancing:

!https://assets.digitalocean.com/articles/HAProxy/layer_7_load_balancing.png

Layer 7 Load Balancing

In this example, if a user requests `yourdomain.com/blog`, they are forwarded to the *blog* backend, which is a set of servers that run a blog application. Other requests are forwarded to *web-backend*, which might be running another application. Both backends use the same database server, in this example.

A snippet of the example frontend configuration would look like this:

```
frontend http
  bind *:80
  mode http

  acl url_blog path_beg /blog
  use_backend blog-backend if url_blog

  default_backend web-backend

```

This configures a frontend named `http`, which handles all incoming traffic on port 80.

`acl url_blog path_beg /blog` matches a request if the path of the user’s request begins with `/blog`.

`use_backend blog-backend if url_blog` uses the ACL to proxy the traffic to `blog-backend`.

`default_backend web-backend` specifies that all other traffic will be forwarded to `web-backend`.

## [Load Balancing Algorithms](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#load-balancing-algorithms)

The load balancing algorithm that is used determines which server, in a backend, will be selected when load balancing. HAProxy offers several options for algorithms. In addition to the load balancing algorithm, servers can be assigned a *weight* parameter to manipulate how frequently the server is selected, compared to other servers.

A few of the commonly used algorithms are as follows:

### [roundrobin](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#roundrobin)

Round Robin selects servers in turns. This is the default algorithm.

### [leastconn](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#leastconn)

Selects the server with the least number of connections. This is recommended for longer sessions. Servers in the same backend are also rotated in a round-robin fashion.

### [source](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#source)

This selects which server to use based on a hash of the source IP address that users are making requests from. This method ensures that the same users will connect to the same servers.

## [Sticky Sessions](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#sticky-sessions)

Some applications require that a user continues to connect to the same backend server. This can be achieved through *sticky sessions*, using the `appsession` parameter in the backend that requires it.

## [Health Check](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#health-check)

HAProxy uses health checks to determine if a backend server is available to process requests. This avoids having to manually remove a server from the backend if it becomes unavailable. The default health check is to try to establish a TCP connection to the server.

If a server fails a health check, and therefore is unable to serve requests, it is automatically disabled in the backend, and traffic will not be forwarded to it until it becomes healthy again. If all servers in a backend fail, the service will become unavailable until at least one of those backend servers becomes healthy again.

For certain types of backends, like database servers, the default health check is not necessarily to determine whether a server is still healthy.

The Nginx web server can also be used as a standalone proxy server or load balancer, and is often used in conjunction with HAProxy for its caching and compression capabilities.

## [High Availability](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts#high-availability)

The layer 4 and 7 load balancing setups described in this tutorial both use a load balancer to direct traffic to one of many backend servers. However, your load balancer is a single point of failure in these setups; if it goes down or gets overwhelmed with requests, it can cause high latency or downtime for your service.

A *high availability* (HA) setup is broadly defined as infrastructure without a single point of failure. It prevents a single server failure from being a downtime event by adding redundancy to every layer of your architecture. A load balancer facilitates redundancy for the backend layer (web/app servers), but for a true high availability setup, you need to have redundant load balancers as well.

Here is a diagram of a high availability setup:

!https://assets.digitalocean.com/articles/high_availability/ha-diagram-animated.gif

In this example, you have multiple load balancers (one active and one or more passive) behind a static IP address that can be remapped from one server to another. When a user accesses your website, the request goes through the external IP address to the active load balancer. If that load balancer fails, your failover mechanism will detect it and automatically reassign the IP address to one of the passive servers. There are a number of different ways to implement an active/passive HA setup. To learn more, read [How To Use Reserved IPs](https://www.digitalocean.com/community/tutorials/how-to-use-floating-ips-on-digitalocean).