# CI Stack based on Docker

[Work in progress]

## Requirements

- Publically accessible docker machine (if you want to expose this to github)
  - I use docker-machine on gcp (see my setup [here](#my-gcp-docker-machine))
  - Alternatively, you can use [Serveo](https://serveo.net/) to set up SSH tunnels for exposing your CI/CD externally.
- Tools:
  - docker-machine
  - docker-compose
  - docker
- Patience - Very important

## What to do?

- Clone this repo
- Generate let's encrypt certs for your domain and copy to `web/ssl/server.crt` and `web/ssl/server.key`
  - Don't use self signed certs. Its 2019. Its more pain then you know it to "skip ssl checks" everywhere.
  - Happy to get a better way to generate certs at runtime. Send a PR
- Replace `ci.gcp.yogendra.me` everywhere with your domain.
- `docker-compose up -d`
- Open `https://your.own.domain/jenkins/blueocean` and login. (credentials below)

## URLS and Passwords

| **Service** | **Address**                        | **Credentials** |
| ----------- | ---------------------------------- | --------------- |
| Jenkins     | https://your.own.domain/jenkins    | admin:admin123  |
| Nexus       | https://your.own.domain/nexus      | admin:admin123  |
| Sonar       | https://your.own.domain/sonarqube  | admin:admin     |
| Minio       |                                    |                 |
| Concourse   | https://concourse.your.own.domain/ |                 |
| Vault       |                                    |                 |

## My GCP Docker Machine

I am using a fixed IP based VM and a cloud dns entry pointing to it. Here is what my docker-create commmand look like:

```
export GOOGLE_ADDRESS=aaa.bbb.ccc.ddd
export GOOGLE_DISK_SIZE=40
export GOOGLE_MACHINE_IMAGE=ubuntu-os-cloud/global/images/ubuntu-minimal-1604-xenial-v20190108a
export GOOGLE_MACHINE_TYPE=n1-highmem-2
export GOOGLE_PROJECT=my-project-name
export GOOGLE_TAGS=http-server,https-server
export GOOGLE_ZONE=us-central1-f

docker-machine create ci-host
```

This creates a VM with 40 GB Disk and 13 GB RAM. Also, tags help in opening firewall automatically. Replace aaa.bbb.ccc.ddd with your own IP.

You can reserve an IP [here](https://console.cloud.google.com/networking/addresses/list). Just click on "Reserver Static Address" and follow the instrucations.

After reserving IP, create a Cloud DNS Hosted Zone (if you don't have one) [here](https://console.cloud.google.com/net-services/dns/zones), and create an A record in the hosted zone to point to IP you reserved earlier.

## Regular operations

### Add secret to vault for concourse

```
docker-compose exec concourse-config bash -l -c 'source /vault/server/init_vars && vault write secret/concourse/main/main/myvalue value=foo'
```
### Add files to minio



## Troubleshooting

### Jenkins/Sonar/Nexus is not reachable?

https://your.own.domain/jenkins times out? Check the firwall. If your docker containers are running, then your firewall is the biggest suspect.

## Pending / Wishlist

- Renew SSL Certs at runtime
- Configure single signon
- Add Git to this stack
- Add better default config for Jenkins
  - Add Java tools
  - Add NodeJS tools
  - Add Maven tools
  - Add Gradle tools
  - Add CF tools
  - Add Kubectl tools
- Configure slave for Jenkins (may be)
- Better RBAC overall

## Credits

A lot of this has come in bits an pieces from other people's work

- [marcelbirkner/docker-ci-tool-stack](https://github.com/marcelbirkner/docker-ci-tool-stack)
- [Accenture/adop-jenkins](https://github.com/Accenture/adop-jenkins)
