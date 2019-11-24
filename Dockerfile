FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:jonathonf/llvm

RUN apt-get install -y  build-essential gcc make cmake git clang-9 lldb-9 gnuplot imagemagick \
  python-jsonschema xsltproc libsaxon-java libxml2-utils intltool libglib2.0-dev libgtk-3-dev \
  libxml2-dev librsvg2-dev libsqlite3-dev libcurl4-openssl-dev libjpeg-dev libpugixml-dev \
  libtiff-dev liblcms2-dev libjson-glib-dev libexiv2-dev exiv2 gphoto2

RUN git clone https://github.com/darktable-org/darktable.git
WORKDIR /darktable
RUN git submodule init && git submodule update

RUN mkdir build
WORKDIR /darktable/build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make -j5
RUN make install

WORKDIR /darktable/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/opt/darktable -DBUILD_NOISE_TOOLS=ON ..
WORKDIR /darktable/build/tools/noise
RUN make
RUN make install

CMD /opt/darktable/libexec/darktable/tools/darktable-gen-noiseprofile -d /pictures
