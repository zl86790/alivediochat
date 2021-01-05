FROM golang:alpine as golang   

RUN mkdir -p /root/vedioChat
RUN mkdir -p /root/vedioChat/output
COPY ./ /root/vedioChat

WORKDIR /root/vedioChat/output
RUN go build /root/vedioChat/main.go


FROM alpine as alpine

RUN mkdir -p /root/vedioChat
COPY --from=golang --chown=root:root /root/vedioChat/output /root/vedioChat
COPY --from=golang --chown=root:root /root/vedioChat/static /root/vedioChat/static

WORKDIR /root/vedioChat
CMD /root/vedioChat/main

