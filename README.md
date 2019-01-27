# CI Stack based on Docker

[Work in progress]

## Requirements

- Publically accessible docker machine (if you want to expose this to github)
  - I use docker-machine on gcp
  - Load balancer with reserved IP
  - Cloud dns pointing to LB
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

## URLS and Passwords

| **Service** | **Address**              | **Credentials** |
| ----------- | ------------------------ | --------------- |
| Jenkins     | https://<domain>/jenkins | admin:admin123  |
| Nexus       | https://<domain>/nexus   | admin:admin123  |
| Sonar       | https://<domain>/sonar   | admin:admin123  |

## Troubleshooting

### Jenkins/Sonar/Nexus is not reachable?

https://<domain>/jenkins times out? Check the firwall. If your docker containers are running, then your firewall is the biggest suspect.

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
