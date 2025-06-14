source common.sh

mysql_root_password=$1
app_dir=/app
component=backend

input_validation
Print_Headings "Disable Nodejs"
dnf module disable nodejs -y &>>$LOG
check_status $?

Print_Headings "Enable nodejs V20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

Print_Headings "Install nodejs"
dnf install nodejs -y &>>$LOG
check_status $?

Print_Headings "Copy Service file"
cp backend.service /etc/systemd/system/backend.service
check_status $?

Print_Headings "Adding expense user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense
fi
check_status $?

App_PreReq


Print_Headings "Download Nodejs dependencies"
cd /app
npm install &>>$LOG
check_status $?

Print_Headings "Starting backend"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

Print_Headings "install MySQL client"
dnf install mysql -y &>>$LOG
check_status $?

Print_Headings "Load Schema"
mysql -h 172.31.27.41 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
check_status $?

