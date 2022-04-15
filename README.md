# Demo-School

### Port ranges

| Name  | Port Range  |
|-------|-------------|
| CI-CD | 7301 - 7309 |
| Servers | 7311 - 7329 |
| Application | 7331 and above |

---

### Teacher Service
Port Number : 7331


### Gitea
Administrator Username : demoadmin  
Administrator Password : demo#123
Port Number : 7301

### Jenkins Server
Administrator Username : demoadmin  
Administrator Password : demo#123
Port Number : 7303





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

