
<img alt="Depend on Docker Logo" src="https://github.com/iankoulski/depend-on-docker/raw/master/DoLogo.png" align="right" width="25%"/>

# depend-on-docker
Depend on Docker {DoD} is an open source project that makes any software easy to build, ship, and run!
It removes complexity by containerizing your executables and all of their dependencies. 

# Your only dependency
If you haven't done so already, please install [Docker](https://www.docker.com/get-docker)

# Create your depend-on-docker project
This project works on both Linux and Windows. It strives to drastically simplify your development process and make it easy to build Docker containers by providing an intuitive project template. To create a project, you can execute the corresponding script, or just run the command line relevant to your operating system below.

## Linux, MacOS

    create.sh [new_project_path]

or

    docker container run --rm -it -v $(pwd):/wd iankoulski/svn sh -c "svn checkout https://github.com/iankoulski/depend-on-docker/trunk/linux/ /wd && rm -rf /wd/.svn"

or

    curl -L http://bit.ly/dodocker-linux | bash -s -- $(pwd)

$(pwd) may be replaced with the desired path where you would like your new depend-on-docker project created.

If you are behind an Internet proxy, set environment variables http_proxyHost and http_proxyPort prior to running the create script. Example: export http_proxyHost=<proxy_host>

**`Demo:`** Create Linux or MacOS container
<img alt="dod-linux-create.gif" title="Create Depend on Docker project on Linux" src="https://github.com/iankoulski/depend-on-docker/raw/master/docs/img/dod-linux-create.gif" width="100%" align="center">
    
## Windows

    create.bat [new_project_path]

or

    docker container run --rm -it -v "%cd%":"c:\wd" iankoulski/win-svn cmd /C "cd c:\wd && svn checkout https://github.com/iankoulski/depend-on-docker/trunk/windows/"

or

    curl -L http://bit.ly/dodocker-windows > create.bat 
    create.bat "%cd%"

If you are behind an Internet proxy, set environment variables http_proxyHost and http_proxyPort prior to running the create script. Example: set http_proxyHost=<proxy_host>

**`Demo:`** Create Windows container 
<img alt="dod-windows-create.gif" title="Create Depend on Docker project on Windows" src="https://github.com/iankoulski/depend-on-docker/raw/master/docs/img/dod-windows-create.gif" width="100%" align="center">

# Customize your depend-on-docker project
Your depend-on-docker project is created with default settings that work out of the box and creates a Docker image called "myapp". There are several settings that you can customize to make this project fit your needs.

## Environment file

    Linux: .env ; Windows: env.cmd

The environment file contains all build-time and run-time settings for your project.
Edit this file to change the name and version tag of your Docker container image, the registry where this image would be stored, the volume mount and port mapping settings for your Docker container, etc.

## Container-Root content

    Linux:  Container-Root -> / ; Windows: Container-Root -> C:\
    
Any artifact placed in the Container-Root folder of this project is copied into the container image. Directory Container-Root is copied to the root path within the container image and subdirectories are included, preserving the subdirectory structure. For example, any items placed in Container-Root/opt/myapp will appear under /opt/myapp within the container.

## Setup script file

    Linux: Container-Root/setup.sh, Windows: Container-Root\setup.bat
    
The setup script file is copied into the root of the container image and executed at build time. Rather than customizing the Dockerfile, the setup script file is a good location for placing all of the project-specific commands you would like to execute when setting up the software in your container image.
The Dockerfile can be modified to further customize your project, however that is not required.

## Startup script file

    Linux: Container-Root/startup.sh, Windows: Container-Root\startup.bat
    
The startup script file is available in the root of the container image and is executed at container startup time. Place the command to start your application in this file.

# Use your depend-on-docker project
For ease of use, all Docker commands required to use this project have been embedded into intuitively named native shell scripts.

## Build

    Linux: ./build.sh ; Windows: build.bat

Builds the Docker container image and tags it using the registry and version tag settingsspecified in your environment file

