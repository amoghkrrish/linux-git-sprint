
(
exit 0
) &
child_pid=$!

sleep 1

wait $child_pid
