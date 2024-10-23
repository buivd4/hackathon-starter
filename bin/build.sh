#!/bin/bash


is_docker_image_exists(){
    local image_name=$1
    local tag=$2
    if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^${image_name}:${tag}$"; then
        return 1
    else
        return 0
    fi
}
push() {
    local image_name=$1
    local tag=$2
    local remote_registry=$3
    local username=$4
    local password=$5

    if [ ! "$remote_registry" ]; then
        echo "[ERROR] Remote registry is not specified"
        return 1
    else
        # Log in to the remote registry if username and password are provided
        if [[ -n "$username" && -n "$password" ]]; then
            echo "[INFO] Logging in to remote registry '${remote_registry}'..."
            echo "$password" | docker login "$remote_registry" -u "$username" --password-stdin
            if [[ $? -ne 0 ]]; then
                echo "[ERROR] Failed to log in to the remote registry."
                return 1
            fi
        fi
        # Tag the image for the remote registry
        local full_image_name="${remote_registry}/${image_name}:${tag}"
        echo "[INFO] Tagging image '${image_name}:${tag}' as '${full_image_name}'..."
        docker tag "${image_name}:${tag}" "$full_image_name"

        # Push the image to the remote registry
        echo "[INFO] Pushing image '${full_image_name}' to remote registry..."
        docker push "$full_image_name"

        if [[ $? -eq 0 ]]; then
            echo "[INFO] Successfully pushed '${full_image_name}' to '${remote_registry}'."
        else
            echo "[ERROR] Failed to push image to remote registry."
            return 1
        fi

    fi
}
build_docker_image() {
    # Default values
    local image_name="hackathon-starter"
    local tag="latest"
    local override=false
    local remote_registry=""
    local username=""
    local password=""

    # Parse command-line options
    while getopts ":n:t:r:u:p:o" opt; do
        case ${opt} in
            n )
                image_name="$OPTARG"
                ;;
            t )
                tag="$OPTARG"
                ;;
            r )
                remote_registry="$OPTARG"
                ;;
            u )
                username="$OPTARG"
                ;;
            p )
                password="$OPTARG"
                ;;
            o )
                override=true
                ;;
            \? )
                echo "[ERROR] Invalid option: -$OPTARG" 1>&2
                return 1
                ;;
            : )
                echo "Invalid option: -$OPTARG requires an argument" 1>&2
                return 1
                ;;
        esac
    done

    # Check if Dockerfile exists
    if [[ ! -f Dockerfile ]]; then
        echo "[ERROR] Dockerfile not found in the current directory."
        return 1
    fi

    # Check if the tag already exists
    is_docker_image_exists $image_name $tag
    if [ $? -eq 1 ]; then
        if [ "$override" = false ]; then
            echo "[INFO] Tag '${tag}' of image '${image_name}' already exists. Use -o to override."
            return 1
        else
            echo "[INFO] Overriding existing tag '${tag}' of image '${image_name}'."
        fi
    fi

    # Build the Docker image
    echo "[INFO] Building Docker image '${image_name}' with tag '${tag}'..."
    docker build -t "${image_name}:${tag}" .

    is_docker_image_exists $image_name $tag
    if [ $? -eq 1 ]; then
        echo "[INFO] Docker image '${image_name}:${tag}' built successfully."
    else
        echo "[ERROR] Failed to build Docker image."
        return 1
    fi
    
    if [ "$remote_registry" ]; then
        push $image_name $tag $remote_registry $username $password
    fi
}

# Call the function with arguments
build_docker_image "$@"