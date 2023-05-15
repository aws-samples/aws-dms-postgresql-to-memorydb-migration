#! /bin/bash

sudo yum update -y
sudo yum install -y autoconf readline-devel zlib-devel jq
sudo yum install -y gcc jemalloc-devel openssl-devel tcl tcl-devel clang wget
wget https://ftp.postgresql.org/pub/source/v12.5/postgresql-12.5.tar.gz
tar -xzf postgresql-12.5.tar.gz
cd postgresql-12.5
autoconf
./configure
make -j 4 all
sudo make install
cd ..
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
CC=clang sudo make BUILD_TLS=yes


export REGION=`aws configure get region`

echo "export DBUSER=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"username\"'\`" >> ~/.bashrc
echo "export PORT=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"port\"'\`" >> ~/.bashrc
echo "export DB=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"dbname\"'\`" >> ~/.bashrc
echo "export HOST=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"host\"'\`" >> ~/.bashrc
echo "export DBPASSWORD=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"password\"'\`" >> ~/.bashrc

echo "export MEMDBUSER=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/memorydbredissecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"username\"'\`" >> ~/.bashrc
echo "export MEMDBPORT=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/memorydbredissecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"port\"'\`" >> ~/.bashrc
echo "export MEMDB=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/memorydbredissecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"dbname\"'\`" >> ~/.bashrc
echo "export MEMDBHOST=\`aws cloudformation describe-stacks --region us-east-1 --query \"Stacks[?StackName=='DMSPostgreSQLMemoryDB'][].Outputs[?OutputKey=='MemoryDBRedisClusterEndpoint'].OutputValue\" --output text\`" >> ~/.bashrc
echo "export MEMDBPASSWORD=\`aws secretsmanager get-secret-value  --secret-id \"/dmsdemo/memorydbredissecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"password\"'\`" >> ~/.bashrc

echo "export PATH=\"$PATH:/usr/local/pgsql/bin:/home/ec2-user/environment/dms-posgresql-memorydb/scripts/redis-stable/src/\"" >> ~/.bashrc

