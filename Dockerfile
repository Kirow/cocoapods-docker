# Build this image with:
# docker build -t cocoapods-image .
# add environment variable to ~/.zshrc
# export POD_CACHE_DIR=path-to-this-folder/cocoapods-cache
FROM ruby:alpine

RUN apk add --no-cache build-base git rsync bash tcl curl

RUN gem install cocoapods

# it may require additional packages for certain dependencies
# RUN apk add --no-cache ...

WORKDIR /app

# Create a non-root user to run CocoaPods
RUN adduser -D poduser
RUN chown -R poduser:poduser /app
USER poduser

# Example: To run this container and install CocoaPods dependencies
# Run the container with --rm flag to remove it after execution:
#   docker run --rm -v $(pwd):/app -v $POD_CACHE_DIR:/home/poduser/.cocoapods cocoapods-image install
# This will execute the pod install command and remove the container after completion
# Note: This approach won't preserve cache between runs
ENTRYPOINT ["pod"]
