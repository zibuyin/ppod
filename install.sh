#!/bin/bash

echo Setting up config file at /etc/ppod/ppod.conf
mkdir -p /etc/ppod/
touch /etc/ppod/ppod.conf
mv ./ppod.conf.template /etc/ppod/ppod.conf
