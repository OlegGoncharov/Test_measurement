import queue
import json
import pandas as pd
import matplotlib.pyplot as plt
import math
import scipy.io as sio
import numpy as np
from rtls_util import RtlsUtil, RtlsUtilLoggingLevel, RtlsUtilException
from itertools import groupby

logging_file = "log.txt"
rtlsUtil = RtlsUtil(logging_file, RtlsUtilLoggingLevel.ALL)

devices = [
    {"com_port": "COM73", "baud_rate": 460800, "name": "CC26x2 Master"},
    {"com_port": "COM102", "baud_rate": 460800, "name": "CC26x2 Passive"}
]
## Setup devices
master_node, passive_nodes, all_nodes = rtlsUtil.set_devices(devices)
rtlsUtil.reset_devices()
print("Devices Reset")
try:
    scan_results = rtlsUtil.scan(15)
except:
    print("Slave не обнаружен. Запустите программу снова")
    exit()
rtlsUtil.ble_connect(scan_results[0], 100)
print("Connection Success")    



end_loop_read = 3000



aoa_params = {
                "aoa_run_mode": "AOA_MODE_ANGLE",  ## AOA_MODE_ANGLE, AOA_MODE_PAIR_ANGLES, AOA_MODE_RAW
                "aoa_cc2640r2": {
                "aoa_cte_scan_ovs": 4,
                "aoa_cte_offset": 4,
                "aoa_cte_length": 20,
                "aoa_sampling_control": int('0x00', 16),
            },
                "aoa_cc26x2": {
                "aoa_slot_durations": 1,
                "aoa_sample_rate": 1,
                "aoa_sample_size": 1,
                "aoa_sampling_control": int('0x10', 16),
                ## bit 0   - 0x00 - default filtering, 0x01 - RAW_RF no filtering,
                ## bit 4,5 - default: 0x10 - ONLY_ANT_1, optional: 0x20 - ONLY_ANT_2
                "aoa_sampling_enable": 1,
                "aoa_pattern_len": 2,
                "aoa_ant_pattern": [0, 1]
    }
}
try:
    rtlsUtil.aoa_set_params(aoa_params)
except:
    print("Не удалось установить параметры конфигурации. Запустите снова")
print("AOA Paramas Set")

rtlsUtil.aoa_start(cte_length=20, cte_interval=1)
print("AOA Started")

i_1 = 0
i_chan = 0
i_chan_list = list()
angle_arr_1= list()
rssi_arr_1 = list()
channel1_list = list()

fig= plt.figure()
while i_1<=end_loop_read:
    try:
        data = rtlsUtil.aoa_results_queue.get(block=True, timeout=0.5)
        i_1 = i_1 + 1
        channel1_list.append(data['payload'].channel)
        if i_1>1 and channel1_list[i_1-1]==channel1_list[1]:
            i_chan = i_chan + 1
            i_chan_list.append(i_chan)
            angle_arr_1.append(data['payload'].angle)
            rssi_arr_1.append(data['payload'].rssi)
            plt.plot(i_chan_list,angle_arr_1,color = 'blue')
            plt.pause(1/460800)
            if i_chan > 100:
                plt.xlim(i_chan_list[i_chan-100],_chan_list[i_chan-1])
    except queue.Empty:
        continue

sio.savemat('Ant1_one_antennas.mat', {'alpha':angle_arr_1, 'rssi_1':rssi_arr_1, 'channel1':channel1_list[1]})
rtlsUtil.aoa_stop()
if rtlsUtil.ble_connected:
    rtlsUtil.ble_disconnect()
    print("Master Disconnected")

rtlsUtil.done()
print("Done")

