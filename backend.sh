mysql_root_password=$1

Print_Headings() {
  echo $1
  echo "############ $1 ##########" &>>/tmp/expense.log
}
Print_Headings "Disable Nodejs"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

Print_Headings "Enable nodejs V20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

Print_Headings "Install nodejs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

Print_Headings "Copy Service file"
cp backend.service /etc/systemd/system/backend.service
echo $?

Print_Headings "Remove old content"
rm -rf /app
echo $?

Print_Headings "Adding expense user"
useradd expense &>>/tmp/expense.log
echo $?

Print_Headings "Creating App dir"
mkdir /app
echo $?

Print_Headings "Downloading content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

cd /app
echo $?

Print_Headings "Extracting app contents"
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

cd /app
echo $?

Print_Headings "Installing dependencies"
npm install &>>/tmp/expense.log
echo $?

Print_Headings "Starting backend"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?
Print_Headings "install MySQL client"
dnf install mysql -y &>>/tmp/expense.log
echo $?

Print_Headings "Load Schema"
mysql -h 172.31.27.41 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?

