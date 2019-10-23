# https-jupyter-server-docker
Creates a Docker Image and Container with both SSL Certificates and Git Configured. <br>
## Rationale
I wanted to create a way to run a Jupyter Server over HTTPS. In order to increase scalability and improve security, I decided the best course of action was to run the server within a Docker Container, so that I can both isolate and easily rebuild the server should the need arise. I wanted to be able to run Git within the server, however I did not want to have to mount SSH keys to the server, nor leave any trace of SSH keys on the server. In order to accomplish this, I decided to use Github Personal Access Tokens. Because these tokens can have varying levels of permission, and can be revoked without breaking anything outside of the container, I believe these to be the best course of action to take in regards to using Git on the server.<br>
## Installation Instructions
Note: By default, this is configured to work with the *jupyter/scipy-notebook* Docker image. If you wish to use another Jupyter image, replace all instances of *jupyter/scipy-notebook* and *jupyter-scipy* in files with appropriate Jupyter image. (See https://hub.docker.com/u/jupyter/ for all the images)
1. Install and configure Docker, open desired ports, and set up your SSL certificates (I recommend LetsEncrypt)
2. Next, you will need to generate a Github Personal Access Token to use for the Git Integration (https://github.com/settings/tokens)
3. In **Dockerfile**, add your Github Personal Access Token in the place of `RUN git config --global url."https://{ACCESS TOKEN}:@github.com/".insteadOf "https://github.com/"`
4. In **Dockerfile**, add your email and name in the appropriate locations
5. Build the Docker image by running `docker build -t {USERNAME}/jupyter-scipy .`
6. In **docker-run.sh**, replace the volumes with the locations of your SSL keys, as well as the location of your files for the container
7. In **docker-run.sh**, replace the `{USERNAME}` with the same name that you used for the "docker build" command
8. In **docker-run.sh**, replace the `{INSERT HASHED PW HERE}` with a hashed password. (See https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#preparing-a-hashed-password)
9. In **docker-run.sh**, replace the `8888:8888` and `--NotebookApp.port=8888` with whatever port that you previously configured
10. Execute `docker-run.sh init` to start the server
