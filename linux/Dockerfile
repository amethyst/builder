FROM debian

ARG CHANNEL
ARG MDBOOK_RELEASE=0.2.1
ARG KCOV_VERSION=36
ARG KCOV_BUILD_DIR=kcov-build

RUN apt-get update && \
	apt-get install -y \
	git \
	libasound2-dev \
	libx11-xcb-dev \
	libssl-dev \
	cmake \
	libfreetype6-dev \
	libexpat1-dev \
	libxcb1-dev \
	python3 \
	build-essential \
	libsdl2-dev \
	curl \
	jq

# --- kcov --- #
# Install dependencies
RUN apt-get install -y \
	cmake \
	libcurl4-openssl-dev \
	libelf-dev \
	libdw-dev \
	gcc \
	binutils-dev \
	zlib1g-dev \
	libiberty-dev \
	pkg-config \
	python2.7 \
	wget \
	zip

RUN echo $PATH
RUN ls /usr/bin | grep -F python || true
RUN which python

# Download kcov
# -nc is okay since we are downloading a tagged version
RUN wget -nc https://github.com/SimonKagstrom/kcov/archive/v$KCOV_VERSION.zip
RUN unzip -uoq v$KCOV_VERSION.zip

# Build KCov
RUN if ! test -d "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}"; then mkdir "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}" ; fi
RUN cd "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}" && \
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release && \
	make && \
	sudo make install

COPY asound.conf /etc/asound.conf
RUN useradd -ms /bin/bash jenkins
RUN usermod -aG audio jenkins
USER jenkins

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${CHANNEL}

ENV PATH=/home/jenkins/.cargo/bin:$PATH

RUN rustup component add rustfmt

RUN cargo install mdbook --vers ${MDBOOK_RELEASE}
