#!/bin/sh

function notify_preexec {
  notif_prev_executed_at=`date`
  notif_prev_command=$2
}

function notify_precmd {
  notif_status=$?
  if [ -n "${CMD_NOTIFY_SLACK_WEBHOOK_URL+x}" ] && [ -n "${CMD_NOTIFY_SLACK_USER_NAME+x}" ] && [ $TTYIDLE -gt ${SLACK_NOTIF_THRESHOLD:-180} ] && [ $notif_status -ne 128 ] && [ $notif_status -ne 129 ] && [ $notif_status -ne 130 ] &    & [ $notif_status -ne 146 ]; then
    secretary $notif_prev_command $notif_status $notif_prev_exec_at `($TTYIDLE / 60) min ($TTYIDLE % 60) sec`

  fi
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec notify_preexec
add-zsh-hook precmd notify_precmd

