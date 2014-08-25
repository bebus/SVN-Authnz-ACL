package SVN::Authnz::ACL::Resource;

use Moo;
with 'SVN::Authnz::ACL::Role::Children';

has resource => (
	is => "ro",
	required => 1
);

has parent => (
	is => "rw",
	default => sub { undef }
);

has rules => ( is => 'ro', );

has _storable => (
	is => "rw",
	default => sub { 0; }
);


1;
