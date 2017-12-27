#!/bin/bash


IMAGE_URL=http://cloud-deploy/cloud-images/
IMAGE=CentOS-7-x86_64-GenericCloud-1707.raw
IMAGE_NAME=centos

unset LANG
unset LANGUAGE
LC_ALL=C
export LC_ALL
for i in curl openstack; do
    if [[ ! $(type ${i} 2>/dev/null) ]]; then
        if [ "${i}" == 'curl' ]; then
            echo "Please install ${i} before proceeding"
        else
            echo "Please install python-${i}client before proceeding"
        fi
        exit
    fi
done

# Test for credentials set
if [[ "${OS_USERNAME}" == "" ]]; then
    echo "No Keystone credentials specified.  Try running source openrc"
    exit
fi

# Test to ensure configure script is run only once
if openstack image list | grep -q ${IMAGE_NAME}; then
    echo "The ${IMAGE_NAME} image is already existed"
    exit
fi

echo Downloading glance image.
if ! [ -f "${IMAGE}" ]; then
    curl -L -o ./${IMAGE} ${IMAGE_URL}/${IMAGE}
fi

echo Creating glance image.
openstack image create --disk-format raw --container-format bare --public \
    --file ./${IMAGE} ${IMAGE_NAME}

echo Delete ${IMAGE}
rm -f ./${IMAGE}