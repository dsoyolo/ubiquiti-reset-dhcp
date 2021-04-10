import base64
import paramiko

import credentials

router = '192.168.2.1'
username = credentials.login['username']
password = credentials.login['password']

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
    client.connect(router, username=username, password=password)
except:
    print("[!] Cannot connect to the router")
    exit()

# read the BASH script content from the file
bash_script = open('reset-dhcp.sh').read()
# execute the BASH script
stdin, stdout, stderr = client.exec_command(bash_script)
# read the standard output and print it
print(stdout.read().decode())
# print errors if there are any
err = stderr.read().decode()
if err:
    print(err)

client.close()