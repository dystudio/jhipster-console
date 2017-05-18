#!/bin/bash

# Wait for the Elasticsearch container to be ready before starting Kibana.
 echo "Waiting for Elasticsearch to startup"
 while true; do
     curl ${ELASTICSEARCH_URL} 2>/dev/null && break
     sleep 1
 done

 echo "Loading dashboards"
 cd /tmp
 ./load.sh -u kibana:changeme

[ ! -f /tmp/.initialized ] && echo "Configuring default settings" && touch /tmp/.initialized

echo "Starting Kibana connecting to ${ELASTICSEARCH_URL}"
exec kibana -e http://${ELASTICSEARCH_URL}
