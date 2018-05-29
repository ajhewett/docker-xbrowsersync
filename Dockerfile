FROM node:10-slim

ENV XBROWSERSYNC_VERSION v1.1.2

# the tar.gz archive has paths prefixed with API-1.1.2 so strip this when extracting
RUN wget --quiet https://github.com/xBrowserSync/API/archive/${XBROWSERSYNC_VERSION}.tar.gz \
    && mkdir /xbrowsersync \
    && tar -C /xbrowsersync --strip-components=1 -xzf ${XBROWSERSYNC_VERSION}.tar.gz \
    && rm ${XBROWSERSYNC_VERSION}.tar.gz

WORKDIR /xbrowsersync

ENV XBROWSERSYNC_MONGODB_SERVER "nas.localdomain"
ENV XBROWSERSYNC_DB_USER "xbrowsersyncdb"
ENV XBROWSERSYNC_DB_PWD "xbrowsersyncdb"

COPY config/settings.json /xbrowsersync/config
RUN sed -i "s/{{XBROWSERSYNC_MONGODB_SERVER}}/${XBROWSERSYNC_MONGODB_SERVER}/g" /xbrowsersync/config/settings.json \
    && npm install --unsafe-perm

CMD [ "node", "dist/api.js" ]

