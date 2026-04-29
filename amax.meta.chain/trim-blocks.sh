IMG=ghcr.io/armoniax/amnod:1.0.4
H=127602651 ## modify this number to what you like

echo "### Triming blocks now"
docker run --rm -it \
  -v /data/amax_mainnet_bps/data:/data/amax_mainnet_bps/data $IMG \
  amax-blocklog --blocks-dir /data/amax_mainnet_bps/data/blocks --trim-blocklog --first $H

echo "### Testing trim effectiveness"
docker run --rm -it \
  -v /data/amax_mainnet_bps/data:/data/amax_mainnet_bps/data $IMG \
  amax-blocklog --blocks-dir /data/amax_mainnet_bps/data/blocks --smoke-test
