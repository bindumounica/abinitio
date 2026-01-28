FROM registry.access.redhat.com/ubi9/ubi-minimal

WORKDIR /opt/etl

COPY build/dist/etl-component-*.tar /tmp/etl.tar

RUN microdnf install -y tar && \
    tar -xf /tmp/etl.tar -C /opt/etl && \
    rm -f /tmp/etl.tar

RUN useradd -u 1001 etluser
USER 1001

CMD ["ls", "-R", "/opt/etl"]
