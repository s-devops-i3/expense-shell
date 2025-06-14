source common.sh

Print_Headings "Install Nginx"
dnf install nginx -y &>>$LOG
check_status $?

Print_Headings "Start Nginx"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG
check_status $?

Print_Headings "Copy expense configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
check_status $?

Print_Headings "Remove Old contents"
rm -rf /usr/share/nginx/html/*
check_status $?

Print_Headings "Download App contents"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
check_status $?

Print_Headings "Extract app contents"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOG
check_status $?

Print_Headings "Re-Start Nginx"
systemctl restart nginx
check_status $?
