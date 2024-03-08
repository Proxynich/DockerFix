#!/bin/bash
rm docker-compose.yml

prune_menu() {
    echo "Are You sure want to delete all container, network, and volume?:"
    echo "1. Yes"
    echo "2. No"
    echo "Select 1 or 2"
    echo -n "Insert: "
}

# Source List
prune() {
    read del_dock
    case $del_dock in
        1)
            echo -e "\033[1;32mProccessing\033[0m"
            container_name=$(docker ps -aq)
            docker stop $container_name
            docker container prune -f
            docker volume prune -f
            docker network prune -f
            echo -e "All Done"
            ;;
        2)
            echo -e "\033[1;32mOkay Next\033[0m"
            ;;
        *)
            echo -e "\033[1;31mInvalid Choice!\033[0m"
            return 1
            ;;
    esac
}

prune_menu
while ! prune; do
    prune_menu
done 