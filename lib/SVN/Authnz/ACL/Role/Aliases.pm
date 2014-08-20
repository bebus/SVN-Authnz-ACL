package SVN::Authnz::ACL::Role::Aliases;

use Moo::Role;
use SVN::Authnz::ACL::Alias;

has aliases => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { [] }
);

1;