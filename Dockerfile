FROM node:10-slim

ENV XBROWSERSYNC_VERSION v1.1.3

# the tar.gz archive has paths prefixed with API-1.1.2 so strip this when extracting
RUN wget --quiet https://github.com/xBrowserSync/API/archive/${XBROWSERSYNC_VERSION}.tar.gz \
    && mkdir /xbrowsersync \
    && tar -C /xbrowsersync --strip-components=1 -xzf ${XBROWSERSYNC_VERSION}.tar.gz \
    && rm ${XBROWSERSYNC_VERSION}.tar.gz

WORKDIR /xbrowsersync

RUN npm install -g envsub \
    && npm install

COPY config/settings.json.handlebars /xbrowsersync/config
COPY run.sh .

ENV XBROWSERSYNC_MONGODB_SERVER "mongo"
ENV XBROWSERSYNC_DB_USER "xbrowsersyncdb"
ENV XBROWSERSYNC_DB_PWD "xbrowsersyncdb"
ENV XBROWSERSYNC_STATUS_MESSAGE "Welcome to my xBrowserSync service!"
ENV XBROWSERSYNC_SERVER_BEHINDPROXY "false"
ENV XBROWSERSYNC_DAILYNEWSYNCSLIMIT 3
ENV XBROWSERSYNC_MAXSYNCSIZE 512000
ENV XBROWSERSYNC_ALLOWEDORIGINS ""

CMD [ "/bin/bash", "run.sh" ]

EXPOSE 8080
