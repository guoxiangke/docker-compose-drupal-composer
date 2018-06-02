#! /bin/bash
pwd
gtp && gtps
cp -vvv ./html/composer.json ./drupal/composer.json
cd ./drupal
gtp
gtac 'update composer.json'
gtps
ssh root@123.207.178.25<< EOF
cd /root/html/dcdc_api/ && git checkout && git pull && chmod +x ./run.sh && ./run.sh
EOF
