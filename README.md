# Demo-School

### Port ranges

| Name  | Port Range  |
|-------|-------------|
| CI-CD | 8301 - 8309 |
| Servers | 8311 - 8329 |
| Application | 8331 and above |

---

### Teacher Service
Port Number : 8331

### Kafka Server
Port Number : 8314

### Kafdrop Server
Port Number : 8315

### Zookeeper Server
Port Number : 8313

### Config Server
Port Number : 8312

### Eureka Server
Port Number : 8311

### Gitea
Administrator Username : demoadmin  
Administrator Password : demo#123  
Port Number : 8301

### Jenkins Server
Administrator Username : demoadmin  
Administrator Password : demo#123  
Port Number : 8303





### Components

CI/CD:
   1. Jenkins Server
   2. Git Server - Gitea
   3. Prometheus

Microservice Support:
   1. Discovery Server - Eureka
   2. Config Server
   3. Gateway Server 
   4. ELK

Data:
   1. MongoDB
   2. PostgreSQL
   3. Redis
   4. Kafka

Application:
   1. Teacher Service
   2. School Service
   3. UI Service

