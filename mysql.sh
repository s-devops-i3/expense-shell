Print_Headings "Install mysql"
dnf install mysql-server -y &>>/tmp/expense.log
check_status $?

Print_Headings "Enable mysql"
systemctl enable mysqld &>>/tmp/expense.log
check_status $?

Print_Headings "Start mysql"
systemctl start mysqld &>>/tmp/expense.log
check_status $?

Print_Headings "Setup mysql password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log
check_status $?