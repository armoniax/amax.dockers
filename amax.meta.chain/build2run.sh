svc=$1
[ -z "$svc" ] && svc=amnod-testnet

podman-compose up --build -d $svc