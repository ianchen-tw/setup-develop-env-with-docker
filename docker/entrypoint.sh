#!/bin/bash

# source: https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
USER_GID=${LOCAL_USER_GID:-9001}
USER_NAME=yian
GROUP_NAME=yian

groupadd -g ${USER_GID} ${GROUP_NAME}

# echo "Starting with UID : $USER_ID"
if [[ -d /home/${USER_NAME} ]]
then
    # supress home already exist warning
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m ${USER_NAME}  2>/dev/null
else
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m ${USER_NAME}
fi
usermod -g ${GROUP_NAME} ${USER_NAME}

export HOME=/home/${USER_NAME}

cd ${HOME}
exec /usr/sbin/gosu ${USER_NAME} "$@"
