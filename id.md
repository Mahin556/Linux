```bash

id jane
uid=1005(jane) gid=1005(jane) groups=1005(jane)

id -u #current user id

id -un  #current user name

id -u jane
1500

id -un jane
jane

id -g  #give primary group of current user

id -g jane  #give primary group id
1500

id -gn jane  #give primary group name
users

id -Gn #give group membership of current user

id -Gn root #give group membership of specific user

echo "The current username is '$USER'."
printf "The current username is '%s'.\n" "$USER"
id
whoami

```