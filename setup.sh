#!/bin/bash

cd scripts

echo -e "Skip EtherCAT Master / EtherLAB installation and setup? (y/n)"
read skip_ethercat

if [[ "$skip_ethercat" == "n" || "$skip_ethercat" == "N" ]]; then
	./ethercat_setup.sh
fi


echo -e "Skip EPICS-Base installation and setup? (y/n)"
read skip_base

if [[ "$skip_base" == "n" || "$skip_base" == "N" ]]; then
	./epics-base_setup.sh
fi

echo -e "Skip EPICS-Support installation and setup? (y/n)"
read skip_support

if [[ "$skip_support" == "n" || "$skip_support" == "N" ]]; then
	./epics-support_setup.sh
fi

echo -e "Skip EtherCAT for EPICS installation and setup? (y/n)"
read skip_epics_ethercat

if [[ "$skip_epics_ethercat" == "n" || "$skip_epics_ethercat" == "N" ]]; then
	./epics-ethercat_setup.sh
fi
