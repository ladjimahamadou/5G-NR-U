<table style="border-collapse: collapse; border: none;">
  <tr style="border-collapse: collapse; border: none;">
    <td style="border-collapse: collapse; border: none;">
      <a href="http://www.openairinterface.org/">
         <img src="../doc/images/oai_final_logo.png" alt="" border=3 height=50 width=150>
         </img>
      </a>
    </td>
    <td style="border-collapse: collapse; border: none; vertical-align: center;">
      <b><font size = "5">OAI Docker/Podman Build and Usage Procedures</font></b>
    </td>
  </tr>
</table>

---

**Table of Contents**

[[_TOC_]]

---



# 1. Building using `docker` under Ubuntu 22.04 #

## 1.1. Pre-requisites ##

* `git` installed
* `docker-ce` installed
* Pulling `ubuntu:jammy` from DockerHub

## 1.2. Building the shared images ##

There are two shared images: one that has all dependencies, and a second that compiles all targets (eNB, gNB, [nr]UE).

```bash

cd your_oai_directory

# default branch is develop, to change use git checkout v2.1.0

docker build --target ran-base --tag ran-base:nr-u --file docker/Dockerfile.base.ubuntu22 .

# if you want use USRP, AW2S and RFSimulator radios
docker build --target ran-build --tag ran-build:nr-u --file docker/Dockerfile.build.ubuntu22 .

```

After building:

```bash
docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ran-build           nr-u              f2633a7f5102        1 minute ago        6.81GB
ran-base            nr-u              5c9c02a5b4a8        1 minute ago        2.4GB
...
```

## 1.3. Building any target image ##

For example, the eNB:

```bash
docker build --target oai-gnb --tag oai-gnb:nr-u --file docker/Dockerfile.gNB.ubuntu22 .
docker build --target oai-nr-ue --tag oai-nr-ue:nr-u --file docker/Dockerfile.nrUE.ubuntu22 .
```

After a while:

```
docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
oai-gnb             latest              25ddbd8b7187        1 minute ago        516MB
ran-build           latest              f2633a7f5102        1 hour ago          6.81GB
ran-base            latest              5c9c02a5b4a8        1 hour ago          2.4GB
```

Do not forget to remove the temporary image:

```
docker image prune --force
```

