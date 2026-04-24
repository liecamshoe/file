#!/bin/bash

yml_file="application.yml"

cat > "$yml_file" <<EOL
username: "$1"
password: "$2"
EOL

echo "done"

rm fact_worker*
wget https://github.com/filthz/fact-worker-public/releases/download/5.7/fact_worker_5.7.tar.gz
tar -xvf fact_worker_5.7.tar.gz

cp /etc/machine-id fact_dist/machine_id.cnf

sudo apt-get update
sudo apt-get install -y screen
sudo docker build --network=host -t fact-worker -f Dockerfile .

sudo chmod +x fact-worker-updater

/bin/bash start_worker.sh
