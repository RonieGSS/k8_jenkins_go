FROM golang:1.9.2-alpine
LABEL maintainer="Ronie Vincent Horca<ronievincent.gss@gmail.com>"

# Install dependencies
RUN apk add --update tzdata \
    --no-cache ca-certificates git wget \
    && update-ca-certificates

# Install revel and glide
RUN go get github.com/revel/revel \
    && go get github.com/revel/cmd/revel \
    && go get github.com/golang/dep/cmd/dep \
    && wget -O glide.zip https://github.com/Masterminds/glide/releases/download/v0.13.1/glide-v0.13.1-linux-386.zip \
    && unzip glide.zip \
    && rm glide.zip \
    && mv linux-386/glide $GOPATH/bin \
    && rm -rf linux-386

ENV PATH $PATH:/go/bin

# Create alias
WORKDIR "/go/src/github.com/qmu-jp/frnc-backend"
WORKDIR "/go/src/github.com/qmu-jp/frnc-backend-src"

EXPOSE 50190
