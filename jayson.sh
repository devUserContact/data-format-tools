#!/bin/bash
set -u

# exploit the JMESpath length() function to get a count of list elements to iterate
export COUNT=$(jq '.work' gallery.json | jq '. | length')

# The `seq` command produces the sequence `0 1 2` for our indexes
# The $(( )) operator in bash produces an arithmetic result ($COUNT minus one)
for i in $(seq 0 $((COUNT - 1))); do
  # The list elements in JMESpath are zero-indexed
  #     echo "Here is element $i:"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".title")^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".year_created")^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".medium")^"
  echo -n "[$(cat gallery.json | jq ".work[$i]" | jq ".size[0]" | awk -v q="\"" '{print q $1 q}'), $(cat gallery.json | jq ".work[$i]" | jq ".size[1]" | awk -v q="\"" '{print q $1 q}')]^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".image_url")^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".number")^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".description") ^"
  echo -n "$(cat gallery.json | jq ".work[$i]" | jq -r ".price")^"
  if [[ "$(cat gallery.json | jq ".work[$i]" | jq ".sold")" == "false" ]]; then echo -n "0^"; else echo -n "1^"; fi
  if [[ "$(cat gallery.json | jq ".work[$i]" | jq ".accepting_offer")" == "false" ]]; then echo "0"; else echo "1"; fi

  # Add or replace whatever operation you like here.

done
