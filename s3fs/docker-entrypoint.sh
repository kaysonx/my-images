#!/bin/bash

echo "${AWS_KEY}:${AWS_SECRET_KEY}" > /etc/passwd-s3fs
echo "TEST:${AWS_SECRET_KEY}" > /etc/passwd-test
s3fs $S3_BUCKET $MNT_POINT -f -o endpoint=${S3_REGION},url=${S3_URL},use_path_request_style,allow_other,use_cache=/tmp,max_stat_cache_size=1000,stat_cache_expire=900,retries=5,connect_timeout=10,curldbg