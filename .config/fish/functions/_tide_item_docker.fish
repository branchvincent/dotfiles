function _tide_item_docker --description 'Show Docker containers'
    test -f docker-compose.yaml -o -f docker-compose.yml || return
    set -l containers (count (docker-compose ps -q 2>/dev/null)) || return
    tide_docker_color=blue tide_docker_bg_color=normal \
        _tide_print_item docker ' ' $containers
end
