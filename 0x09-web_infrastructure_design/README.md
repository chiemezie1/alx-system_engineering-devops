# Web Infrastructure Design Project

This project focuses on designing various web infrastructures using different configurations and components. The project aims to enhance understanding of web infrastructure concepts such as servers, load balancers, databases, security, and monitoring.

## Project Structure

The project is divided into four tasks, each requiring the design of a specific web infrastructure configuration:

1. **Simple Web Stack**: Design a single-server web infrastructure with basic components.
2. **Distributed Web Infrastructure**: Design a multi-server web infrastructure with load balancing.
3. **Secured and Monitored Web Infrastructure**: Design a web infrastructure with enhanced security and monitoring features.
4. **Scale Up**: Design a scalable web infrastructure with split components and load balancing cluster.

## Instructions for Each Task

### Task 0: Simple Web Stack
#### Draw a diagram of a single-server web infrastructure.
**Diagram**
[Diagram URL](https://imgur.com/a/Ohb0oA7)

**Explanation**
- **What is a server?**
    ◦ A server is a computer that provides resources, data, or services to other computers, known as clients, over a network. In the context of web infrastructure, a server typically refers to a physical or virtual machine that hosts websites, applications, or databases.
    ◦ The term "server" is used interchangeably with "computer" in web infrastructure.
    
    **Do not mix up web server and server.**
    A web server is a software that delivers web pages. A server is an actual computer.
    But you might hear people referring to a web server using the word server.

- **What is the role of the domain name?**
    ◦ A domain name is a human-readable label that is used to access websites and other resources on the internet. It serves as an easy-to-remember alias for the IP address of the server hosting the website. The role of a domain name is to provide a user-friendly way to navigate the internet, associating memorable names with specific IP addresses.
- **What type of DNS record is www in www.foobar.com?**
    ◦ The "www" in "www.foobar.com" typically refers to a subdomain, and it is commonly associated with a CNAME (Canonical Name) DNS record. This CNAME record points to the root domain "foobar.com" or directly to the IP address of the server hosting the website.
- **What is the role of the web server?**
    ◦ The web server handles incoming HTTP requests from clients (such as web browsers) and responds with web pages or other resources. It serves static content directly and forwards dynamic requests to the application server for processing. Essentially, the web server's role is to deliver web content to users in response to their requests.
- **What is the role of the application server?**
    ◦ The application server executes the business logic of web applications and generates dynamic content in response to client requests. It interacts with databases, processes user inputs, performs calculations, and carries out other tasks required to fulfill the functionality of the web application.
- **What is the role of the database?**
    ◦ The database stores and manages structured data used by the web application. It provides a persistent storage mechanism for information such as user profiles, product catalogs, transaction records, and more. The database allows the application server to retrieve, manipulate, and store data efficiently.
- **What is the server using to communicate with the computer of the user requesting the website?**
    ◦ The server communicates with the user's computer over the internet using the HTTP (Hypertext Transfer Protocol) or HTTPS (HTTP Secure) protocol. When a user requests a website by typing a domain name into their web browser, the browser sends an HTTP request to the server. The server processes the request and sends back an HTTP response containing the requested content.

- **Issues with this infrastructure:**
    - **Single Point of Failure (SPOF):**
    The entire infrastructure relies on a single server, making it vulnerable to failure. If the server goes down, the website becomes inaccessible.
    - **Downtime during Maintenance:**
    Deploying new code or performing maintenance on the web server requires restarting services, causing downtime and potentially disrupting user access.
    - **Limited Scalability:**
    The infrastructure cannot efficiently handle a large volume of incoming traffic. As traffic increases, the server may become overloaded, leading to degraded performance or downtime. Without additional servers or load balancing mechanisms, scaling the infrastructure is challenging.


### Task 1: Distributed Web Infrastructure
#### Draw a diagram of a multi-server web infrastructure with load balancing.
**Diagram**
[Diagram URL](https://imgur.com/a/EKbTXBh)

**Explanation**
- **why you are adding it:**
    - **Additional Servers**: Adding additional servers increases redundancy and fault tolerance. If one server fails, the others can continue to handle traffic, reducing the risk of downtime.
    - **Load Balancer (HAproxy)**: The load balancer distributes incoming traffic across multiple servers, preventing any single server from becoming overwhelmed and improving overall performance and reliability.
    - **Database (MySQL)**: The database stores and manages application data, providing a central repository for information accessed by the application servers.
- **Distribution Algorithm of Load Balancer and How It Works:**
    - The load balancer is configured with a round-robin distribution algorithm. This algorithm routes incoming requests to each server in a cyclic order, ensuring an even distribution of traffic among the servers. For example, if there are two servers, the first request goes to Server 1, the second request to Server 2, the third request back to Server 1, and so on.
- **Active-Active vs. Active-Passive Setup:**
    - The load balancer is configured for an Active-Active setup. In an Active-Active setup, all servers actively handle incoming traffic simultaneously. Each server is capable of processing requests independently, providing better resource utilization and scalability. In contrast, an Active-Passive setup involves one server actively handling traffic while the other remains on standby. Only the active server processes requests, and the passive server takes over only if the active server fails.
- **How a Database Primary-Replica (Master-Slave) Cluster Works:**
    - In a Primary-Replica (Master-Slave) cluster, the primary database server (master) handles write operations, such as inserting, updating, or deleting data. The primary server then replicates these changes to one or more replica servers (slaves), which handle read operations. Replication ensures that data changes made on the primary server are propagated to the replica servers, maintaining data consistency across the cluster.
- **Difference Between Primary Node and Replica Node in Regard to the Application:**
    - The primary node is responsible for handling write operations and updating the database with new data. The application interacts primarily with the primary node when performing write operations. In contrast, replica nodes are used for read operations, such as fetching data for display or analysis. The application can distribute read queries across multiple replica nodes to improve performance and scalability.
- **Issues with this Infrastructure:**
    - **Single Point of Failure (SPOF)**: The load balancer can become a single point of failure. If the load balancer fails, incoming traffic cannot be distributed among the servers, leading to service disruption.
    - **Security Issues (No Firewall, No HTTPS)**: Lack of firewall protection and HTTPS encryption leaves the infrastructure vulnerable to security threats, such as unauthorized access, data breaches, and interception of sensitive information.
    - **No Monitoring**: Without monitoring, it is challenging to detect and address performance issues, resource constraints, or system failures promptly. Monitoring is essential for identifying and mitigating potential problems before they affect users.

### Task 2: Secured and Monitored Web Infrastructure
#### Draw a diagram of a secured and monitored web infrastructure.
**Diagram**
[Diagram URL](https://imgur.com/7H8yNiR)

**Explanation**
- **why you are adding**
    - **3 Firewalls**: Firewalls are added to protect the infrastructure by controlling incoming and outgoing network traffic based on predetermined security rules. They are placed at strategic points:
        1. Between the internet and the load balancer to filter external threats.
        2. Between the load balancer and the web/application servers to isolate internal traffic.
        3. Between the web/application servers and the database server to secure the database layer.
    - **SSL Certificate**: An SSL certificate is added to serve the website over HTTPS, ensuring encrypted communication between the user's browser and the server. This protects data in transit from eavesdropping and tampering.
    - **3 Monitoring Clients**: Monitoring clients are installed on each server (web server, application server, and database server) to collect performance metrics and log data. This enables proactive monitoring and alerting for any potential issues.
- **What are firewalls for:**
    - Firewalls are security devices or software that monitor and control incoming and outgoing network traffic based on predefined security rules. They help to:
        - Block unauthorized access.
        - Prevent attacks such as DDoS, SQL injection, and cross-site scripting.
        - Segment the network to minimize the impact of any potential breaches.
- **Why is the traffic served over HTTPS:**
    - Serving traffic over HTTPS encrypts the data transmitted between the user's browser and the web server, providing:
        - Data integrity: Ensuring that data sent between the server and the client is not tampered with.
        - Authentication: Verifying that users are connecting to the intended server.
        - Confidentiality: Protecting sensitive information from being intercepted by third parties.
- **What monitoring is used for:**
    - Monitoring is used to:
        - Track the performance and health of the infrastructure.
        - Detect and alert on anomalies, errors, or failures.
        - Collect logs and metrics for analysis and troubleshooting.
        - Ensure the availability and reliability of services.
- **How the monitoring tool is collecting data:**
    - The monitoring tool collects data through agents or clients installed on each server. These agents gather metrics such as CPU usage, memory usage, disk I/O, network traffic, and application-specific metrics. The data is then sent to a centralized monitoring server or service (e.g., Sumologic) for aggregation, analysis, and visualization.
- **Explain what to do if you want to monitor your web server QPS:**
    - To monitor your web server's Queries Per Second (QPS):
        - Install a monitoring agent on the web server.
        - Configure the agent to track the number of HTTP requests per second.
        - Set up dashboards and alerts in the monitoring tool to visualize QPS and notify you if it exceeds predefined thresholds.

### Issues with this Infrastructure

- **Why terminating SSL at the load balancer level is an issue:**
    - Terminating SSL at the load balancer means that traffic between the load balancer and the backend servers is not encrypted. This can be problematic if the internal network is compromised, as it exposes sensitive data to potential interception. Ideally, end-to-end encryption should be implemented to ensure data security throughout the entire path.
- **Why having only one MySQL server capable of accepting writes is an issue:**
    - Having a single MySQL server for writes creates a bottleneck and a single point of failure (SPOF). If the write server goes down, the entire application can become non-functional. Additionally, the single server may struggle to handle high write loads, leading to performance issues. Implementing a primary-replica (master-slave) setup or database clustering can distribute the load and enhance availability.
- **Why having servers with all the same components (database, web server, and application server) might be a problem:**
    - Having servers with all components (monolithic servers) can lead to resource contention and inefficient use of resources. Different components have different resource requirements and scaling characteristics. Separating components onto dedicated servers allows for:
        - Better resource allocation and optimization.
        - Independent scaling of components based on their specific needs (e.g., scaling web servers independently from database servers).
        - Improved fault isolation, as issues in one component do not directly affect the others.

### Task 3: Scale Up
#### Draw a diagram of a scalable web infrastructure with split components.
**Diagram**
[Diagram URL](https://imgur.com/your_image_link)

**Explanation**

## Example Submission for Task 0


This project is part of the ALX System Engineering DevOps track.