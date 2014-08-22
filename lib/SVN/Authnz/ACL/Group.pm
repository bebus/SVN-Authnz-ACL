package SVN::Authnz::ACL::Group;

use Moo;

has name => (
	is 			=> "ro",
	required	=> 1
);

has members => (
	is 			=> 'ro',
	default		=> sub { [] }
);

1;