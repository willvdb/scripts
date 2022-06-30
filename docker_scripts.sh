
buildApi() {
  export DB_CONNECTION_STRING="" #put var in here

  export ASB_CONNECTION_STRING="" #put var in here
  export COMPANY_QUEUE="" #put var in here

  export OKTA_CLIENTID="" #put var in here
  export OKTA_ISSUER="" #put var in here
  export OKTA_AUDIENCE="" #put var in here

  export NPM_TOKEN="" #put var in here

  cd ~/code/toolkit-api

  docker build \
  -t toolkit-api \
  --build-arg DB_CONNECTION_STRING=$DB_CONNECTION_STRING \
  --build-arg ASB_CONNECTION_STRING=$ASB_CONNECTION_STRING \
  --build-arg COMPANY_QUEUE=$COMPANY_QUEUE \
  --build-arg OKTA_CLIENTID=$OKTA_CLIENTID \
  --build-arg OKTA_ISSUER=$OKTA_ISSUER \
  --build-arg OKTA_AUDIENCE=$OKTA_AUDIENCE .
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