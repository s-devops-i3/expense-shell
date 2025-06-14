source common.sh

mysql_root_password=$1
input_validation ${mysql_root_password}

Print_Headings "Install mysql"
dnf install mysql-server -y &>>/$LOG
check_status $?

Print_Headings "Enable mysql"
systemctl enable mysqld &>>/$LOG
check_status $?

Print_Headings "Start mysql"
systemctl start mysqld &>>/$LOG
check_status $?

Print_Headings "Setup mysql password"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>/$LOG
check_status $?