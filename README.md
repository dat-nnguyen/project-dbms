# MySQL Master-Slave Replication with Docker Compose

A production-ready Docker Compose setup for MySQL 8.0 master-slave (master-replica) replication using GTID (Global Transaction ID) for high availability and data consistency.

## 📋 Overview

This project provides a complete MySQL replication infrastructure with:
- **1 Master** (Read/Write)
- **2 Slaves** (Read-Only)
- **Automated initialization** with educational institution database schema and sample data
- **GTID-based replication** for consistency and failover capability
- **Docker Compose** orchestration for easy deployment

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│    Docker Compose Network (bridge)      │
├─────────────┬──────────────┬────────────┤
│   Master    │    Slave 1   │   Slave 2  │
│ :3309 (3306)│ :3307 (3306) │ :3308 (3306)
│ Read/Write  │  Read-Only   │  Read-Only │
└─────────────┴──────────────┴────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose (v3.8+)
- At least 3GB free RAM
- macOS, Linux, or Windows with Docker Desktop

### Installation & Running

1. **Clone the repository**
   ```bash
   git clone <https://github.com/dat-nnguyen/project-dbms.git>
   cd project-dbms
   ```

2. **Start the containers**
   ```bash
   docker-compose up -d
   ```

3. **Wait for initialization** (~30 seconds)
   ```bash
   docker-compose logs -f mysql-master
   ```

4. **Verify replication status**
   ```bash
   # Check master status
   docker-compose exec mysql-master mysql -uroot -prootpassword -e "SHOW MASTER STATUS\G"
   
   # Check slave1 status
   docker-compose exec mysql-slave1 mysql -uroot -prootpassword -e "SHOW SLAVE STATUS\G"
   
   # Check slave2 status
   docker-compose exec mysql-slave2 mysql -uroot -prootpassword -e "SHOW SLAVE STATUS\G"
   ```

5. **Connect to databases**
   ```bash
   # Master (for write operations)
   mysql -h127.0.0.1 -P3309 -uroot -prootpassword
   
   # Slave 1 (for read operations)
   mysql -h127.0.0.1 -P3307 -uroot -prootpassword
   
   # Slave 2 (for read operations)
   mysql -h127.0.0.1 -P3308 -uroot -prootpassword
   ```


## 🔧 Configuration Details

### Master Configuration (`master.cnf`)
```ini
server-id=1                        # Unique server identifier
log-bin=mysql-bin                  # Enable binary logging
binlog-format=ROW                  # Row-based replication (safer)
enforce-gtid-consistency=ON        # GTID enforcement
gtid-mode=ON                       # Enable GTID
```

### Slave Configuration (`slave1.cnf` / `slave2.cnf`)
```ini
server-id=2 (or 3)                 # Unique per slave
log-bin=mysql-bin                  # Enable binary logging for cascading
relay-log=relay-bin                # Relay log configuration
enforce-gtid-consistency=ON        # GTID enforcement
gtid-mode=ON                       # Enable GTID
read-only=1                        # Read-only mode
```

## 🌐 Network & Port Mapping

| Service | Container Port | Host Port | Access |
|---------|----------------|-----------|--------|
| Master | 3306 | 3309 | Read/Write |
| Slave 1 | 3306 | 3307 | Read-Only |
| Slave 2 | 3306 | 3308 | Read-Only |

## 📝 Common Commands

### View Logs
```bash
docker-compose logs -f mysql-master
docker-compose logs -f mysql-slave1
docker-compose logs -f mysql-slave2
```

### Access MySQL
```bash
docker-compose exec mysql-master mysql -uroot -prootpassword
```

### Test Replication
```bash
# On Master: Insert test data
docker-compose exec mysql-master mysql -uroot -prootpassword -e "INSERT INTO mydb.students VALUES ('SV099', 'Test Student', '2024-01-01', 'L01');"

# On Slave: Verify data appears
docker-compose exec mysql-slave1 mysql -uroot -prootpassword -e "SELECT * FROM mydb.students WHERE student_id='SV099';"
```

### Stop All Containers
```bash
docker-compose down
```

### Remove All Data (Reset)
```bash
docker-compose down -v
```

### Default Credentials
- **Username**: `root`
- **Password**: `rootpassword`
- **Change in production** - update `docker-compose.yml` before deploying to production

### Data Persistence
- Data is currently **not persisted** across container restarts
- For production use, add Docker volumes to `docker-compose.yml`:
  ```yaml
  volumes:
    - mysql-master-data:/var/lib/mysql
    - mysql-slave1-data:/var/lib/mysql
    - mysql-slave2-data:/var/lib/mysql
  ```

### GTID Replication Benefits
- Automatic failover capability
- Consistent state across replicas
- Simplified failover and recovery procedures
- Multi-source replication support

## 🐛 Troubleshooting

### Replication Lag
```bash
# Check slave status - look for Seconds_Behind_Master
docker-compose exec mysql-slave1 mysql -uroot -prootpassword -e "SHOW SLAVE STATUS\G" | grep Seconds_Behind_Master
```

### Slave Not Connecting
```bash
# Check if slave is running
docker-compose exec mysql-slave1 mysql -uroot -prootpassword -e "SHOW SLAVE STATUS\G"

# Restart slave connection
docker-compose exec mysql-slave1 mysql -uroot -prootpassword -e "STOP SLAVE; START SLAVE;"
```

### Check Database Exists
```bash
docker-compose exec mysql-master mysql -uroot -prootpassword -e "SHOW DATABASES;"
```

## 📚 References

- [MySQL Replication Documentation](https://dev.mysql.com/doc/refman/8.0/en/replication.html)
- [GTID Replication](https://dev.mysql.com/doc/refman/8.0/en/replication-gtids.html)
- [Docker Compose Reference](https://docs.docker.com/compose/)

