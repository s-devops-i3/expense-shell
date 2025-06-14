LOG=/tmp/expense.log
Print_Headings() {
  echo $1
  echo "############ $1 ##########" &>>$LOG
}
check_status() {
  if [ $1 -eq 0 ]; then
      echo -e "\e[32mSuccess\e[0m"
  else
      echo -e "\e[31mFailure\e[0m"
      exit 1
  fi
}
input_validation(){
if [ -z "$1" ]; then
    echo -e "\e[35mPassword Missing\e[0m"
    exit 2
fi
}


App_PreReq(){
  Print_Headings "Remove old content"
  rm -rf ${app_dir}
  check_status $?


  Print_Headings "Creating App dir"
  mkdir ${app_dir}
  check_status $?

  Print_Headings "Downloading content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  check_status $?

  Print_Headings "Extracting app contents"
  cd ${app_dir}
  unzip /tmp/${component}.zip &>>$LOG
  check_status $?

}