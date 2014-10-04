# based on a nice elixir image, then adding mysql. nothing fancy
#
FROM trenpixster/elixir:1.0.0
MAINTAINER Rubén Caro <ruben.caro.estevez@gmail.com>

# install mysql
RUN apt-get update && apt-get install -y mysql-server

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# setup mysql
ADD setup_mysql.sh /setup_mysql.sh
RUN chmod 755 /*.sh
RUN /setup_mysql.sh

# run mysql on start
CMD service mysql start

