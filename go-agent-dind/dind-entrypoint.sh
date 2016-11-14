rm -rf /var/run/docker.pid
/usr/local/bin/dockerd-entrypoint.sh &
rm -rf /run/go-agent/.agent-bootstrapper.running
/run/go-agent/agent.sh