## Ship (push or pull)

    Linux: ./push.sh or ./pull.sh ; Windows: push.bat or pull.bat

Pushes or pulls the Docker container image to of from the registry specified in your environment file

## Run

    Linux: ./run.sh [command] ; Windows: run.bat [command]

Creates a docker container and, if no argument is specified, executes the startup script. If a command line is specified as an argument to the run script, this command line is executed in the container in place of the default startup script.

## Logs

    Linux: ./logs.sh ; Windows: logs.bat

Tails the output of the command executed inside the container. Use Ctrl-C to stop the tail.

## Exec

    Linux: ./exec.sh [command] ; Windows: exec.bat [command]

This script requires a running container to exist. It executes the specified command in the running container. If no command is specified as an argument, then a default command is executed to open a new interactive shell within the container.

## Status

    Linux: ./status.sh ; Windows: status.bat

This script shows the current status of the Docker container including any mapped ports.

## Stop

    Linux: ./stop.sh ; Windows: stop.bat

Stops the container and cleans up its files.

## Test

    Linux: ./test.sh ; Windows: test.bat

Runs within the container all scripts located in Container-Root that have a name starting with "test". Ideally all Depend-on-Docker containers would have at least one test. Tests are useful to validate that the container is working as expected and also to demonstrate what the container does.

# Conclusion

Depend on Docker is an easy to use project template that helps start working quickly on any of your projects. It lets you embed the knowledge you have about your software into a container that hides away complexities and makes it easy to build, ship, and run on Linux or Windows, locally, in a data center, and on any cloud. To accomplish all of it, the only dependency you need is Docker!

# References

DockerCon 2018 Video: [http://bit.ly/dodockercon](http://bit.ly/dodockercon)

DockerCon 2018 Slides: [http://bit.ly/dodslides](http://bit.ly/dodslides)

Blog: https://blog.docker.com/2018/08/depend-docker-philosophy-baker-hughes-ge-company/

Microsoft Azure AI 2018 Conference Slides: [http://bit.ly/azureaislides](https://github.com/iankoulski/depend-on-docker/raw/master/docs/DependOnDocker-MicrosoftAzureAiConf-LasVegas-20181105.pdf)

Google Next 2019 Analytics Orchestration at Scale Video: [http://bit.ly/analytics-orchestration](http://bit.ly/analytics-orchestration)

Google Next 2019 Democratizing AI Video: [http://bit.ly/democratyzing-analytics](http://bit.ly/democratizing-analytics)

# Links to well-known Depend-on-Docker projects

Ref # | Project Name | Description | Link
--- | --- | --- | ---
1 | `semtk` | Drag and drop SPARQL queries and data ingestion for Virtuoso | [https://github.com/ge-semtk/semtk](https://github.com/ge-semtk/semtk)
2 | `tree` | You do not need to install the Linux tree command, just run it | [https://github.com/iankoulski/tree](https://github.com/iankoulski/tree)
3 | `envsubst` | Run the envsubst command in a Linux container | [https://github.com/iankoulski/envsubst](https://github.com/iankoulski/envsubst)
4 | `enigma` | Encrypt and decrypt content using the enigma container | [https://github.com/iankoulski/enigma](https://github.com/iankoulski/enigma)
5 | `gcp-gpu-monitor` | Monitor usage of your GPUs in Google Cloud | [https://github.com/iankoulski/gcp-gpu-monitor](https://github.com/iankoulski/gcp-gpu-monitor)
6 | `romario` | REST API for kick-starting Kubeflow pipelines | [https://github.com/fabiononato/romario](https://github.com/fabiononato/romario)
7 | `face-recognition` | An example of Depend on Docker for AI applications | [https://github.com/iankoulski/depend-on-docker-ai](https://github.com/iankoulski/depend-on-docker-ai) 
8 | `gitlab` | Depend on Docker for DevOps | [https://github.com/iankoulski/gitlab](https://github.com/iankoulski/gitlab)
