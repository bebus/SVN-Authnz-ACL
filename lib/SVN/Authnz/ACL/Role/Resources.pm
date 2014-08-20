package SVN::Authnz::ACL::Role::Resources;

use Moo::Role;
use SVN::Authnz::ACL::Resource;

has resources => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { [] }
);

1;