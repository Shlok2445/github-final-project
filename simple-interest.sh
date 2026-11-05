#!/usr/bin/env bash

# Simple Interest Calculator
# Formula: Simple Interest = (Principal * Rate * Time) / 100

set -euo pipefail

is_number() {
  [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]
}

read -r -p "Enter principal amount: " principal
read -r -p "Enter annual rate of interest (%): " rate
read -r -p "Enter time period (years): " time

if ! is_number "$principal" || ! is_number "$rate" || ! is_number "$time"; then
  echo "Error: Please enter valid non-negative numbers."
  exit 1
fi

if ! awk -v p="$principal" -v r="$rate" -v t="$time" \
  'BEGIN { exit !(p > 0 && r >= 0 && t > 0) }'; then
  echo "Error: Principal and time must be greater than zero; rate cannot be negative."
  exit 1
fi

awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN {
  interest = (p * r * t) / 100
  total = p + interest
  printf "\nSimple Interest: %.2f\n", interest
  printf "Total Amount:    %.2f\n", total
}'
