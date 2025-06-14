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