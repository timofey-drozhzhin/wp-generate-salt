#!/bin/bash

set -e

# Print usage
print_usage() {
  echo "This helper generates WordPress salt values."
  echo
  echo "usage: $(dirname "$0")/$(basename "$0") [--length=\"64\"] [--no-special-chars] [--no-extra-special-chars]"
  echo
  echo "optional arguments:"
  echo "  --no-extra-special-chars   Exclude extra special characters, e.g. -_ []{}<>~\`+=,.;:/?|"
  echo "  --no-special-chars         Exclude special characters, e.g. !@#$%^&*()"
  echo "  --length=num               (default: 64) Length of the salt values"
  echo "  --help"
  echo
}

# Default values
no_extra_special_chars=0
no_special_chars=0
length=64

# Arguments handling
while (( ${#} > 0 )); do
  case "${1}" in
    ( '--no-extra-special-chars' ) no_extra_special_chars=1 ;;
    ( '--no-special-chars' ) no_special_chars=1 ;;
    ( '--length='* ) length="${1#*=}" ;;
    ( * ) print_usage
          exit 1;;
  esac
  shift
done

# Functions

#
# Generates a random password drawn from the defined set of characters.
# Inspired by WordPress function https://developer.wordpress.org/reference/functions/wp_generate_password/
#
# Parameters
# ----------
# $length
#   (int) (Optional) Length of password to generate.
#   Default value: 12
# $special_chars
#   (bool) (Optional) Whether to include standard special characters.
#   Default value: true
# $extra_special_chars
#   (bool) (Optional) Whether to include other special characters. Used when generating secret keys and salts.
#   Default value: false
#
function wp_generate_password() {
  # Args
  local length="$(test $1 && echo $1 || echo 12 )"
  local special_chars="$(test $2 && echo $2 || echo 1 )"
  local extra_special_chars="$(test $3 && echo $3 || echo 0 )"

  chars='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  [[ $special_chars != 0 ]] && chars="$chars"'!@#$%^&*()'
  [[ $extra_special_chars != 0 ]] && chars="$chars"'-_ []{}<>~`+=,.;:/?|'

  password='';
  for i in $(seq 1 $length); do
  password="${password}${chars:$(( RANDOM % ${#chars} )):1}"
  done

  echo "$password"
}

# Process variables
if [ $no_special_chars = 1 ]; then special_chars=0; else special_chars=1; fi
if [ $no_extra_special_chars = 1 ]; then extra_special_chars=0; else extra_special_chars=1; fi

# Generate Salt Values
echo "define('AUTH_KEY',         '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('SECURE_AUTH_KEY',  '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('LOGGED_IN_KEY',    '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('NONCE_KEY',        '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('AUTH_SALT',        '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('SECURE_AUTH_SALT', '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('LOGGED_IN_SALT',   '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"
echo "define('NONCE_SALT',       '$(wp_generate_password "$length" "$special_chars" "$extra_special_chars")');"