# CocoaPods Docker Image

This repository contains a Docker image for running CocoaPods commands without installing CocoaPods locally on your machine.

## Prerequisites

- Docker installed on your system
- Git (for repository clone)

## Setup

1. Build the Docker image:

```bash
docker build -t cocoapods-image .
```

2. Add the environment variable to your shell configuration (e.g., `~/.zshrc`):

```bash
export POD_CACHE_DIR=/path-to-this-folder/cocoapods-cache
```

3. Reload your shell configuration:

```bash
source ~/.zshrc
```

## Usage

Run CocoaPods commands from your iOS project directory:

```bash
docker run --rm -v $(pwd):/app -v $POD_CACHE_DIR:/home/poduser/.cocoapods cocoapods-image install
```

This command:
- Mounts your current directory to `/app` inside the container
- Mounts the cache directory to preserve CocoaPods cache between runs
- Runs `pod install` in your project directory
- Removes the container after execution (`--rm` flag)

You can replace `install` with any other CocoaPods command:

```bash
# Update CocoaPods repositories
docker run --rm -v $(pwd):/app -v $POD_CACHE_DIR:/home/poduser/.cocoapods cocoapods-image repo update

# Run pod update
docker run --rm -v $(pwd):/app -v $POD_CACHE_DIR:/home/poduser/.cocoapods cocoapods-image update
```

## About This Image

This Docker image:
- Uses Ruby Alpine as the base image
- Installs necessary dependencies (build-base, git, rsync, bash, tcl, curl)
- Installs CocoaPods
- Creates a non-root user for better security
- Uses the CocoaPods command as the entrypoint

## Customization

If you need additional packages for certain dependencies, you can uncomment and modify the following line in the Dockerfile:

```dockerfile
# RUN apk add --no-cache ...
```

After making changes to the Dockerfile, rebuild the image:

```bash
docker build -t cocoapods-image .
```