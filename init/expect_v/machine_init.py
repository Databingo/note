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
set record_server_ip 103.225.9.80

# --------------login-------------
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

# --------------sudo-------------
send "sudo su \\r"

# install ntpdate for datetime sync
# -------------------------------
send "command -v ntpdate || (yum -y clean all && yum -y distro-sync && yum -y update && yum -y install ntp ntpdate) || apt -y install ntp ntpdate || apt-get -y install ntp ntpdate \\r"

# sync net-time
# -------------------------------
send "ntpdate -u ntp3.aliyun.com \\r"

# update package manager
# -------------------------------
send "yum -y update || apt -y update || apt-get -y update \\r"

# install git
# -------------------------------
send "command -v git || yum -y install git || apt -y install git || apt-get -y install git \\r"
send "/usr/bin/git config --global user.email 'databingo@foxmail.com' \\r"
send "/usr/bin/git config --global user.name \\"today072from{machine_ip}\\" \\r"

# for add chinese file name ok
# -------------------------------
send "/usr/bin/git config --global core.quotepath false \\r"

# pull record.git
# ---------------------------------------------
send "mkdir -p /usr/local/projects/ \\r"
#send "rm -rf /usr/local/projects/record \\r"
send "cd /usr/local/projects/ \\r "
send "/usr/bin/git clone root@$record_server_ip:/usr/local/projects_git/record.git \\r"
expect {{
        "(yes/no)?" {{send "yes\\r"; exp_continue }}
        "password:" {{send "Im072port\\r"; exp_continue }}
        "already" {{send "echo ok\\r"; }}
        "已经存在" {{send "echo ok\\r"; }}
        "deltas" {{ puts "ok" }}
        }}
#puts "expect delta\\r"
#expect "delta"
expect {{
	 "delta" {{ puts "ok" }}
         "ok" {{ puts "ok" }}
       }}
#puts "get delta\\r"

# run system_prepare
# ---------------------------------------------
#send "nohup bash /usr/local/projects/record/init/system_prepare.sh > /tmp/system_prepare.log 2>&1 & \\r"
send "bash /usr/local/projects/record/init/system_prepare.sh \\r"
sleep 1
#expect "DONE"
puts "DONE"

# --------------exit-------------
send "exit \\r"
expect "exit"
send "exit \\r"
expect "usmshell"
send ":"
sleep 1
send "q\\r"
sleep 1
send "\\r"
expect eof
#interact
"""
#print(expect_script)

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

# make jumpin file
subprocess.call("python3 ./machine_jump.py", shell=True)
#input("make jumpin file")

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
    f_name = "{}.init".format(machine_host)
    with open(f_name, 'w') as f:
        f.write(script)
    os.system('chmod 755 {}'.format(f_name))
    subprocess.call("expect ./{}".format(f_name), shell=True)

