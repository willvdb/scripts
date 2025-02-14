
buildApi() {

  cd ~/code/old-api

  load ~/scripts/env_prod.sh

  docker build \
  -t toolkit-api \
  --build-arg DB_CONNECTION_STRING=$DB_CONNECTION_STRING \
  --build-arg ASB_CONNECTION_STRING=$ASB_CONNECTION_STRING \
  --build-arg COMPANY_QUEUE=$COMPANY_QUEUE \
  --build-arg OVERRIDE_QUEUE=$OVERRIDE_QUEUE \
  --build-arg DATA_LAKE_USERNAME=$DATA_LAKE_USERNAME \
  --build-arg DATA_LAKE_PASSWORD=$DATA_LAKE_PASSWORD \
  --build-arg DATA_LAKE_SERVER=$DATA_LAKE_SERVER \
  --build-arg OKTA_CLIENTID=$OKTA_CLIENTID \
  --build-arg OKTA_ISSUER=$OKTA_ISSUER \
  --build-arg OKTA_AUDIENCE=$OKTA_AUDIENCE \
  --build-arg DATA_LAKE_USERNAME=$DATA_LAKE_USERNAME \
  --build-arg DATA_LAKE_PASSWORD=$DATA_LAKE_PASSWORD \
  --build-arg DATA_LAKE_SERVER=$DATA_LAKE_SERVER .
}

#you'll need to be signed into azure via the cli for this to work
deployApi() {
  docker tag toolkit-api:latest grandeurpeakcontainerregistry.azurecr.io/toolkit-api:latest

  docker push grandeurpeakcontainerregistry.azurecr.io/toolkit-api:latest
}


buildAndDeployApi() {
  buildApi
  deployApi
}

buildDevApi() {

  load ~/scripts/env_dev.sh

  cd ~/code/old-api

  docker build \
  -t toolkit-api \
  --build-arg DB_CONNECTION_STRING=$DB_CONNECTION_STRING \
  --build-arg ASB_CONNECTION_STRING=$ASB_CONNECTION_STRING \
  --build-arg COMPANY_QUEUE=$COMPANY_QUEUE \
  --build-arg OVERRIDE_QUEUE=$OVERRIDE_QUEUE \
  --build-arg DATA_LAKE_USERNAME=$DATA_LAKE_USERNAME \
  --build-arg DATA_LAKE_PASSWORD=$DATA_LAKE_PASSWORD \
  --build-arg DATA_LAKE_SERVER=$DATA_LAKE_SERVER \
  --build-arg OKTA_CLIENTID=$OKTA_CLIENTID \
  --build-arg OKTA_ISSUER=$OKTA_ISSUER \
  --build-arg OKTA_AUDIENCE=$OKTA_AUDIENCE \
  --build-arg DATA_LAKE_USERNAME=$DATA_LAKE_USERNAME \
  --build-arg DATA_LAKE_PASSWORD=$DATA_LAKE_PASSWORD \
  --build-arg DATA_LAKE_SERVER=$DATA_LAKE_SERVER .
}

#you'll need to be signed into azure via the cli for this to work
deployDevApi() {
  docker tag toolkit-api:latest grandeurpeakcontainerregistry.azurecr.io/toolkit-api:dev

  docker push grandeurpeakcontainerregistry.azurecr.io/toolkit-api:dev
}


buildAndDeployDevApi() {
  buildDevApi
  deployDevApi
}