
################################################################
# This is a generated script based on design: dvi2vga
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source dvi2vga_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name dvi2vga

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

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 DDC ]

  # Create ports
  set TMDS_Clk_n [ create_bd_port -dir I TMDS_Clk_n ]
  set TMDS_Clk_p [ create_bd_port -dir I TMDS_Clk_p ]
  set TMDS_Data_n [ create_bd_port -dir I -from 2 -to 0 TMDS_Data_n ]
  set TMDS_Data_p [ create_bd_port -dir I -from 2 -to 0 TMDS_Data_p ]
  set clk125 [ create_bd_port -dir I -type clk clk125 ]
  set_property -dict [ list CONFIG.FREQ_HZ {125000000} CONFIG.PHASE {0.000}  ] $clk125
  set hdmi_hpd [ create_bd_port -dir O -from 0 -to 0 hdmi_hpd ]
  set hdmi_out_en [ create_bd_port -dir O -from 0 -to 0 hdmi_out_en ]
  set sw0 [ create_bd_port -dir I -from 0 -to 0 -type data sw0 ]
  set_property -dict [ list CONFIG.LAYERED_METADATA {xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}  ] $sw0
  set vga_pBlue [ create_bd_port -dir O -from 4 -to 0 vga_pBlue ]
  set vga_pGreen [ create_bd_port -dir O -from 5 -to 0 vga_pGreen ]
  set vga_pHSync [ create_bd_port -dir O vga_pHSync ]
  set vga_pRed [ create_bd_port -dir O -from 4 -to 0 vga_pRed ]
  set vga_pVSync [ create_bd_port -dir O vga_pVSync ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0 ]
  set_property -dict [ list CONFIG.CLKIN1_JITTER_PS {80.0} \
CONFIG.CLKOUT1_DRIVES {BUFG} CONFIG.CLKOUT1_JITTER {233.189} \
CONFIG.CLKOUT1_PHASE_ERROR {265.359} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
CONFIG.CLKOUT2_DRIVES {BUFG} CONFIG.CLKOUT2_JITTER {265.121} \
CONFIG.CLKOUT2_PHASE_ERROR {265.359} CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_DRIVES {BUFG} CONFIG.CLKOUT4_DRIVES {BUFG} \
CONFIG.CLKOUT5_DRIVES {BUFG} CONFIG.CLKOUT6_DRIVES {BUFG} \
CONFIG.CLKOUT7_DRIVES {BUFG} CONFIG.MMCM_CLKFBOUT_MULT_F {32} \
CONFIG.MMCM_CLKIN1_PERIOD {8.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {4} \
CONFIG.MMCM_CLKOUT1_DIVIDE {8} CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {5} CONFIG.NUM_OUT_CLKS {2} \
CONFIG.PRIMITIVE {PLL} CONFIG.PRIM_IN_FREQ {125.00} \
 ] $clk_wiz_0

  # Create instance: dvi2rgb_0, and set properties
  set dvi2rgb_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:dvi2rgb:1.5 dvi2rgb_0 ]
  set_property -dict [ list CONFIG.kClkRange {2} CONFIG.kRstActiveHigh {true}  ] $dvi2rgb_0

  # Create instance: lap_filter_axis_0, and set properties
  set lap_filter_axis_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:lap_filter_axis:1.0 lap_filter_axis_0 ]

  # Create instance: rgb2vga_0, and set properties
  set rgb2vga_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2vga:1.0 rgb2vga_0 ]

  # Create instance: synchro_PixClk, and set properties
  set synchro_PixClk [ create_bd_cell -type ip -vlnv xilinx.com:user:synchro:1.0 synchro_PixClk ]

  # Create instance: synchro_aclk, and set properties
  set synchro_aclk [ create_bd_cell -type ip -vlnv xilinx.com:user:synchro:1.0 synchro_aclk ]

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:3.0 v_axi4s_vid_out_0 ]

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list CONFIG.GEN_F0_VBLANK_HEND {1280} \
CONFIG.GEN_F0_VBLANK_HSTART {1280} CONFIG.GEN_F0_VFRAME_SIZE {750} \
CONFIG.GEN_F0_VSYNC_HEND {1280} CONFIG.GEN_F0_VSYNC_HSTART {1280} \
CONFIG.GEN_F0_VSYNC_VEND {729} CONFIG.GEN_F0_VSYNC_VSTART {724} \
CONFIG.GEN_F1_VBLANK_HEND {1280} CONFIG.GEN_F1_VBLANK_HSTART {1280} \
CONFIG.GEN_F1_VFRAME_SIZE {750} CONFIG.GEN_F1_VSYNC_HEND {1280} \
CONFIG.GEN_F1_VSYNC_HSTART {1280} CONFIG.GEN_F1_VSYNC_VEND {729} \
CONFIG.GEN_F1_VSYNC_VSTART {724} CONFIG.GEN_HACTIVE_SIZE {1280} \
CONFIG.GEN_HFRAME_SIZE {1650} CONFIG.GEN_HSYNC_END {1430} \
CONFIG.GEN_HSYNC_START {1390} CONFIG.GEN_VACTIVE_SIZE {720} \
CONFIG.HAS_AXI4_LITE {false} CONFIG.VIDEO_MODE {720p} \
CONFIG.max_clocks_per_line {4096} CONFIG.max_lines_per_frame {4096} \
 ] $v_tc_0

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:3.0 v_vid_in_axi4s_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list CONFIG.CONST_VAL {0} CONFIG.CONST_WIDTH {8}  ] $xlconstant_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list CONFIG.DIN_FROM {23} CONFIG.DOUT_WIDTH {24}  ] $xlslice_0

  # Create interface connections
  connect_bd_intf_net -intf_net dvi2rgb_0_DDC [get_bd_intf_ports DDC] [get_bd_intf_pins dvi2rgb_0/DDC]
  connect_bd_intf_net -intf_net dvi2rgb_0_RGB [get_bd_intf_pins dvi2rgb_0/RGB] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins rgb2vga_0/vid_in] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_vtiming_out [get_bd_intf_pins v_tc_0/vtiming_in] [get_bd_intf_pins v_vid_in_axi4s_0/vtiming_out]

  # Create port connections
  connect_bd_net -net TMDS_Clk_n_1 [get_bd_ports TMDS_Clk_n] [get_bd_pins dvi2rgb_0/TMDS_Clk_n]
  connect_bd_net -net TMDS_Clk_p_1 [get_bd_ports TMDS_Clk_p] [get_bd_pins dvi2rgb_0/TMDS_Clk_p]
  connect_bd_net -net TMDS_Data_n_1 [get_bd_ports TMDS_Data_n] [get_bd_pins dvi2rgb_0/TMDS_Data_n]
  connect_bd_net -net TMDS_Data_p_1 [get_bd_ports TMDS_Data_p] [get_bd_pins dvi2rgb_0/TMDS_Data_p]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins dvi2rgb_0/RefClk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins lap_filter_axis_0/ap_clk] [get_bd_pins synchro_aclk/clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net clock_rtl_1 [get_bd_ports clk125] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net dvi2rgb_0_PixelClk [get_bd_pins dvi2rgb_0/PixelClk] [get_bd_pins rgb2vga_0/PixelClk] [get_bd_pins synchro_PixClk/clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net dvi2rgb_0_aPixelClkLckd [get_bd_pins dvi2rgb_0/aPixelClkLckd] [get_bd_pins synchro_PixClk/sync_in] [get_bd_pins synchro_aclk/sync_in]
  connect_bd_net -net dvi2rgb_0_hdmi_hpd [get_bd_ports hdmi_hpd] [get_bd_pins dvi2rgb_0/hdmi_hpd]
  connect_bd_net -net dvi2rgb_0_hdmi_out_en [get_bd_ports hdmi_out_en] [get_bd_pins dvi2rgb_0/hdmi_out_en]
  connect_bd_net -net lap_fil_enable_V_1 [get_bd_ports sw0] [get_bd_pins lap_filter_axis_0/lap_fil_enable_V]
  connect_bd_net -net lap_filter_axis_0_ins_TREADY [get_bd_pins lap_filter_axis_0/ins_TREADY] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tready]
  connect_bd_net -net lap_filter_axis_0_outs_TDATA [get_bd_pins lap_filter_axis_0/outs_TDATA] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net lap_filter_axis_0_outs_TLAST [get_bd_pins lap_filter_axis_0/outs_TLAST] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tlast]
  connect_bd_net -net lap_filter_axis_0_outs_TUSER [get_bd_pins lap_filter_axis_0/outs_TUSER] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tuser]
  connect_bd_net -net lap_filter_axis_0_outs_TVALID [get_bd_pins lap_filter_axis_0/outs_TVALID] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tvalid]
  connect_bd_net -net rgb2vga_0_vga_pBlue [get_bd_ports vga_pBlue] [get_bd_pins rgb2vga_0/vga_pBlue]
  connect_bd_net -net rgb2vga_0_vga_pGreen [get_bd_ports vga_pGreen] [get_bd_pins rgb2vga_0/vga_pGreen]
  connect_bd_net -net rgb2vga_0_vga_pHSync [get_bd_ports vga_pHSync] [get_bd_pins rgb2vga_0/vga_pHSync]
  connect_bd_net -net rgb2vga_0_vga_pRed [get_bd_ports vga_pRed] [get_bd_pins rgb2vga_0/vga_pRed]
  connect_bd_net -net rgb2vga_0_vga_pVSync [get_bd_ports vga_pVSync] [get_bd_pins rgb2vga_0/vga_pVSync]
  connect_bd_net -net synchro_0_sync_out [get_bd_pins lap_filter_axis_0/ap_rst_n] [get_bd_pins synchro_aclk/sync_out] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
  connect_bd_net -net synchro_1_sync_out [get_bd_pins synchro_PixClk/sync_out] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net v_axi4s_vid_out_0_s_axis_video_tready [get_bd_pins lap_filter_axis_0/outs_TREADY] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tready]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tdata [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tdata] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tlast [get_bd_pins lap_filter_axis_0/ins_TLAST] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tlast]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tuser [get_bd_pins lap_filter_axis_0/ins_TUSER] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tuser]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tvalid [get_bd_pins lap_filter_axis_0/ins_TVALID] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tvalid]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins lap_filter_axis_0/ins_TDATA] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tdata] [get_bd_pins xlslice_0/Dout]

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


