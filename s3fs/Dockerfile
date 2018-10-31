########################################################
# The FUSE driver needs elevated privileges, run Docker with --privileged=true 
# or with minimum elevation as shown below:
# $ sudo docker run -d --rm --name s3fs --security-opt apparmor:unconfined \
#  --cap-add mknod --cap-add sys_admin --device=/dev/fuse \
#  -e S3_BUCKET=MY_S3_BUCKET -e S3_REGION=ap-southeast-2 \
#  -e MNT_POINT=/data git.encompasshost.com:5001/encompass/images/s3fs:latest
# example for ceph using:s3fs my-bucket /mnt/data-s3fs -o passwd_file=~/.passwd-s3fs,endpoint=default \
# url=http://10.206.8.92:7480/,use_path_request_style,allow_other,use_cache=/tmp,max_stat_cache_size=1000,curldbg
# docker run --rm --privileged -d -e S3_BUCKET=my-bucket-1 -e S3_REGION=default -e AWS_KEY=xxx 
# -e AWS_SECRET_KEY=xxxx -v /data-1/s3fs-data:/data:shared s3fs:v2
########################################################
 
FROM ubuntu:16.04
 
LABEL maintainer="qspeng"
 
ENV S3_BUCKET ''
ENV MNT_POINT /data
ENV S3_REGION 'default'
ENV AWS_KEY ''
ENV AWS_SECRET_KEY ''
ENV S3_URL 'http://10.206.8.92:7480/'

COPY docker-entrypoint.sh /usr/local/bin/

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update --fix-missing && \
    apt-get -y install s3fs && \
    ldconfig && s3fs --version && \
    echo "${AWS_KEY}:${AWS_SECRET_KEY}" > /etc/passwd-s3fs && \
    chmod 600 /etc/passwd-s3fs && mkdir -p "$MNT_POINT" && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
