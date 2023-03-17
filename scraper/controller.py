import boto3
from niftystocks import ns
import requests as rq
import paramiko

s3 = boto3.Session(profile_name="assemblage",
                   region_name="ap-south-1").client("s3")

dynamodb = boto3.Session(profile_name="assemblage",
                         region_name="ap-south-1").resource("dynamodb")

ec2 = boto3.Session(profile_name="assemblage",
                    region_name="ap-south-1").client("ec2")

nifty100 = ns.get_nifty100()

for i in nifty100:
    response = ec2.run_instances(ImageId='ami-08338e340ebe63a3a', InstanceType='t2.small',
                                 SecurityGroupIds=['sg-095d8a760e84cabab'], SubnetId='subnet-b6daa3fa')
    instance_id = response['Instances'][0]['InstanceId']
    ec2_instance = ec2.Instance(instance_id)
    ec2_instance.wait_until_running()
    ip_address = ec2_instance.public_ip_address
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(ip_address, username='ubuntu', key_filename='glitch.pem')
    stdin, stdout, stderr = ssh.exec_command('cd Glitch-2023&&git pull')
    