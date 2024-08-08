#!/bin/bash

# Create directories for yams and media
mkdir -p /opt/arrs /srv/media

# Create user 'arr' with home directory
useradd -m -s /bin/bash arr

# Grant ownership and permissions to 'arr'
chown -R arr:arr /opt/arrs /srv/media
chmod -R g+rwX /opt/arrs /srv/media

# Add 'arr' to the docker group if it exists
DOCKER_GROUP=$(getent group docker | cut -d: -f1)
if [[ -n "${DOCKER_GROUP}" ]]; then
  usermod -aG docker arr
fi

# Switch to 'arr' user and run docker-compose
su -c "cd /opt/arrs && newgrp docker && docker-compose up -d" arr

# Print success messages
echo "Directories created and permissions set."
echo "User 'arr' created. Remember to set a password for this user."
