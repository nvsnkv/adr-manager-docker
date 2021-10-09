# Self-Hosted ADR Manager Instance
Set of dockerfiles and docker compose to run your own, self-hosted version of [ADR-Manager](https://github.com/adr/adr-manager)

## Should I Use It?
Frankly speaking, not sure it's a good idea. You'll need to setup your own OAuth app on Github to make it work, wich is definitely harder then just opening [ADR-Manager](https://adr.github.io/adr-manager/#/) instance that's hosted by maintainers of this project.

I did not find any solid reason not to use publicly hosted instance. Self-hosted instance just transfers the responsibility to secure it back to you, so you won't be able to blame anyone except you if someone will steal your credentials and wipe out your repos.

## Quick Start
1. run `git submodule update --init` to get dependencies
2. set [required](#required-environment-variables) environment variables
3. run `docker-compose up`
4. follow [Pizzly readme](https://github.com/Bearer/Pizzly/blob/master/docs/getting-started.md#connect-yourself-to-github) to make one time setup - register OAuth app on Github. Host and port for callback URL are controlled by optional _PZ_EXT_HOST_ and _PZ_EXY_PORT_ variables. Please note that following scopes are required: `user`, `repo`. Without them ADR-Manager won't be able to commit and push the changes to repos.
5. follow [readme](https://github.com/adr/adr-manager#readme) and have fun!

### Required Environment Variables
`docker-compose.yaml` uses several required environment variables to run the app (mostly passwords):
* PZ_DB_PWD - the password that Pizzly will use to connect to database
* PZ_PWD - the password for Pizzly dashboard (default user - pizzly)

In addition to passwords, Pizzly requires following keys to be defined to secure the instance:
* PZ_SECRET - Pizzly SECRET_KEY
* PZ_PUBLISH - Pizzly PUBLISHABLE_KEY 
The details about these keys can be found [here](https://github.com/Bearer/Pizzly/blob/master/docs/securing-your-instance.md)

### Optional Environment Variables
Following environment variables have default values in compose file, but nothing should stop you from tweaking it!
First group of optional variables is the names of the images:
* PZ_IMAGE=pizzly - the name of the pizzly image. There is no official build from maintainers, but you can use someone's image from docker hub or build it and publish into your own repo.
* PZ_DB_MIGRATIONS_IMAGE=pizzly-db-migrations - the name of the image that runs database migrations for Pizzly. 
* ADRM_IMAGE=adr_manager - the name of the ard-manager image. Similar to PZ_IMAGE, it was introduced since maintainers of ADM did not publish official image to docker hub 

Next group defines external connections for the services:
* ADRM_EXT_PORT=8280 - external port for ADR Manager UI
* PZ_EXT_HOST=localhost - externally available hostname for Pizzly container. ADR Manager should be able to redirect user to Pizzly API.
* PZ_EXT_PORT=8080 - external port for Pizzly API

Last, but not least - you can define a differernt user name to access Pizzly Dashboard
* PZ_USER=pizzly - username for Pizzly Dashboard
