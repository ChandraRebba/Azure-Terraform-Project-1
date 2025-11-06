# Azure VM Provisioning with Terraform

## 📋 Project Overview

This project provisions Azure Virtual Machines (Windows Server 2019 and Ubuntu 20.04) on a Virtual Network with proper networking configuration, equivalent to AWS EC2 provisioning on VPC.

### What We're Achieving

- ✅ Create Azure Virtual Network (VNet) and Subnet
- ✅ Configure Network Security Groups (NSG) with SSH and RDP rules
- ✅ Provision Ubuntu 20.04 VM with SSH key authentication
- ✅ Provision Windows Server 2019 VM with password authentication
- ✅ Assign Public IPs for external access
- ✅ Connect to Ubuntu via SSH
- ✅ Connect to Windows via RDP

## 🏗️ Architecture

```mermaid
graph TB
    User["👤 User/Admin"]
    
    subgraph Azure["☁️ Azure Cloud - East US"]
        subgraph RG["Resource Group: rg-vm-demo"]
            
            subgraph Network["Virtual Network: 10.0.0.0/16"]
                subgraph Sub["Subnet: 10.0.1.0/24"]
                    Ubuntu["Ubuntu 20.04 VM<br/>10.0.1.4"]
                    Windows["Windows Server 2019<br/>10.0.1.5"]
                end
            end
            
            NSG["Network Security Group<br/>SSH: 22 | RDP: 3389"]
            PIP1["Public IP: x.x.x.x"]
            PIP2["Public IP: y.y.y.y"]
            
        end
    end
    
    User -->|SSH:22| PIP1
    User -->|RDP:3389| PIP2
    PIP1 --> Ubuntu
    PIP2 --> Windows
    NSG -.-> Ubuntu
    NSG -.-> Windows
    
    classDef userStyle fill:#4caf50,stroke:#2e7d32,stroke-width:3px,color:#fff
    classDef ubuntuStyle fill:#ff9800,stroke:#e65100,stroke-width:2px,color:#fff
    classDef windowsStyle fill:#2196f3,stroke:#0d47a1,stroke-width:2px,color:#fff
    classDef nsgStyle fill:#f44336,stroke:#b71c1c,stroke-width:2px,color:#fff
    classDef pipStyle fill:#9c27b0,stroke:#4a148c,stroke-width:2px,color:#fff
    classDef networkStyle fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef subnetStyle fill:#bbdefb,stroke:#1565c0,stroke-width:2px
    
    class User userStyle
    class Ubuntu ubuntuStyle
    class Windows windowsStyle
    class NSG nsgStyle
    class PIP1,PIP2 pipStyle
    class Network networkStyle
    class Sub subnetStyle
```
