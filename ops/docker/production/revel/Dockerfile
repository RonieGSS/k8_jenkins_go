FROM hxhroniegss/revel
LABEL maintainer="Ronie Vincent Horca<ronievincent.gss@gmail.com>"

RUN apk add --update mysql mysql-client && rm -f /var/cache/apk/* \
	&& go get -u github.com/naoina/migu/cmd/migu

USER root:root
# Copy revel source code to /go/src/github.com/qmu-jp/frnc-backend/
COPY ./ /go/src/github.com/qmu-jp/frnc-backend/
# Changed to /go/src/github.com/qmu-jp directory
WORKDIR "/go/src/github.com/qmu-jp"
# Symlink the directory
RUN ln -s frnc-backend/src/revel /go/src/github.com/qmu-jp/frnc-backend-alias
# Changed to /go/src/github.com/qmu-jp/frnc-backend-alias directory
WORKDIR "/go/src/github.com/qmu-jp/frnc-backend-alias"
# Install dependencies
RUN glide install

WORKDIR "/go/src/github.com/qmu-jp/frnc-backend/"

# Run the revel app
ENTRYPOINT nohup revel run github.com/qmu-jp/frnc-backend-alias prod 50190