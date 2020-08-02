FROM alpine

WORKDIR /resources

RUN apk update && apk add curl
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
RUN mv cf /usr/local/bin
RUN cf install-plugin -f -r CF-Community "html5-plugin"

ENTRYPOINT [ "/bin/sh" ]
