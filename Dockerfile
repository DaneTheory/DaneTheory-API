FROM node:8-alpine

EXPOSE 4000

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

RUN mkdir /app
WORKDIR /app
RUN cp .env.example .env
ADD package.json yarn.lock /app/
RUN yarn --pure-lockfile
ADD . /app

CMD ["yarn", "docker:start"]
