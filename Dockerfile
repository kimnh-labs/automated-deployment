# Build stage:
FROM node:10-alpine as build

WORKDIR /build

ENV PORT=3000
ENV HOST=0.0.0.0
ENV NODE_ENV=production

COPY . .

RUN yarn install --production=false --frozen-lockfile
RUN yarn build




# Production build stage:
FROM node:10-alpine

WORKDIR /srv

ENV PORT=3000
ENV HOST=0.0.0.0
ENV NODE_ENV=production

COPY package.json yarn.lock ./
COPY --from=build /build/.nuxt ./.nuxt

RUN yarn install --production --frozen-lockfile

EXPOSE 3000

CMD [ "yarn", "start" ]
