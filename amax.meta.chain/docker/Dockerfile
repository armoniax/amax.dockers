FROM armoniax/amnod:0.4.1

ARG P2P_PORT=9876
ENV P2P_PORT=${P2P_PORT}
ARG RPC_PORT=8888
ENV RPC_PORT=${RPC_PORT}
ENV PARAMS=''

RUN echo "network:" ${NETWORK}
COPY ./docker/bin /opt/amax/
COPY ./docker/conf/${NETWORK}.config.ini /opt/amax/conf/
COPY ./docker/conf/genesis.json /opt/amax/conf/

CMD ["./bin/start.sh", "$PARAMS"]

VOLUME ["/opt/amax/data", "/opt/amax/logs"]
EXPOSE ${P2P_PORT}
EXPOSE ${RPC_PORT}
