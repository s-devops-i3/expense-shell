mysql_root_password=$1

echo "Disable Nodejs"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo "Enable nodejs V20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo "Install nodejs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo "Copy Service file"
cp backend.service /etc/systemd/system/backend.service
echo $?

echo "Remove old content"
rm -rf /app
echo $?

echo "Adding expense user"
useradd expense &>>/tmp/expense.log
echo $?

echo "Creating App dir"
mkdir /app
echo $?

echo "Downloading content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

cd /app
echo $?

echo "Extracting app contents"
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

cd /app
echo $?

echo "Installing dependencies"
npm install &>>/tmp/expense.log
echo $?

echo "Starting backend"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?
echo "install MySQL client"
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo "Load Schema"
mysql -h 172.31.27.41 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?

