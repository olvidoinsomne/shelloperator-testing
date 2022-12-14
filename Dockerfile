#adding unneccesary comment

FROM flant/shell-operator:latest
ADD pods-hook.sh /hooks
ADD pods-master.sh --config /hooks
