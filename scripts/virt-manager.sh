#!/usr/bin/env sh

docker run --rm -v \
    -v $HOME/.docker-libvirt-config:/home/app/.config/dconf \
    -v $HOME/.ssh/known_hosts:/home/app/.ssh/known_hosts \
    -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
    -v /usr/share/fonts:/usr/share/fonts:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY="$DISPLAY" \
    subuk/virt-manager
