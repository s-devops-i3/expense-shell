source common.sh

mysql_root_password=$1

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

Print_Headings "Remove old content"
rm -rf /app
check_status $?

Print_Headings "Adding expense user"
useradd expense &>>$LOG
check_status $?

Print_Headings "Creating App dir"
mkdir /app
check_status $?

Print_Headings "Downloading content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
check_status $?

cd /app
check_status $?

Print_Headings "Extracting app contents"
unzip /tmp/backend.zip &>>$LOG
check_status $?

cd /app
check_status $?

Print_Headings "Installing dependencies"
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

