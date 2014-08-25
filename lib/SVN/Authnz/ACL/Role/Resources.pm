package SVN::Authnz::ACL::Role::Resources;

use Moo::Role;
use SVN::Authnz::ACL::RootResource;

has root => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub {
		SVN::Authnz::ACL::RootResource->new()
	}
);

sub resource {
	my $self = shift;
	my @params = @_;
	
}

sub addResource {
	my ($self, $resource) = @_;
	
	my ($loc, $repo);
	
	if ( $resource =~ /\/(.*)$/) {
		$loc = $1;
	}
	if ( $resource =~ /^(\S+)\:/) {
		$repo = $1;
	}
	
	if ( !$repo and !$loc ) {
		$self->root->_storable(1);
	} elsif ( !$repo and $loc ) {
		$self->root->child('/', split('/', $loc));
	} elsif ( $repo and !$loc ) {
		$self->root->repo($repo)->child('/');
	} else {
		$self->root->repo($repo)->child('/', split('/', $loc));
	}
}

1;