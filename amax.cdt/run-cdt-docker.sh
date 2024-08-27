IMG=$1
[ -z "$IMG" ] && IMG=localhost/build-amax-deb:1.0.1

docker run -it --name amax-build $IMG bash
