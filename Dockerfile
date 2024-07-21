FROM bellsoft/liberica-native-image-kit-container:jdk-21-nik-23-musl AS builder
WORKDIR /app
COPY . /app
RUN apk add --no-cache zlib-static
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package -Pnative

FROM bellsoft/alpaquita-linux-base:stream-musl
WORKDIR /
COPY --from=builder /app/target/demo /
USER 185
ENTRYPOINT ["/demo"]