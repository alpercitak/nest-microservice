FROM node:18-alpine AS base

RUN npm i -g pnpm
RUN pnpm fetch

FROM base AS dependencies

WORKDIR /app
COPY package.json pnpm-lock.yaml tsconfig.json tsconfig.build.json nest-cli.json ./
RUN pnpm install

FROM base AS build

ARG APPNAME
RUN echo build: ${APPNAME}

WORKDIR /app
COPY ./apps/$APPNAME .
COPY --from=dependencies /app/package.json /app/pnpm-lock.yaml /app/tsconfig.json /app/tsconfig.build.json ./ 
COPY --from=dependencies /app/node_modules ./node_modules
RUN pnpm build
RUN pnpm prune --prod

FROM node:18-alpine AS deploy

ARG APPNAME
RUN echo deploy: ${APPNAME}

WORKDIR /app
COPY --from=build /app/dist/ ./dist/
COPY --from=build /app/node_modules ./node_modules
CMD [ "node", "dist/main.js" ]