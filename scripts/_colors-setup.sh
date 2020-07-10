#!/usr/bin/env bash
export TERM=xterm

# Terminal colors
DEFAULT=$(tput setaf 7 -T xterm)
RED=$(tput setaf 1 -T xterm)
GREEN=$(tput setaf 2 -T xterm)
YELLOW=$(tput setaf 3 -T xterm)
BLUE=$(tput setaf 4 -T xterm)
OK="${GREEN}PASS${DEFAULT}"
FAIL="${RED}FAIL${DEFAULT}"
