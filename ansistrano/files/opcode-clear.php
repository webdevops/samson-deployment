<?php

// Zend opcode cache
if (function_exists('opcache_reset')) {
    opcache_reset();
}

// APC opcode cache
if (function_exists('apc_clear_cache')) {
    apc_clear_cache();
}

echo "ok";
