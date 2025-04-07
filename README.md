# 5G-NR-U
This repository provides a step-by-step guide for implementing unlicensed spectrum bands in a 5G network.
## 🔍 About This Repository

This repository contains the **scripts**, **configurations**, and **experimental results** associated with the following article:

**Article Title**: *Full title of your article* 
**Submitted to**: *Conference / Journal name* 
**Submission Date**: dd/mm/yy

---

## 🔓 Temporary Access

This repository is made **temporarily public** to allow reviewers to access the source code, in accordance with transparency and reproducibility requirements.

⚠️ **Do not share this link** outside of the review process. 
🔒 The repository will be made **private again** after the review period.

📧 For any questions, contact the author: diawara.mahamadou@ugb.edu.sn

---

## 💻 Environment Information

### Hardware Specifications

> This setup was used for all experiments conducted in the paper.

- **Host**: HP Envy 
- **CPU**: Intel® 13th Gen – 10 cores – 1.70 GHz 
- **RAM**: 16 GB 
- **Storage**: 200 GB SSD 
- **Operating System**: Ubuntu Desktop 22.04 LTS 
- **USRP Driver**: UHD `v4.7.0.0`

---

### 🧠 Real-Time Kernel Setup (Low Latency)

> A low-latency kernel is required to ensure optimal real-time performance with USRP devices.

```bash
sudo apt-get install linux-image-lowlatency linux-headers-lowlatency
```

> Then reboot your machine and check that the correct kernel is loaded:

```bash
uname -a
```

---

## ⚙️ Environment Setup

### Step 1: Clone the Required Repositories

> Start by cloning OpenAirInterface and this repository.

#### 📥 Clone OpenAirInterface:

```bash
git clone https://gitlab.eurecom.fr/oai/openairinterface5g.git
```

#### 📥 Clone This Repository:

```bash
git clone https://github.com/ladjimahamadou/5G-NR-U.git
```

---

### Step 2: Extend OAI to Support NR-U

> You can either modify the files manually or replace them with our pre-modified versions.

#### ✅ Option 1: Manual Modifications

> Modify the following files as detailed in the article's section *“Extending OAI for NR-U support”*:

```text
OAI/NR-U/gnb/common/utils/nr/nr_common.c  
OAI/NR-U/gnb/openair1/PHY/INIT/nr_parms.c  
OAI/NR-U/gnb/openair2/GNB_APP/gnb_config.c  
```

#### ✅ Option 2: Replace Files with Pre-Modified Versions

> Replace the files above with those located in the [Extended_code](Extended_code) folder of this repository.

This adds **NR-U band support** in OpenAirInterface.

---

## 🧱 Compilation

### 🛠️ Option 1: Bare-Metal Compilation

```bash
cd ~/your_oai_directory/cmake_targets
./build_oai -I                        # Install OAI dependencies
./build_oai -w USRP --ninja --gNB -C  # Compile gNB with USRP support
```

> 🔁 Ensure the compilation completes successfully; repeat if needed.

---

### 🐳 Option 2: Docker-Based Setup (Recommended)

> This script installs Docker and sets up all necessary OAI resources.

```bash
chmod +x install_docker.sh
./install_docker.sh
```

📦 Then, copy the `docker` folder from `5G-NR-U` into the `docker` folder inside your `your_oai_directory`.

📘 Follow the Docker setup instructions in:

```bash
cd /your_oai_directory/home/docker
```

Or refer directly to:

- [docker/README.md](docker/README.md)

---

## 🚀 Running the Environment

> All following steps are executed from the `5G-NR-U` directory.

```bash
cd 5G-NR-U
```

---

### Step 1: Start the 5G Core (5GC)

```bash
cd core
docker compose up -d
```

> This launches all 5GC containers (AMF, SMF, UPF, etc.)

---

### Step 2: Run gNodeB and UE Containers

> Make sure the USRP B210 is **physically connected** (via USB 3 or better).

#### 🛰️ Run the gNB:

```bash
cd ../gnb

# For NR-U Band n46
docker compose -f n46.yml up

# For Band n47
docker compose -f n47.yml up

# For Band n96
docker compose -f n96.yml up

# For Band n78 (non-NR-U, for comparison)
docker compose -f n78.yml up
```

#### 📱 Run the UE:

```bash
cd ../ue

# For Band n46
docker compose -f n46.yml up

# For Band n47
docker compose -f n47.yml up

# For Band n96
docker compose -f n96.yml up

# For Band n78
docker compose -f n78.yml up
```

🛑 To stop containers: use `Ctrl + C`

---

### 🛑 Stop the Core Network Services

> Always shut down core network services cleanly using the following:

```bash
cd ../core
docker compose down
```

---

## 🧰 Configuration & Documentation

- 🔧 [Performance Mode Guide](Performance/README.md)

### 📁 Configuration Directories

- [gNB Configuration](gnb) 
- [UE Configuration](ue) 
- [5G Core Configuration](core) 
- [Custom Docker Images](Docker-images)
- [Result](plot)
---

## 🐞 Troubleshooting Guide

### 🚫 Docker Container Failures

- **Problem**: Containers won’t start 
- **Solution**: Check dependencies and logs:

```bash
docker logs [container_id]
```

---

### ❌ USRP Not Detected

- **Solution**: Confirm USB 3.0 connection and verify detection:

```bash
uhd_find_devices
```

---

### 📡 No Communication Between gNB and 5GC

- **Possible Causes**: Incorrect IP addresses or firewall/NAT issues 
- **Solution**: Check config files and enable IP forwarding if needed.

---

### 📶 Poor or No Signal

- **Solution**: Recheck antenna connections and tune transmission power/gain in config files.

---

### 🐢 Performance Bottlenecks

- **Problem**: Low throughput or delay 
- **Solution**: Monitor CPU/RAM usage and adjust:

```text
nb_tx, nb_rx, max_rxgain
```

---

Feel free to reach out for any bugs or undocumented behavior.
