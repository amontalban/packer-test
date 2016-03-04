#!/usr/bin/env bash

# Remove old builds
rm -f *.box

MAX_RUNS=$1
TEE=$(which tee)
DATE=$(which date)
GREP=$(which grep)
WC=$(which wc)
VBOXMANAGE=$(which vboxmanage)

info() {
    local _i="${@}"
    printf "\e[1;32m[INFO]\e[0m: %s\n" "`${DATE} +'[%D %T]'` ${_i}" >&2
}

error() {
    local _e="${@}"
    printf "\e[1;31m[ERROR]\e[0m: %s\n" "`${DATE} +'[%D %T]'` ${_e}" >&2
}

VMS=$(${VBOXMANAGE} list vms | awk -F\" '{print $2}' | grep 'packer-test' 2>&1 > /dev/null)
VM_EXISTS=$?

# Delete any prior VM with name packer-test
if [ ${VM_EXISTS} -eq 0 ]; then
  ${VBOXMANAGE} unregistervm packer-test --delete 2>&1 > /dev/null
fi

info "Running ${MAX_RUNS} tests."
let MAX_RUNS=${MAX_RUNS}+1
i=1

while [ ${i} -lt ${MAX_RUNS} ]; do
  EPOCH=$(${DATE} +%s)
  START_TIME=$(${DATE})

  info "==== Run ${i} STARTED ===="
  (PACKER_LOG=1 packer build -force test.json) >> test_${EPOCH}.log 2>&1
  STOP_TIME=$(${DATE})
  info "==== Run ${i} FINISHED ===="

  NUMBER_OF_MESSAGES=$(${GREP} 'SALTSTACK HIGHSTATE' test_${EPOCH}.log | ${WC} -l)
  if [ ${NUMBER_OF_MESSAGES} -ne 12 ]; then
    error "Packer failed in run ${i}! Number of messages ${NUMBER_OF_MESSAGES} is different than expected (12)."
    error "Please check test_${EPOCH}.log for further details."
    exit 1
  else
    info "Packer succeded in run ${i}."
  fi
  let i=${i}+1
done
