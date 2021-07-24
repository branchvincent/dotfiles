function _tide_item_docker --description 'Show Docker containers'
    test -f docker-compose.yaml -o -f docker-compose.yml || return
    set -l containers (count (docker-compose ps -q 2>/dev/null)) || return
    printf (set_color blue --bold)
    test $containers -gt 1 && printf " $containers"
end
