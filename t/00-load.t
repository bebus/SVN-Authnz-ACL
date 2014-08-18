#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'SVN::Authnz::ACL' ) || print "Bail out!\n";
}

diag( "Testing SVN::Authnz::ACL $SVN::Authnz::ACL::VERSION, Perl $], $^X" );
