#!/bin/bash
sudo apt-get update
sudo apt upgrade -y
sudo apt-get install -y mc
sudo apt install -y apache2
sudo apt clean
sudo service apache2 start