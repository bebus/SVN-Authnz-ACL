package SVN::Authnz::ACL::Role::Resources;

use Moo::Role;
use SVN::Authnz::ACL::Resource;

has _mapResources => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { {} }
);

sub resources {
	my ($self) = @_;
	return [values $self->_mapResources];
}

sub addResource {
	my ($self, $resource) = @_;
	
	my $oRes;
	# check if we deal with object reference, or just string
	if ( ref $resource eq 'SVN::Authnz::ACL::Resource' ) {
		# check if we already have such object
		if (exists $self->_mapResources->{$resource->section} ) {
			$oRes = $self->_mapResources->{$resource->section};
		} 
		# and if not, add it
		else {
			$oRes = $resource;
			$self->_mapResources->{$oRes->section} = $oRes;
		}
	} 
	# same scenario for string
	else {
		if (exists $self->_mapResources->{$resource} ) {
			$oRes = $self->_mapResources->{$resource};
		} else {
			$oRes = SVN::Authnz::ACL::Resource->new( section => $resource );
			$self->_mapResources->{$oRes->section} = $oRes;
		}
	}
	
	return $oRes;
}

1;