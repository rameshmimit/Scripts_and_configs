#!/bin/sh
## Description: Below script will install OpenERP latest version on CentOS-6.x server
## Author: Verts Services India Pvt. Ltd.
yum -y install wget unzip
rpm -ivh 	http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://yum.pgrpms.org/9.2/redhat/rhel-6.4-x86_64/pgdg-centos92-9.2-6.noarch.rpm
yum -y install python-psycopg2 python-lxml PyXML python-setuptools libxslt-python pytz \
            python-matplotlib python-babel python-mako python-dateutil python-psycopg2 \
            pychart pydot python-reportlab python-devel python-imaging python-vobject \
            hippo-canvas-python mx python-gdata python-ldap python-openid \
            python-werkzeug python-vatnumber pygtk2 glade3 pydot python-dateutil \
            python-matplotlib pygtk2 glade3 pydot python-dateutil python-matplotlib \
            python python-devel python-psutil python-docutils make\
            automake gcc gcc-c++ kernel-devel byacc flashplugin-nonfree poppler-utils pywebdav \
						PyYAML python-ZSI python-feedparser python-jinja2 python-mock python-pip python-simplejson \
						python-unittest2 pywebdav libyaml pyparsing bzr python-lxml
						
			
yum -y install postgresql92-libs postgresql92-server postgresql92
service postgresql-9.2 initdb
chkconfig postgresql-9.2 on
service postgresql-9.2 start
su - postgres -c "createuser  --superuser openerp"
cd /tmp
wget http://gdata-python-client.googlecode.com/files/gdata-2.0.17.zip
unzip gdata-2.0.17.zip
rm -rf gdata-2.0.17.zip
cd gdata*
python setup.py install
cd /opt/
adduser openerp
DIR="/var/run/openerp /var/log/openerp"
for NAME in $DIR
do
if [ ! -d $NAME ]; then
   mkdir $NAME
   chown openerp.openerp $NAME
fi
done
rm -rf openerp*
wget http://nightly.openerp.com/7.0/nightly/src/openerp-7.0-latest.tar.gz
tar -zxvf openerp-7.0-latest.tar.gz  --transform 's!^[^/]\+\($\|/\)!openerp\1!'
cd openerp
python setup.py install
rm -rf /usr/local/bin/openerp-server
cp openerp-server /usr/local/bin
cp install/openerp-server.init /etc/init.d/openerp
cp install/openerp-server.conf /etc
chown openerp:openerp /etc/openerp-server.conf
chmod u+x /etc/init.d/openerp
chkconfig openerp on
service  openerp start
