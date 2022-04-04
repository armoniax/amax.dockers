FROM armoniax/amnod:0.4.1

ARG NETWORK
ARG P2P_PORT=9876
ENV P2P_PORT=${P2P_PORT}
ARG RPC_PORT=8888
ENV RPC_PORT=${RPC_PORT}
ENV PARAMS=''

WORKDIR /opt/data/amax
COPY ./bin /opt/data/amax/
COPY ./conf/${NETWORK}.config.ini /opt/data/amax/conf/
COPY ./conf/genesis.json /opt/data/amax/conf/

CMD ["./start.sh", "$PARAMS"]

VOLUME [ "/opt/data/amax/conf", "/opt/data/amax/data", "/opt/data/amax/logs"]
EXPOSE ${P2P_PORT}
EXPOSE ${RPC_PORT}
