#!/bin/bash


echo -e "\n-----------------------------------------------------------------------\n"
echo -e "\nFor which user are you installing EPICS support?: "
read username

echo -e "\n-----------------------------------------------------------------------\n"
echo -e "\nWould you like to install the newest versions of the support modules? (y/n)\n"
echo -e "If not, a stable, not updated, version of the modules will be installed"
read download_type

epics_dir=$(pwd)
mkdir support
chown $username support
cd support
support=$(pwd)

apt install re2c -y

edit_paths () {
	sed -i "/EPICS_BASE *=/c\EPICS_BASE=$epics_dir/epics-base" $1
	sed -i "/SUPPORT *=/c\SUPPORT=$support" $1
	sed -i "/MODULES *=/c\MODULES=$support" $1
	sed -i "/^SEQ *=/c\SEQ=$support/seq" $1
	sed -i "/SNCSEQ *=/c\SNCSEQ=$support/seq" $1
	sed -i "/ASYN *=/c\ASYN=$support/asyn" $1
	sed -i "/CALC *=/c\CALC=$support/calc" $1
	sed -i "/PCRE *=/c\PCRE=$support/pcre" $1
	sed -i "/SSCAN *=/c\SSCAN=$support/sscan" $1
	sed -i "/AUTOSAVE *=/c\AUTOSAVE=$support/autosave" $1
	sed -i "/BUSY *=/c\BUSY=$support/busy" $1
}

if [[ "$download_type" == "y" || "$download_type" == "Y" ]]
then
	# seq
	git clone https://github.com/ISISComputingGroup/EPICS-seq.git seq
	cd seq
	sed -i "/ISIS/c\# unnecessary line was deleted by VERA" configure/RELEASE
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# pcre
	git clone https://github.com/vera-univie/EPICS-pcre.git pcre
	cd pcre
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# sscan
	git clone https://github.com/epics-modules/sscan.git sscan
	cd sscan
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# calc
	git clone https://github.com/epics-modules/calc.git calc
	cd calc
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# asyn
	git clone https://github.com/epics-modules/asyn.git asyn
	cd asyn
	edit_paths configure/RELEASE
	sed -i "/TIRPC=YES/c\TIRPC=YES" configure/CONFIG_SITE
	chown $username ./
	make clean; make
	cd $support

	# streamd (Stream Device)
	git clone https://github.com/paulscherrerinstitute/StreamDevice.git streamd
	cd streamd
	rm GNUmakefile
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# memDisplay
	git clone https://github.com/paulscherrerinstitute/memDisplay.git memDisplay
	cd memDisplay
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# regDev
	git clone https://github.com/paulscherrerinstitute/regdev.git regDev
	cd regDev
	rm GNUmakefile
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# autosave
	git clone https://github.com/epics-modules/autosave.git autosave
	cd autosave
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

	# busy
	git clone https://github.com/epics-modules/busy.git busy
	cd busy
	edit_paths configure/RELEASE
	chown $username ./
	make clean; make
	cd $support

else
	git clone https://github.com/vera-univie/EPICS-support.git ./
	sed -i "/ISIS/c\# unnecessary line was deleted by VERA" seq/configure/RELEASE
	sed -i "/TIRPC=YES/c\TIRPC=YES" asyn/configure/CONFIG_SITE
	for d in ./*/ ; do 
		cd $d
		edit_paths configure/RELEASE
		chown $username ./
		make clean; make
		cd ../
	done
	sed -i "/ISIS/c\# unnecessary line was deleted by VERA" seq/configure/RELEASE
	sed -i "/TIRPC=YES/c\TIRPC=YES" asyn/configure/CONFIG_SITE
fi


