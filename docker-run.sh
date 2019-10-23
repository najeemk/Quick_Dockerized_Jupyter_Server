NOTEBOOK=jupyter-scipy
IMAGE={USERNAME}/$NOTEBOOK
if [ "$1" = "start" ]
then
        echo "Starting $NOTEBOOK notebook server..."
        docker start $NOTEBOOK
elif [ "$1" = "init" ]
then
        echo "Initializing $NOTEBOOK notebook server..."
        echo "Stopping and removing existing server..."
        docker stop $NOTEBOOK
        docker rm $NOTEBOOK
        echo "Starting new server..."
        docker run --name "$NOTEBOOK" -d -p 8888:8888\
        -v /path/to/ssl/certs/fullchain.pem:/etc/letsencrypt/ssl/fullchain.pem \
        -v /path/to/ssl/certs/privkey.pem:/etc/letsencrypt/ssl/privkey.pem \
        -v /path/to/volume/files/:/home/jovyan/work \
            $IMAGE start-notebook.sh \
            --NotebookApp.certfile=/etc/letsencrypt/ssl/fullchain.pem \
            --NotebookApp.keyfile=/etc/letsencrypt/ssl/privkey.pem \
            --NotebookApp.port=8888 \
            --NotebookApp.password='{INSERT HASHED PW HERE}' \
            --NotebookApp.quit_button=False
        echo "Server is initialized!"
elif [ "$1" = "stop" ]
then
        echo "Stopping $NOTEBOOK notebook server..."
        docker stop $NOTEBOOK
else
        echo "You can either run \"start\" to start the server, \"init\" to initialize (or reinitialize) the server, or \"stop\" to stop (but not remove) the server."
fi
