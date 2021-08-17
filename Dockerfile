FROM debian:buster-slim
RUN apt-get update -y && apt-get install -y g++ make wget libboost-all-dev git zlib1g-dev libwebsocketpp-dev
RUN wget https://cmake.org/files/v3.9/cmake-3.9.4.tar.gz && tar xvzf cmake-3.9.4.tar.gz && cd cmake-3.9.4 && ./bootstrap && make -j4 && make install && cd .. && rm -rf cmake-3.9.4
RUN apt-get install -y libssl-dev
RUN mkdir -p app/libs
ADD libs/build_dependencies.sh app/libs
RUN cd app/libs && ./build_dependencies.sh
ADD . /app
EXPOSE $PORT
RUN cd /app && ls -la && cmake . && cmake --build .
ENTRYPOINT ["bash", "-c", "./app/crest"]

