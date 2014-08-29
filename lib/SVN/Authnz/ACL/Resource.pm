package SVN::Authnz::ACL::Resource;

use Moo;
with 'SVN::Authnz::ACL::Role::Children';
with 'SVN::Authnz::ACL::Role::AuthRules';

has resource => (
	is => "ro",
	required => 1
);

has parent => (
	is => "rw",
	default => sub { undef }
);

1;
