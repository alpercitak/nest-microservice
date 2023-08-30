FROM node:18-alpine AS base

WORKDIR /app
RUN npm i -g pnpm
COPY pnpm-lock.yaml ./
RUN pnpm fetch

COPY . .

FROM base AS build

WORKDIR /app

ARG APP_NAME
RUN echo build: ${APP_NAME}

RUN pnpm --filter="${APP_NAME}" i -r
RUN pnpm --filter="${APP_NAME}" run build

RUN rm -rf ./node_modules
RUN rm -rf ./apps/${APP_NAME}/node_modules
RUN pnpm --filter="${APP_NAME}" i -r --prod

FROM node:18-alpine AS deploy

WORKDIR /app

ARG APP_NAME
RUN echo deploy: ${APP_NAME}

COPY --from=build /app/node_modules/ ./node_modules
COPY --from=build /app/apps/${APP_NAME}/node_modules ./apps/${APP_NAME}/node_modules
COPY --from=build /app/apps/${APP_NAME}/dist ./apps/${APP_NAME}/dist

ENV APP_ENTRY="apps/${APP_NAME}/dist/main.js"
CMD "node" ${APP_ENTRY}