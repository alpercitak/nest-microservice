# nest-microservice

![Build](https://github.com/alpercitak/nest-microservice/actions/workflows/build.yaml/badge.svg) 
![License](https://img.shields.io/github/license/alpercitak/nest-microservice)

Nest.js microservice boilerplate with a monorepo setup using Turborepo and pnpm workspaces. Each service runs in its own container via Docker Compose.

## Stack

- **Framework**: NestJS
- **Monorepo**: Turborepo + pnpm workspaces
- **Containerization**: Docker + Docker Compose
- **Language**: TypeScript
- **CI**: GitHub Actions

## Getting started

```bash
pnpm install
pnpm dev        # watch mode
pnpm build      # production build
pnpm test       # unit tests
pnpm test:watch # watch mode
```

## Structure

```
apps/           # microservices
packages/lib/   # shared library
```

## License

MIT
