source common.sh

Print_Headings "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log

Print_Headings "Start Nginx"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log

Print_Headings "Copy expense configuration"
cp expense.conf /etc/nginx/default.d/expense.conf

Print_Headings "Remove Old contents"
rm -rf /usr/share/nginx/html/*

Print_Headings "Download App contents"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log

Print_Headings "Extract app contents"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/expense.log

Print_Headings "Re-Start Nginx"
systemctl restart nginx

