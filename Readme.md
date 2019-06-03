# DIY SOAR - Cb Connect 2019

Intro project to learn about using:
- Ruby
- Sidekiq
- Redis
- Docker

To solve interesting security problems with a DIY-SOAR framework.

## Getting started

If you do not have Docker Desktop installed, [install it now](https://www.docker.com/products/docker-desktop).

```bash
git clone https://github.com/redcanaryco/cbconnect-2019.git
cd cbconnect-2019
docker-compose build
docker-compose up
```

## Structure

- Actions we take inside a playbook go in `app/actions`
- Playbooks that run in response to an alert go in `app/playbooks`
- The entrypoint is `app/main.rb`
