#cloud-boothook
#!/bin/bash
touch /tmp/i_have_user_data_new
sudo amazon-linux-extras install nginx1.12 -y
systemctl start nginx
systemctl status nginx > /tmp/status-testinho

