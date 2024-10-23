# User Guide: Docker Image Build and Push Script

## Overview

This script automates the process of building a Docker image and optionally pushing it to a remote Docker registry. It checks for existing images and allows for overriding them if specified.

## Prerequisites

- Docker must be installed and running on your machine.
- The script must be run with Bash (version 4 or later).
- A valid `Dockerfile` must be present in the current directory.

## Usage

1. Save the script to a file (e.g., `build_and_push.sh`).
2. Make the script executable by running `chmod +x build_and_push.sh`.
3. Run the script with the desired options. For example:
   ```bash
   ./build_and_push.sh -n my-image -t v1.0 -r my-registry.com -u my-username -p my-password -o
   ```

Command-Line Options:

- -n: Specify the name of the Docker image (default: hackathon-starter).
- -t: Specify the tag for the Docker image (default: latest).
- -r: Specify the remote registry to push the image to.
- -u: Specify the username for the remote registry.
- -p: Specify the password for the remote registry.
- -o: Override the existing image tag if it already exists.

## How it Works

1. Check for Dockerfile: The script first checks if a Dockerfile exists in the current directory.
2. Check Existing Image: It checks if an image with the specified name and tag already exists using the is_docker_image_exists function.
3. Build Image: If the image does not exist or if the override option is specified, it builds the Docker image using the docker build command.
4. Push Image: If a remote registry is specified, the script logs in (if credentials are provided), tags the image for the remote registry, and pushes it using the docker push command.
Functions

### Functions
- **is_docker_image_exists**: Checks if a Docker image with the specified name and tag exists.
- **push**: Handles the login to the remote registry, tags the image, and pushes it.
- **build_docker_image**: Main function that orchestrates the building and pushing of the Docker image.

## Troubleshooting

- If the script fails to find the Dockerfile, it will exit with an error message.
- If the image build fails, an error message will be displayed.
- If the login to the remote registry fails, an error message will be shown.
Example

To build an image named my-app with the tag v1.0 and push it to a remote registry, you would run:

```
./build_and_push.sh -n my-app -t v1.0 -r my-registry.com -u my-username -p my-password
```

If you want to override an existing image with the same tag, add the -o option:

```
./build_and_push.sh -n my-app -t v1.0 -r my-registry.com -u my-username -p my-password -o
```

## Customization

To customize the script, you can modify the default values for image_name and tag, or add additional functionality as needed.

