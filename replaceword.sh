grep -rn . -e ${1} | awk '{split ($0,a,":");print a[1]}' | sort -u | xargs sed -i s/${1}/${2}/g
