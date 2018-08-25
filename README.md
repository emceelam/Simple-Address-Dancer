# NAME

Simple Adddress App

# DESCRIPTION

This is the REST side of a simple address app, utilizing Google Maps. The REST side is coded with Mojolicious.

# SYNOPSIS

Run REST server

    plackup -R lib bin/app.psgi

# INSTALL

    sudo cpanm \
      Dancer2 \
      Dancer2::Plugin::Database \
      List::MoreUtils

    mysql -h localhost -u root -p
    CREATE USER 'simple_address_dancer'@'localhost' IDENTIFIED BY '';
    CREATE DATABASE simple_address_dancer;
    use simple_address_dancer;
    GRANT ALL PRIVILEGES ON simple_address_dancer TO 'simple_address_dancer'@'localhost';
    GRANT ALL PRIVILEGES ON simple_address_dancer.* TO 'simple_address_dancer'@'localhost';
    exit;

    mysql simple_address_dancer -u simple_address_dancer -p  < create.sql