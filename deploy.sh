
#!/usr/bin/sh

#BUILDNUMBER=`echo $BUILDNO | awk -F "PACKAGE/" '{print $2}' | awk -F "/" '{print $1}'`
#BUILD=DEPLOY.$BUILDNUMBER


BUILDNUMBER=`echo $1 | awk -F "PACKAGE/" '{print $2}' | awk -F "/" '{print $1}'`
BUILD=DEPLOY.$2
ansible-playbook -i hosts docker.yml --limit $ENVIRONMENT -e "build=$BUILD user=admin password=admin123"
