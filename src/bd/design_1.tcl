
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# counter_fft

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1761-2
   set_property BOARD_PART xilinx.com:vc707:part0:1.3 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:c_addsub:12.0\
xilinx.com:ip:dds_compiler:6.0\
xilinx.com:ip:ila:6.2\
xilinx.com:ip:mult_gen:12.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:xfft:9.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
counter_fft\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set sys_diff_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_diff_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys_diff_clock

  # Create ports

  # Create instance: c_addsub_0, and set properties
  set c_addsub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_0 ]
  set_property -dict [ list \
   CONFIG.A_Type {Signed} \
   CONFIG.A_Width {33} \
   CONFIG.B_Type {Signed} \
   CONFIG.B_Value {000000000000000000000000000000000} \
   CONFIG.B_Width {33} \
   CONFIG.CE {false} \
   CONFIG.C_In {false} \
   CONFIG.Latency {3} \
   CONFIG.Latency_Configuration {Automatic} \
   CONFIG.Out_Width {34} \
 ] $c_addsub_0

  # Create instance: counter_fft_0, and set properties
  set block_name counter_fft
  set block_cell_name counter_fft_0
  if { [catch {set counter_fft_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $counter_fft_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dds_compiler_0, and set properties
  set dds_compiler_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dds_compiler:6.0 dds_compiler_0 ]
  set_property -dict [ list \
   CONFIG.DATA_Has_TLAST {Not_Required} \
   CONFIG.DDS_Clock_Rate {200} \
   CONFIG.Frequency_Resolution {0.4} \
   CONFIG.Has_Phase_Out {false} \
   CONFIG.Has_TREADY {true} \
   CONFIG.Latency {13} \
   CONFIG.Latency_Configuration {Auto} \
   CONFIG.M_DATA_Has_TUSER {Not_Required} \
   CONFIG.Noise_Shaping {None} \
   CONFIG.OUTPUT_FORM {Twos_Complement} \
   CONFIG.Output_Frequency1 {0} \
   CONFIG.Output_Selection {Sine_and_Cosine} \
   CONFIG.Output_Width {16} \
   CONFIG.PINC1 {0} \
   CONFIG.Parameter_Entry {Hardware_Parameters} \
   CONFIG.PartsPresent {Phase_Generator_and_SIN_COS_LUT} \
   CONFIG.Phase_Increment {Programmable} \
   CONFIG.Phase_Width {32} \
   CONFIG.Phase_offset {None} \
   CONFIG.S_PHASE_Has_TUSER {Not_Required} \
 ] $dds_compiler_0

  # Create instance: ila_DDS, and set properties
  set ila_DDS [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_DDS ]
  set_property -dict [ list \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {3} \
   CONFIG.C_PROBE0_WIDTH {32} \
 ] $ila_DDS

  # Create instance: ila_FFT, and set properties
  set ila_FFT [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_FFT ]
  set_property -dict [ list \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {13} \
   CONFIG.C_PROBE12_WIDTH {16} \
   CONFIG.C_PROBE8_WIDTH {32} \
   CONFIG.C_PROBE9_WIDTH {16} \
 ] $ila_FFT

  # Create instance: mult_gen_Img, and set properties
  set mult_gen_Img [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_Img ]
  set_property -dict [ list \
   CONFIG.OutputWidthHigh {32} \
   CONFIG.PortAType {Signed} \
   CONFIG.PortAWidth {16} \
   CONFIG.PortBType {Signed} \
   CONFIG.PortBWidth {16} \
   CONFIG.Use_Custom_Output_Width {true} \
 ] $mult_gen_Img

  # Create instance: mult_gen_Real, and set properties
  set mult_gen_Real [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_Real ]
  set_property -dict [ list \
   CONFIG.OutputWidthHigh {32} \
   CONFIG.PortAType {Signed} \
   CONFIG.PortAWidth {16} \
   CONFIG.PortBType {Signed} \
   CONFIG.PortBWidth {16} \
   CONFIG.Use_Custom_Output_Width {true} \
 ] $mult_gen_Real

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.DIFF_CLK_IN_BOARD_INTERFACE {sys_diff_clock} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $util_ds_buf_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
   CONFIG.C_NUM_PROBE_OUT {1} \
   CONFIG.C_PROBE_OUT0_WIDTH {32} \
 ] $vio_0

  # Create instance: xfft_0, and set properties
  set xfft_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.0 xfft_0 ]
  set_property -dict [ list \
   CONFIG.cyclic_prefix_insertion {true} \
   CONFIG.data_format {fixed_point} \
   CONFIG.implementation_options {automatically_select} \
   CONFIG.input_width {16} \
   CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {7} \
   CONFIG.output_ordering {natural_order} \
   CONFIG.ovflo {false} \
   CONFIG.rounding_modes {convergent_rounding} \
   CONFIG.scaling_options {scaled} \
   CONFIG.target_clock_frequency {200} \
   CONFIG.target_data_throughput {200} \
   CONFIG.transform_length {16384} \
   CONFIG.xk_index {true} \
 ] $xfft_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {00000000} \
   CONFIG.CONST_WIDTH {16} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {00000000} \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_3

  # Create instance: xlslice_Img, and set properties
  set xlslice_Img [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_Img ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {32} \
   CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_Img

  # Create instance: xlslice_Real, and set properties
  set xlslice_Real [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_Real ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {32} \
   CONFIG.DOUT_WIDTH {16} \
 ] $xlslice_Real

  # Create interface connections
  connect_bd_intf_net -intf_net sys_diff_clock_1 [get_bd_intf_ports sys_diff_clock] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]

  # Create port connections
  connect_bd_net -net c_addsub_0_S [get_bd_pins c_addsub_0/S] [get_bd_pins ila_FFT/probe12]
  connect_bd_net -net counter_fft_0_cntr_FFT_tlast [get_bd_pins counter_fft_0/cntr_FFT_tlast] [get_bd_pins xfft_0/s_axis_data_tlast]
  connect_bd_net -net dds_compiler_0_m_axis_data_tdata [get_bd_pins dds_compiler_0/m_axis_data_tdata] [get_bd_pins ila_DDS/probe0] [get_bd_pins xfft_0/s_axis_data_tdata]
  connect_bd_net -net dds_compiler_0_m_axis_data_tvalid [get_bd_pins dds_compiler_0/m_axis_data_tvalid] [get_bd_pins ila_DDS/probe2] [get_bd_pins xfft_0/s_axis_data_tvalid]
  connect_bd_net -net dds_compiler_0_s_axis_config_tready [get_bd_pins dds_compiler_0/s_axis_config_tready] [get_bd_pins dds_compiler_0/s_axis_config_tvalid]
  connect_bd_net -net mult_gen_Img_P [get_bd_pins c_addsub_0/B] [get_bd_pins mult_gen_Img/P]
  connect_bd_net -net mult_gen_Real_P [get_bd_pins c_addsub_0/A] [get_bd_pins mult_gen_Real/P]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins c_addsub_0/CLK] [get_bd_pins counter_fft_0/clk_cntr] [get_bd_pins dds_compiler_0/aclk] [get_bd_pins ila_DDS/clk] [get_bd_pins ila_FFT/clk] [get_bd_pins mult_gen_Img/CLK] [get_bd_pins mult_gen_Real/CLK] [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins vio_0/clk] [get_bd_pins xfft_0/aclk]
  connect_bd_net -net vio_0_probe_out0 [get_bd_pins dds_compiler_0/s_axis_config_tdata] [get_bd_pins vio_0/probe_out0]
  connect_bd_net -net xfft_0_event_data_in_channel_halt [get_bd_pins ila_FFT/probe3] [get_bd_pins xfft_0/event_data_in_channel_halt]
  connect_bd_net -net xfft_0_event_data_out_channel_halt [get_bd_pins ila_FFT/probe2] [get_bd_pins xfft_0/event_data_out_channel_halt]
  connect_bd_net -net xfft_0_event_frame_started [get_bd_pins ila_FFT/probe7] [get_bd_pins xfft_0/event_frame_started]
  connect_bd_net -net xfft_0_event_status_channel_halt [get_bd_pins ila_FFT/probe4] [get_bd_pins xfft_0/event_status_channel_halt]
  connect_bd_net -net xfft_0_event_tlast_missing [get_bd_pins ila_FFT/probe5] [get_bd_pins xfft_0/event_tlast_missing]
  connect_bd_net -net xfft_0_event_tlast_unexpected [get_bd_pins ila_FFT/probe6] [get_bd_pins xfft_0/event_tlast_unexpected]
  connect_bd_net -net xfft_0_m_axis_data_tdata [get_bd_pins ila_FFT/probe8] [get_bd_pins xfft_0/m_axis_data_tdata] [get_bd_pins xlslice_Img/Din] [get_bd_pins xlslice_Real/Din]
  connect_bd_net -net xfft_0_m_axis_data_tlast [get_bd_pins ila_FFT/probe11] [get_bd_pins xfft_0/m_axis_data_tlast]
  connect_bd_net -net xfft_0_m_axis_data_tuser [get_bd_pins ila_FFT/probe9] [get_bd_pins xfft_0/m_axis_data_tuser]
  connect_bd_net -net xfft_0_m_axis_data_tvalid [get_bd_pins ila_FFT/probe10] [get_bd_pins xfft_0/m_axis_data_tvalid]
  connect_bd_net -net xfft_0_s_axis_config_tready [get_bd_pins ila_FFT/probe0] [get_bd_pins xfft_0/m_axis_data_tready] [get_bd_pins xfft_0/s_axis_config_tready]
  connect_bd_net -net xfft_0_s_axis_data_tready [get_bd_pins dds_compiler_0/m_axis_data_tready] [get_bd_pins ila_DDS/probe1] [get_bd_pins ila_FFT/probe1] [get_bd_pins xfft_0/s_axis_data_tready]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xfft_0/s_axis_config_tdata] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins xfft_0/s_axis_config_tvalid] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlslice_Img_Dout [get_bd_pins mult_gen_Img/A] [get_bd_pins mult_gen_Img/B] [get_bd_pins xlslice_Img/Dout]
  connect_bd_net -net xlslice_Real_Dout [get_bd_pins mult_gen_Real/A] [get_bd_pins mult_gen_Real/B] [get_bd_pins xlslice_Real/Dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


