# Description
This shell script generates WordPress salt values on its own.

Unlike most other scripts, this script does not fetch values from https://api.wordpress.org/secret-key/1.1/salt/. 
Instead, it uses a built-in function that generates the salt values identical to the WordPress website. To do this, the 
original WordPress wp_generate_password() function has been converted from PHP to shell.

The following options are available:

- `--no-extra-special-chars` Exclude extra special characters, e.g. -_ []{}<>~\`+=,.;:/?|"
- `--no-special-chars` Exclude special characters, e.g. !@#$%^&*()"
- `--length=num` (default: 64) Length of the salt values
- `--help`

# Example Usage & Output
## Example 1
Generate salt values identical to https://api.wordpress.org/secret-key/1.1/salt/

```bash
./wp-generate-salt.sh
```

## Example 2
Generate salt values consisting only of lowercase/uppercase letters and numbers

```bash
./wp-generate-salt.sh --no-extra-special-chars --no-special-chars
```

Results:
```
define('AUTH_KEY',         'i7swshNEQwFUB3H5w8tveidix7y0fn69d7yG8NzmkTiSKTjuPPNqJEvWvqUxJhBD');
define('SECURE_AUTH_KEY',  'gpCJkNld8Cbx0Qyk90UYSkzl0KEJAZFCO3PkbcUI0fFuxvjTXOo1EeOiKqxwntRW');
define('LOGGED_IN_KEY',    'eGNqbjTNrdHGT8o5hRkWwTrRYShsU8IAUv7YIAL4GB2DkANNyg0CzOCawqE11E7K');
define('NONCE_KEY',        'csXDxQVmJjdPhVekoILpaWMUXvnbILh3urSCLvDUPXTg7cgbGe6duoV2MUL0GQn3');
define('AUTH_SALT',        'aK7QpStrxpdtaJ552zcniuEqVDZT3ok14T9hOUuhvjgSUhgAOdHlpvKV1UovQ1Dl');
define('SECURE_AUTH_SALT', 'C1i3go00QvJC30Vl9qDQW30Xog66nxTuEPrVRimDaFCvGSJYpFjWk5zhNUvuudTa');
define('LOGGED_IN_SALT',   'zjsg8Uyz8BffsOL6hhANA6RZmoIPH9WsfhI3oHdZQ1ZEtYdmxEpxfFS92oCZ9o9s');
define('NONCE_SALT',       'xBDt0qA9qcLok5ClV81heEdwl1Px2MvVPJ0HrC4lwnmhgzdg9C09afH1OofuNAph');
```

## Example 3
Generate salt values consisting only of lowercase/uppercase letters and numbers, 32 characters long

```bash
./wp-generate-salt.sh --no-extra-special-chars --no-special-chars --length=32
```

Results:
```
define('AUTH_KEY',         '4zshHz5w7xk5URSU3spK0nwFXuv8Av6u');
define('SECURE_AUTH_KEY',  '2lCuyBD5pEkIj8I9akQdEWocW7CQo89s');
define('LOGGED_IN_KEY',    '0DNHq7bEdeQRbWzUObhbiuKeVfe3JhIV');
define('NONCE_KEY',        'CF1t47TfsR2dxtbUE9SE8SJLI5SwkWid');
define('AUTH_SALT',        'AXbGWErOKX2mWh1FL0jBMr4iGdvfEzlG');
define('SECURE_AUTH_SALT', 'yflTOGtU23yvO4SVTRK5q0WkFQBrYcVE');
define('LOGGED_IN_SALT',   '0wwAFc1tl948HmIGxIb243iR8YeajlY7');
define('NONCE_SALT',       'YOGNxIz29gAh69yVEACvIB9T6BkTDYx5');
```