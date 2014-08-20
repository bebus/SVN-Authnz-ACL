package SVN::Authnz::ACL::Resource;

use Moo;

has location => (
	is 			=> "ro",
	required 	=> 1
);

has repoName => (
	is 			=> "ro",
	required 	=> 1
);

has rules => (
	is			=> 'ro',
	

);

1;