#!/bin/bash

STAGE=localdist DMP_BACKEND_URL=http://docker:8087/dmp/ DMP_DIST_DIR=../../docker/dswarm/nginx grunt ngconstant:localdist

