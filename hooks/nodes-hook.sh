#!/usr/bin/env bash

#create hook helpers directory
mkdir -p /hookHelpers
#set command
#create local script
echo "#!/usr/bin/env bash
kubectlPath=$(which kubectl)
cronCommand="echo nodeCount: $($kubectlPath get nodes -o jsonpath='{.items[*]}' | jq '.kind'| wc -l | awk '{ print $NF }')"
echo $cronCommand | bash " > /hookHelpers/nodeCountCronTab.sh
chmod +x /hookHelpers/nodeCountCronTab.sh
#create crontab entry
echo "* * * * * ""'"$cronCommand"'" >> /etc/crontab"
$cronCommand