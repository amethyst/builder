FROM debian

ARG CHANNEL
ARG MDBOOK_RELEASE=0.3.5
ARG KCOV_VERSION=36
ARG KCOV_BUILD_DIR=kcov-build

RUN apt-get update && \
	apt-get install -y \
	binutils-dev \
	build-essential \
	cmake \
	curl \
	gcc \
	git \
	jq \
	libasound2-dev \
	libcurl4-openssl-dev \
	libdw-dev \
	libelf-dev \
	libexpat1-dev \
	libfreetype6-dev \
	libiberty-dev \
	libsdl2-dev \
	libssl-dev \
	libx11-xcb-dev \
	libxcb1-dev \
	nodejs \
	pkg-config \
	python2.7 \
	python3 \
	wget \
	zip \
	zlib1g-dev \
	&& \
	apt-get clean

# --- kcov --- #

# For some reason `python` isn't the default executable file name.
# Needed for kcov
RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Download kcov
# -nc is okay since we are downloading a tagged version
RUN wget -nc https://github.com/SimonKagstrom/kcov/archive/v$KCOV_VERSION.zip -O kcov.zip && \
	unzip -uoq kcov.zip && \
	rm kcov.zip

# Build KCov
RUN mkdir -p "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}" && \
	cd "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}" && \
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release && \
	make && \
	make install && \
	rm -rf "kcov-$KCOV_VERSION/${KCOV_BUILD_DIR}"

COPY asound.conf /etc/asound.conf
RUN useradd -ms /bin/bash jenkins
RUN usermod -aG audio jenkins
USER jenkins

# We need to do this for the backtracking behaviour for the latest ${CHANNEL} with all available
# components, which may not be the current latest.
#
# See https://github.com/rust-lang/rustup/issues/2227
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none
ENV PATH=/home/jenkins/.cargo/bin:$PATH
RUN rustup toolchain install ${CHANNEL}

RUN rustup component add rustfmt
RUN rustup component add clippy

RUN cargo install mdbook --vers ${MDBOOK_RELEASE}

# WASM, including `nodejs` above
RUN rustup target add wasm32-unknown-unknown
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
