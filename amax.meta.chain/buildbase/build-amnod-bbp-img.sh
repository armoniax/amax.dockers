. ~/.amnod.env
docker build --build-arg VER=$VER -t armoniax/amnod:$VER -f ./Dockerfile .
