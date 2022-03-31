IMG=$1
[ -z "$IMG" ] && IMG=localhost/build-amc-deb:0.1

podman run -it --name amc-testnet $IMG bash