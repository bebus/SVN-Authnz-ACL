package SVN::Authnz::ACL::Repository;

use Moo;
with 'SVN::Authnz::ACL::Role::Children';

has repoName => (
	is => 'ro',
	required => 1
);

1;