FROM armoniax/amnod:0.4.1

ARG NETWORK
ARG P2P_PORT=9876
ENV P2P_PORT=${P2P_PORT}
ARG RPC_PORT=8888
ENV RPC_PORT=${RPC_PORT}
ARG STATE_PORT=9555
ENV STATE_PORT=${RPC_PORT}
ENV PARAMS=''

WORKDIR /opt/data/amax

CMD ["./bin/start.sh", "$PARAMS"]

VOLUME [ "/opt/data/amax/conf", "/opt/data/amax/data", "/opt/data/amax/logs"]
EXPOSE ${P2P_PORT}
EXPOSE ${RPC_PORT}
EXPOSE ${STATE_PORT}
