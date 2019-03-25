
#!/usr/bin/sh

#BUILDNUMBER=`echo $BUILDNO | awk -F "PACKAGE/" '{print $2}' | awk -F "/" '{print $1}'`
#BUILD=DEPLOY.$BUILDNUMBER

ENVIRONMENT=$2

BUILDNUMBER=`echo $1 | awk -F "PACKAGE/" '{print $2}' | awk -F "/" '{print $1}'`
BUILD=DEPLOY.$BUILDNUMBER
ansible-playbook -i hosts docker.yml --limit $ENVIRONMENT -e "build=$BUILD user=admin password=admin123"
