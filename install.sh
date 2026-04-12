#!/bin/bash

echo Setting up config file at /etc/ppod/ppod.conf
mkdir -p /etc/ppod/
touch /etc/ppod/ppod.conf
cp ./ppod.conf.template /etc/ppod/ppod.conf
sudo chmod 640 /etc/ppod/ppod.conf