#! /bin/bash
pwd
git pull && git commit -am 'auto commit' && git push
cp -vvv ./html/composer.json ./drupal/composer.json
cd ./drupal && git pull && git commit -am 'auto commit composer.json' && git push
ssh root@123.207.178.25<< EOF
cd /root/html/dcdc_api/ && git checkout . && git pull && chmod +x ./run.sh && ./run.sh
EOF
