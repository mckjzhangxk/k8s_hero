
COPY --from=builder /app/intelRouter/bin/main /app/intelRouter
docker build --target builder -t brtc-router .