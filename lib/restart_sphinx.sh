#!/bin/bash

echo "SSHing into utility server ec2-50-16-160-202"
ssh deploy@ec2-50-16-160-202.compute-1.amazonaws.com "echo 'cd /data/1SaleADay/current' && cd /data/1SaleADay/current && echo 'Restarting Sphinx...' && RAILS_ENV=production bundle exec rake ts:restart"
