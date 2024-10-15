<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'database_name_here');

/** MySQL database username */
define('DB_USER', 'username_here');

/** MySQL database password */
define('DB_PASSWORD', 'password_here');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );
/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
define( 'WP_ALLOW_REPAIR', true );
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'Wacv15b46tKOjjGC4m1vmAkCFYJ1gn3jFsu6GjIdvUUcflCwAx_RjmVyKIg5OC_stvs9-kNU_U8wxZtEX--YFA');
define('SECURE_AUTH_KEY',  'saIi-8BPoz-7dYwyTVVRqlYSgcpfmwLK_4iQMNj-92eADb2X8BLKEEXjiCNVxEerne2EXF3tkN610U-y9LQq9A');
define('LOGGED_IN_KEY',    '8GFhc29CGoc1YCPdtr8ao0jR-uqrCMs2WKC9b5EMxXXqElrHg_5JeKthYiARanirQhupVGxT0mY9eCN-9HBQrQ');
define('NONCE_KEY',        'tsXfURW5pT-JKk1AMvDakMV-PQMnX70CD3dkgIkUSOmj781_4K-WAL5W3YKRwQusAkcTUrTNYu9hC1sXXL4z-A');
define('AUTH_SALT',        'Wu8HUsVOmWplfnSNDxyDo5BD2fEbKK9WiVGVatUod24aCKlJTsDeREykIXWI1VrUBhI2KYR-WkN89Q9SXLgOrA');
define('SECURE_AUTH_SALT', '9Gr5zFqWoYLGDbDkhFjn3jVOgCZazXOtV5FexZb2xFkmBi15LIZNz7q6enltu21fxSQj35tUq4vJZ2cycryoyQ');
define('LOGGED_IN_SALT',   'fkPV4UEWwfFmu7Du07XO_EKyAqxzioy45Ej33jO3eT0I7C6GaZvtpPJ5XT7RwkjFn5sQ8R5nLItS7-QjedN5tw');
define('NONCE_SALT',       'oDcrQqlUuGUiC2QYc-N_ifFQHdkiLhBGeGeDbHX4ZfZUOlzZV7srjEwwEDgmjP-f00nnzkikyasFF5geIzdgoQ');

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define('WP_CACHE', true);
/**#@-*/
/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );
/* That's all, stop editing! Happy publishing. */
/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>