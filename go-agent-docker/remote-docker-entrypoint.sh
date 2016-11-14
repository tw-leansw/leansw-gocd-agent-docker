/usr/local/bin/docker-entrypoint.sh &
rm -rf /run/go-agent/.agent-bootstrapper.running
/run/go-agent/agent.sh
