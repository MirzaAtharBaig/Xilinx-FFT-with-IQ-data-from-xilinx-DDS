# Xilinx-FFT-with-IQ-data-from-xilinx-DDS
This project implements Fast Fourier Transform (FFT) of IQ data using xilinx FFT 9.0 and xilinx DDS compiler cores. 
# How to use it
1-Download/clone the project.

2-Open Vivado IDE in local directory which contains the downloaded project
      Open Vivado IDE
      Change the work directory of Vivado thorugh tcl console. type "cd < address of downloaded project folder >".
     
3-Now go to tool->run tcl script
      This will build the project and create the block design with default settings.

The project takes the LVDS 200MHz clock from Xilinx VC707 board and shows the output on ILAs.You can choose where to get input clock for the whole design. The outputs of the projects are shown using two ILA. One for DDS compiler and other for FFT core.
