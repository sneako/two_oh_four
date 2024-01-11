FROM rust:1.73.0-buster as builder

ENV CARGO_NET_GIT_FETCH_WITH_CLI=true

WORKDIR /usr/src

# Cache deps in separate layer from the app
WORKDIR /usr/src/two_oh_four
COPY ./Cargo.lock .
COPY ./Cargo.toml .

# Now we finally compile our app
COPY ./src ./src
RUN cargo install --path .

FROM debian:buster-slim
RUN apt-get update && \
  apt-get install -y openssl ca-certificates && \
  rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/two_oh_four /usr/local/bin/mirall
CMD ["two_oh_four"]
