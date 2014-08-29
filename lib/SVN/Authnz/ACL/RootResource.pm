package SVN::Authnz::ACL::RootResource;

use Moo;
use SVN::Authnz::ACL::Repository;
use SVN::Authnz::ACL::Resource;

with 'SVN::Authnz::ACL::Role::Children';
with 'SVN::Authnz::ACL::Role::AuthRules';

has resource => (
	is => "ro",
	init_arg 	=> undef,
	default => sub { '/' }
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