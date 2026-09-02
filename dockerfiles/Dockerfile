# Base image
FROM wordpress:php8.3-fpm

# Maintainer details
LABEL Maintainer="Eric Ngigi <ericngigi@ericngigi.com>"
LABEL Description="Development Wordpress Dockerfile with wp-cli installed"
LABEL Version="1.0"

# Define build arguments with fallbacks
ARG USER_NAME=wordpress-dev
ARG USER_ID=1001
ARG GROUP_ID=1001

# Installed required system dependencies for wp-cli installation
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo git unzip zip curl gnupg bash vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI globally
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create dev user matching host UID/GID
RUN groupadd -g ${GROUP_ID} ${USER_NAME} \
    && useradd -u ${USER_ID} -ms /bin/bash -g ${USER_NAME} ${USER_NAME} \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER_NAME} \
    && chmod 0440 /etc/sudoers.d/${USER_NAME} \
    && mkdir -p /home/${USER_NAME}/.config \
    && chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}

# Set Composer home for magento user
ENV COMPOSER_HOME=/home/${USER_NAME}/.composer
RUN mkdir -p $COMPOSER_HOME && chown -R ${USER_NAME}:${USER_NAME} $COMPOSER_HOME

# Ensure web root directory exists and ownership allows dev user management
WORKDIR /var/www/html
RUN chown -R ${USER_NAME}:${USER_NAME} /var/www/html

# Start php-fpm
CMD ["php-fpm"]
