dnf module disable nodejs -y &>>/tmp/expense.log
dnf module enable nodejs:20 -y &>>/tmp/expense.log

dnf install nodejs -y &>>/tmp/expense.log

cp backend.service /etc/systemd/system/backend.service

rm -rf /app

useradd expense &>>/tmp/expense.log
mkdir /app

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
cd /app
unzip /tmp/backend.zip &>>/tmp/expense.log
cd /app
npm install &>>/tmp/expense.log

systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
dnf install mysql -y &>>/tmp/expense.log

mysql -h 172.31.27.41 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log