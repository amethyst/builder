docker build --build-arg CHANNEL=stable -t luciofranco/builder-linux:stable-1 linux
docker build --build-arg CHANNEL=nightly -t luciofranco/builder-linux:nightly linux
