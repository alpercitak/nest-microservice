FROM node:18-alpine AS base

RUN npm i -g pnpm

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

FROM base AS deploy

ARG APPNAME
RUN echo deploy: ${APPNAME}

WORKDIR /app
COPY --from=build /app/dist/ ./dist/
COPY --from=build /app/node_modules ./node_modules
CMD [ "node", "dist/main.js" ]

# FROM base AS build-api-core

# WORKDIR /app
# COPY ./apps/api-core .
# COPY --from=dependencies /app/package.json /app/pnpm-lock.yaml /app/tsconfig.json /app/tsconfig.build.json ./ 
# COPY --from=dependencies /app/node_modules ./node_modules
# RUN pnpm build
# RUN pnpm prune --prod

# FROM base AS deploy-api-core

# WORKDIR /app
# COPY --from=build-api-core /app/dist/ ./dist/
# COPY --from=build-api-core /app/node_modules ./node_modules
# CMD [ "node", "dist/main.js" ]

# FROM base AS build-svc-keys

# WORKDIR /app
# COPY ./apps/svc-keys .
# COPY --from=dependencies /app/package.json /app/pnpm-lock.yaml /app/tsconfig.json /app/tsconfig.build.json ./ 
# COPY --from=dependencies /app/node_modules ./node_modules
# RUN pnpm build
# RUN pnpm prune --prod

# FROM base AS deploy-svc-keys

# WORKDIR /app
# COPY --from=build-svc-keys /app/dist/ ./dist/
# COPY --from=build-svc-keys /app/node_modules ./node_modules
# CMD [ "node", "dist/main.js" ]

# FROM base AS build-svc-values

# WORKDIR /app
# COPY ./apps/svc-values .
# COPY --from=dependencies /app/package.json /app/pnpm-lock.yaml /app/tsconfig.json /app/tsconfig.build.json ./ 
# COPY --from=dependencies /app/node_modules ./node_modules
# RUN pnpm build
# RUN pnpm prune --prod

# FROM base AS deploy-svc-values

# WORKDIR /app
# COPY --from=build-svc-values /app/dist/ ./dist/
# COPY --from=build-svc-values /app/node_modules ./node_modules
# CMD [ "node", "dist/main.js" ]