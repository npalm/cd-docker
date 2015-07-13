# CD environment

The complete CD environment is amsembled using docker containers. The docker-compose.yml files defines all artifacts and links them to eacht other. The following stack is used.

- Jenkins: An extension on top of jenkins is created to define the plugins. See ./jenkins
- Artifactory: A custom docker image is used, see ./artifactory
- Sonarqube: Default sonarqube is used
- Postgres: Default image is used, database is used by sonar.

Create the build enviroment as follow.
```
> docker-compose build && docker-compse up
```


>**Notes: **
1. Before creating the build environment create the jenkins dir and set the permissions right.
``` mkdir .data/jenkins && chown 777 ./data/jenkins ```
2.

## Quick startup
1. `cd docker`
2. Build the jenkins container: `docker-compose build jenkins`
3. Start the jenkins container: `docker-compose jenkins`
4. Go to [jenkins configuration page]{http://localhost:8080/configure}
5. Go to the docker section and provide the docker url `http://dockerhost:2375`
6. Go to [create new job]{http://localhost:8080/view/All/newJob}
7. Add a new free style job to unit test and package the application.
8. Checkout the stickynote-web from FSC (public fsc git). You can use your own credentials or setup a ssh shared key.
9. A a command line execute script task. Provide the following command: `run-containerized -c "echo "Y" | npm install ; npm test"`


## Build in a docker container


### Node
In the directory node there is a container specification available that is designed to run node related build in a container.

First build the container.

```
docker build --tag devops/node .
```
Now you can run a build in the container. The idea is that you mount the directory that conaints the code to the container. The init script that we execute on startup is contrstucted in the `Dockerfile`
```
run --rm -t -i -w /workspace -v  <path-to-project-dir>:/workspace \
-e 'DISPLAY=:0' devops/node bash -c "INIT=/usr/local/bin/init-container ;\
 [ -e \$INIT ] && \$INIT ; <your build commands> "
 ```

### Build in jenkins
The jenkins container is provided with an extra script run builds in the conatiner, `run-containerized`.
