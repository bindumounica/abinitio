# ===========================
# BUILD STAGE
# ===========================
FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .

RUN go build -o etl transforms/user_aggregate.go

# ===========================
# RUNTIME STAGE
# ===========================
FROM alpine:3.19

WORKDIR /etl

COPY --from=builder /app/etl .
COPY runtime runtime
COPY graphs graphs
COPY data data

# chmod FIRST (still root)
RUN chmod +x etl runtime/master_pipeline.sh

# create non-root user
RUN adduser -D etluser

# drop privileges AFTER chmod
USER etluser

ENTRYPOINT ["sh","runtime/master_pipeline.sh"]
