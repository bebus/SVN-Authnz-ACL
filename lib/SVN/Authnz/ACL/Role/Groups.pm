package SVN::Authnz::ACL::Role::Groups;

use Moo::Role;
use SVN::Authnz::ACL::Group;

has groups => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { [] }
);

1;