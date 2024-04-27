function docker --description "Docker wrapper to ensure the daemon is running"
    if ! pgrep -q OrbStack
        # Boot daemon
        open -jga OrbStack || exit 1
        while ! curl -f --unix-socket /var/run/docker.sock localhost/_ping &>/dev/null
            sleep 0.5
        end
    end

    command docker $argv
end
