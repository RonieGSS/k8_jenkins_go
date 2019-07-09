FROM hxhroniegss/revel
LABEL maintainer="Ronie Vincent Horca<ronievincent.gss@gmail.com>"

# Install Python, gulp
# https://github.com/sass/node-sass/issues/1176
RUN apk --no-cache --update add python alpine-sdk nodejs nodejs-npm mysql-client && \
    npm install -g gulp gulp-changed gulp-watch && \
    npm cache clean && \
    rm -rf /var/cache/* /tmp/*

RUN go get -u github.com/naoina/migu/cmd/migu
