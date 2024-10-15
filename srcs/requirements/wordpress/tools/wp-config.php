<?php

# database configuration
define('DB_NAME', 'my_database');
define('DB_USER', 'my_user');
define('DB_PASSWORD', 'my_password');
define('DB_HOST', 'localhost');

# database charset to use in creating database tables
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

# allow database repair
define( 'WP_ALLOW_REPAIR', true );

# Authentication Unique Keys and Salts for security
define('AUTH_KEY',         'WZ1>%sbc{@)0@Yc=:a*#cfm/4Zw.uA6v>xx=|,!9l_(}5<iqSc!yRm#2]6>2~15L');
define('SECURE_AUTH_KEY',  'bg30rjoU?6}f?bF,D;QIG3|,$BGa3Neh^o.0g*v2Ei]m.61a!2W4(4? 1fr^z)~f');
define('LOGGED_IN_KEY',    '<n_K+k:qHU?{pSI6Lw;?|]vu-mkzZ)L#DBS5Bd5[OFcL%lv$k)_I:STc=3e@hv@}');
define('NONCE_KEY',        'oELd-9zl6~SaB4|qc8U+2Mi0WgkDj[W&Q*$#x6tK:+a-D<sx4R<E#[!=dZei2f2h');
define('AUTH_SALT',        '0)s3Sp@2c[_+h861Cs08+Q Yc*ef8VUw z/%t_P$N:V$$9C_cVUc0PkB1!eb[+qp');
define('SECURE_AUTH_SALT', 'Zo<b]nu(|Fa6zdWT(AV]B+AL-`+OubHS9iGam;Pmz *CE|[qIcfNq9+9C|6c1KZd');
define('LOGGED_IN_SALT',   'A=#C5Y(yKbUx&+D9HnUJKc)uZ`UYvA6yA|~N?P|3%BwfT@P4-lFvvd|_^pc?-*+9');
define('NONCE_SALT',       'Cg1I`qI;-V]#MRK8A:nn:F6lRug+aV3>Q9A#qR@-C>I&af4%`^$XQ*irKz(u.-2b');

# Redis configuration- Redis is an open source storage system that can be used as a database, cache.
# Redis stores in RAM, so it is faster than disk storage.
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define('WP_CACHE', true);

$table_prefix = 'wp_';

# enable debug mode
define( 'WP_DEBUG', true );


# define the absolute path to the WordPress directory
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

# include the wp setting file
require_once ABSPATH . 'wp-settings.php';
?>