docker build --build-arg CHANNEL=stable -t amethystrs/builder-linux:stable linux
docker build --build-arg CHANNEL=nightly -t amethystrs/builder-linux:nightly linux
