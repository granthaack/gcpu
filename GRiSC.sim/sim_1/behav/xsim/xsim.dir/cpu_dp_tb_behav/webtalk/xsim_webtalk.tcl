webtalk_init -webtalk_dir /home/grant/projects/gcpu/GRiSC.sim/sim_1/behav/xsim/xsim.dir/cpu_dp_tb_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Fri Jan 18 00:06:45 2019" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2018.2 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2258646" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "61f036b9-59f3-4a00-90ec-92c66a961917" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2140ffe8c7fc43c89f1feef02b48c9f9" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "150" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Debian" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Debian GNU/Linux 9.6 (stretch)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i5-4670K CPU @ 3.40GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "3799.682 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "1 us" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "0" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.01_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "114808_KB" -context "xsim\\usage"
webtalk_transmit -clientid 3374639554 -regid "" -xml /home/grant/projects/gcpu/GRiSC.sim/sim_1/behav/xsim/xsim.dir/cpu_dp_tb_behav/webtalk/usage_statistics_ext_xsim.xml -html /home/grant/projects/gcpu/GRiSC.sim/sim_1/behav/xsim/xsim.dir/cpu_dp_tb_behav/webtalk/usage_statistics_ext_xsim.html -wdm /home/grant/projects/gcpu/GRiSC.sim/sim_1/behav/xsim/xsim.dir/cpu_dp_tb_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
