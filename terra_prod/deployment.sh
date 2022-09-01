#!/usr/bin/env bash
set -u
ami=$(whoami)
tomcat_arch="$1"
tomcat_src="/tmp/${tomcat_arch}"
tomcat_dir="/opt/tomcat"
3fs_passwd_tmp="/tmp/.passwd-s3fs"
3fs_passwd_root="/root/.passwd-s3fs"
mnt_folder="/tmp/mount"
[ "${ami}" == "root" ] || (echo "You must be root!" && exit 1)
[ -e "${3fs_passwd_tmp}" ] || (echo "Sec password file is absent in tmp" && exit 1)
mv /tmp/.passwd-s3fs /root/
[ -e "${3fs_passwd_root}" ] || (echo "Sec password file is absent in root" && exit 1)
chmod 400 /root/.passwd-s3fs
apt-get update
apt-get install -y default-jdk git tar s3fs > /dev/null 2>&1
rm -rf /var/lib/apt/lists/*
[ -e "${tomcat_src}" ] || (echo "Tomcat srcfolder ${tomcat_src}  is absent!" && exit 1)
([ -d "${tomcat_dir}" ] || mkdir ${tomcat_dir} 2> /dev/null) || (echo "Tomcat workfolder ${tomcat_src}  is absent!" && exit 1)
([ -d "${mnt_folder}" ] || mkdir ${mnt_folder} 2> /dev/null) || (echo "Tomcat workfolder ${mnt_folder}  is absent!" && exit 1)
s3fs hw15 /tmp/mount -o passwd_file=/root/.passwd-s3fs -o url=http://storage.yandexcloud.net -o use_path_request_style
[ -d "${tomcat_dir}" ] || mkdir ${tomcat_dir} 2> /dev/null
tar xpvf "${tomcat_src}" -C "${tomcat_dir}" --strip-components=1 > /dev/null 2>&1
cp ${mnt_folder}/*.*ar ${tomcat_dir}/webapps/
rm -rf /tmp/mount/*
export CATALINA_PID=/opt/tomcat/temp/tomcat.pid
export CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
exec /opt/tomcat/bin/startup.sh