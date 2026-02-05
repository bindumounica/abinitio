FROM golang:1.23.4-alpine AS builder

WORKDIR /etl
COPY . .
EXPOSE 8080

CMD ["bash", "runtime/master_pipeline.sh"]
