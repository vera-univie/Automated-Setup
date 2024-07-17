# Automated Setup of EPICS and EtherCAT

## Prerequisites
You must have installed and built the Kernel from source, which is needed for EtherCAT Master

(see 'Build_Kernel.txt')


## EtherCAT Master
To install the EtherCAT Master, bring the 'ethercat_setup.sh' file into the folder where you want to have it installed (such as ~/EtherLAB/).
Then execute the file using the following commands:
> sudo chmod u+x ethercat_setup.sh
>
> sudo ./ethercat_setup.sh

Now follow follow the instructions from the terminal, if any are given.

## EPICS Base
To install EPICS Base, execute the epics-base_setup.sh file the same way as before, and leaving it in your EPICS folder.
> sudo chmod u+x epics-base_setup.sh
>
> sudo ./epics-base_setup.sh

## EPICS support
To install EPICS support, execute the epics-support_setup.sh file while it is in your EPICS folder.
> sudo chmod u+x epics-support_setup.sh
>
> sudo ./epics-base_setup.sh

The executable requires two pieces of input from the user. First, the username for which EPICS support
should be installed, and second, confirmation if the script should download the newest versions of
the different support modules, or if it should download a stable version from our github.

## EtherCAT for EPICS
To install EtherCAT for EPICS, execute the epics-ethercat_setup.sh file, which must be in your EPICS folder.
> sudo chmod u+x epics-ethercat_setup.sh
>
> sudo ./epics-ethercat_setup.sh

The executable requires no additional input from the user once it has been started.

# Using an IOC to control EtherCAT modules
In our case, we are using typical Beckhoff modules. You can use the scanTest IOC as an example. There are already modules entered there, so replace them with the ones you want. Follow these steps to do so:

Navigate to the /etc folder of your IOC (e.g. ~/EPICS/ethercat/iocs/scanTest/etc)

Edit the chain.xml file to add your components with their values (you can see these using the EtherCAT Master in your terminal by typing /opt/etherlab/bin/ethercat slaves -v), such as:
> \<chain>
> 
> \<device type_name="EK1100" revision="0x00110000" position="0" name="COUPLER_00" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="1" name="DO_00" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="2" name="DO_01" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="3" name="DO_02" />
> 
> \</chain>

You can freely choose the name of these devices, however the type_name, revision and position must be correct. The position is the second number when you look up your slaves from the ethercat master (so 0:2 -> position="2")

Check in ~/EPICS/ethercat/db if the template for your component is available. If not, do this:
> cd ~/EPICS/ethercat/etc/scripts
>
> python3 maketemplate.py -b ../xml/ -d EK1100 -r 0x00100000 -o ../../db/EK1100.template

In this command, -b is the folder with the information about all of the components, -d is the name of your component, -d is the revision number, and -o is the target destination. In this case you must replace -d with the correct component name, -r with the correct revision number, and write the correct component name for the .template file in -o

To see your revision number, go into root and call these commands:
> /etc/init.d/ethercat start
> 
> /opt/etherlab/bin/ethercat slaves -v

Now go back to the iocs/scanTest/etc folder, and call
> python3 ../../../etc/scripts/expandChain.py chain.xml > scanner.xml

Finally, go back to the top IOC folder, and edit the st.cmd file to include the dbLoadRecords() calls for your components.
> dbLoadRecords("../../db/MASTER.template", "DEVICE=VERA:0,PORT=MASTER0,SCAN=I/O Intr")
>
> dbLoadRecords("../../db/EK1100.template", "DEVICE=VERA:1,PORT=COUPLER_00,SCAN=I/O Intr")

You can freely change the values for DEVICE and for PORT - DEVICE is the name with which you will call the device, and PORT is the name that you gave it earlier in the chain.xml file.

## Execution
Open a terminal, enter root (with 'su -'), and start your EtherCAT Master (as seen above)

Open another terminal, navigate to ~/EPICS/ethercat/iocs/scanTest/etc and start the scanner with the following command:
> sudo ../../../bin/linux-x86_64/scanner scanner.xml "/tmp/scan1"

Finally, open another terminal and navigate to the top folder of your ioc, e.g. ~/EPICS/ethercat/iocs/scanTest/ and execute following command:
> ./st.cmd

## Further information
For further information, see the step-by-step transcript of each step we took to manually set these files up, or contact one of People who made this GitHub


