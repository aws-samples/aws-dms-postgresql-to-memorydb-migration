#! /bin/bash
redis-cli -h $MEMDBHOST -c -p $MEMDBPORT --user $MEMDBUSER --pass $MEMDBPASSWORD --tls
