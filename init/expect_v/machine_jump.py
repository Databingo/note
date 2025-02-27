import yaml
import os
import time
import logging
import subprocess
from pprint import pprint
from pprint import pformat

# DEBUG > INFO > WARNING > ERROR > CRITICAL
logging.basicConfig(format='%(levelname)-s [%(filename)s:%(lineno)d] %(message)s', level=logging.DEBUG)

expect_script= """#!/usr/bin/expect -f -d
set timeout -1
spawn ssh  -p {jumpserver_ssh_port} {jumpserver_user}@{jumpserver_ip}
expect "password:"
send "{jumpserver_pw}\\r"
expect "usmshell"
send "/"
sleep 1
send "{machine_ip}\\r"
sleep 1
send "\\r"
sleep 1
send "cd / \\r"
sleep 1
send "ls \\r"
send "sudo su \\r"
send "cd /usr/local/projects/ \\r"
interact
"""




print(expect_script)

with open('./ip.yaml') as f:
    ip_info = yaml.safe_load(f)

pprint(ip_info)
jumpserver = ip_info['hosts']['jumpserver']
jumpserver_ip = jumpserver['ip']
jumpserver_ssh_port = jumpserver['ssh_port']
jumpserver_pw = jumpserver['pw']
jumpserver_user = jumpserver['user']
logging.info('jumpserver ip: %s, password: %s', jumpserver_ip, jumpserver_pw)

machines = ip_info['hosts']['machines']
for machine in machines[:]:
    logging.info('ip: %s', machine['ip'])
    machine_ip = machine['ip']
    machine_host = machine['host']
    script = expect_script.format(jumpserver_ssh_port=jumpserver_ssh_port, 
                                  jumpserver_user=jumpserver_user,
                                  jumpserver_ip=jumpserver_ip,
                                  jumpserver_pw=jumpserver_pw,
                                  machine_ip=machine_ip)
    logging.info(script)
    f_name = "{}.jump".format(machine_host)
    with open(f_name, 'w') as f:
        f.write(script)
    os.system('chmod 755 {}'.format(f_name))
   #subprocess.call("expect ./{}".format(f_name), shell=True)
