#!/bin/bash

current_cov=$(mix test.coverage | grep Total | cut -d'|' -f1 | tr -d ' %')
accepted_cov=$(cat .coverage)
(( $(echo "$current_cov >= $accepted_cov" | bc) )) && echo "Coverage OK: $current_cov" \
  || (echo "Coverage NOT OK: $current_cov vs $accepted_cov" && exit 1)
