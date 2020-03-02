# PlantUML OCI-compliant image
PlantUML Server is a web application to generate UML diagrams on-the-fly. This project fetches and builds PlantUML Server using source assets (code, pom.xml, etc) managed in the official [GitHub: PlantUML Server project](https://github.com/plantuml/plantuml-server). The goal of this project is to construct a streamline, highly stable and distributable containerized PlantUML Server. This project indirectly employs the [official Alpine Linux Docker image](https://hub.docker.com/_/alpine) as the base image; it's only 5MBs! 

This PlantUML Server image may be used to dynamically render images at design time. If you use Visual Studio Code, install and configure the `jebbs.plantuml` extension. Then you simply run this PlantUML Server container. Moreover, this container image is referenced and used by the [PlantUML Client container project](..TODO..) for batch diagram processing.
 

# Getting Started

## Get the Docker image
This docker image is published a DockerHub public repository, [devtestlabs/plantuml-server](). 

```
docker pull devtestlabs/plantuml-server:{{ VARIANT_TAG }}
```

*NOTE: Replace `{{ VARIANT_TAG }}` with a [valid image variant tag]()*

## Run the Docker container

```
docker run -d -p 8080:8080 devops/plantuml-server:latest
```

The server is now listening to [http://localhost:8080](http://localhost:8080).

## How to set PlantUML options

You can apply some option to your PlantUML server with environement variable.

Use the `-e` flag:
```
docker run -d -p 8080:8080 -e THE_ENV_VARIABLE=THE_ENV_VALUE devops/plantuml-server:latest
```

You can set all  the following variables:

* `PLANTUML_LIMIT_SIZE`
    * Limits image width and height
    * Default value `4096`
* `GRAPHVIZ_DOT`
    * Link to 'dot' executable
    * Default value `/usr/local/bin/dot` or `/usr/bin/dot`
* `PLANTUML_STATS`
    * Set it to `on` to enable [statistics report](http://plantuml.com/statistics-report)
    * Default value `off`

## Using the container
### Design time "real-time" diagram rendering
This PlantUML Server image may be used to dynamically render images at design time. If you use Visual Studio Code (VSCode), install and configure the `jebbs.plantuml` extension. You can find more information about this VSCode extension at [VisualStudio Marketplace: Jebbs Plantuml extension](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml) and at the [Github: qjebbs/vscode-plantuml project](https://github.com/qjebbs/vscode-plantuml).

*TODO: write and reference step-by-step tutorial*

### Batch processing of diagrams
The second usecase for this PlantUML Server image is batch process (render) PNG and SVG image files from PlantUML specification (*.puml) files. You can integrate the use of this PlantUML Server with the devtestlabs/plantuml-client container image. 

*TODO: write and reference step-by-step tutorial*

# Build the docker image locally
The Dockerfile specifies a two phase image build. The first phase is the plantuml war file builder process. The second phase results in the construction of the runtime container image. Review the [Dockerfile](Dockerfile) for more information.

```
docker image build -t devtestlabs/plantuml-server:local . 
docker run -d -p 8080:8080 devops/plantuml-server:local
```
The server is now listing to [http://localhost:8080/plantuml](http://localhost:8080/plantuml).

# TODOs
* Migrate to Java 11
* Add GitHub Actions script to build and publish Docker image
* Write tutorials on two usecases
* Update README

# External References

* http://plantuml.com/

* https://github.com/plantuml/plantuml-server

* https://github.com/plantuml/plantuml-server/releases