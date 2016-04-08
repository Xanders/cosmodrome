#!/bin/sh
set -e
docker build -t xanders/cosmodrome .
docker push xanders/cosmodrome