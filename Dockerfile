FROM jupyter/scipy-notebook
USER root
RUN apt-get update -y
RUN apt-get install vim -y
RUN git config --global url."https://{ACCESS TOKEN}:@github.com/".insteadOf "https://github.com/"
RUN git config --global user.email "example@example.com"
RUN git config --global user.name "Example Example (Remote)"
