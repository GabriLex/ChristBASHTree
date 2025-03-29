FROM alpine:latest

# Copy the script into the container
COPY tree-EN.sh /tree-EN.sh

# Install dependencies
RUN apk add --no-cache ncurses bash

# Set environment variable for proper terminal display
ENV TERM=xterm-256color

# Set default command to run the script
CMD ["bash", "/tree-EN.sh"]
