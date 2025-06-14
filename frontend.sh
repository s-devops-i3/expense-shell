source common.sh

app_dir=/usr/share/nginx/html
component=frontend

Print_Headings "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?


Print_Headings "Copy expense configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
check_status $?

App_PreReq

Print_Headings "Re-Start Nginx"
systemctl restart nginx
check_status $?
