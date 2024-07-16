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
> sudo chmod u+x epics-base_setup.sh
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

## Further information
For further information, see the step-by-step transcript of each step we took to manually set these files up, or contact one of People who made this GitHub


