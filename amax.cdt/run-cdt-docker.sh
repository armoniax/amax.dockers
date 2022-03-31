IMG=$1
[ -z "$IMG" ] && IMG=localhost/build-amax-deb:0.1

podman run -it --name amax-testnet $IMG bash