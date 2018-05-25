#!/bin/bash
docker build -t ookok/danetheory-api .
docker push ookok/danetheory-api

ssh deploy@$DEPLOY_SERVER << EOF
docker pull ookok/danetheory-api
docker stop danetheory-api || true
docker rm danetheory-api || true
docker rmi ookok/danetheory-api:current || true
docker tag ookok/danetheory-api:latest ookok/danetheory-api:current
docker run -d --restart always --name danetheory-api -p 3000:3000 ookok/danetheory-api:current
EOF
