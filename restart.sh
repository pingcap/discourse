#!/usr/bin/env sh
git pull;
su discourse -c 'COMPILE_TIMEOUT=100000 bundle exec rake assets:precompile';
ps aux | grep unicorn_launcher | head -1 | awk '{print $2}' | xargs kill -s SIGUSR2;