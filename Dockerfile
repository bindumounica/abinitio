FROM golang:1.21-alpine

WORKDIR /etl
COPY . .

CMD ["sh", "runtime/master_pipeline.sh"]
