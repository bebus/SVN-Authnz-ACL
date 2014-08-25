package SVN::Authnz::ACL::RootResource;

use Moo;
use SVN::Authnz::ACL::Repository;
use SVN::Authnz::ACL::Resource;

with 'SVN::Authnz::ACL::Role::Children';

has resource => (
	is => "ro",
	init_arg 	=> undef,
	default => sub { '/' }
);

has rules => ( is => 'ro', );

has _storable => (
	is => "rw",
	default => sub { 0; }
);

sub repo {
	my $self = shift;
	my $repo = shift;	
	
	if ( !exists $self->children->{$repo} ) {
		$self->children->{$repo} = SVN::Authnz::ACL::Repository->new(
			repoName => $repo,
		);
	}
	
	return $self->children->{$repo};
}

1;