package SVN::Authnz::ACL::Role::Children;

use Moo::Role;

has children => (
	is => "ro",
	init_arg 	=> undef,
	default => sub { {} }
);

sub addChild {
	my $self = shift;
	my $obj = shift;
	
	$self->children->{ $obj->name } = $obj;
}

sub child {
	my $self = shift;
	my @aResources = @_;	
	
	if ( @aResources ) {
		my $loc = shift @aResources;
		if ( !exists $self->children->{$loc} ) {
			$self->children->{$loc} = SVN::Authnz::ACL::Resource->new(
				resource => $loc,
				parent => $self,
				_storable => (scalar @aResources ? 0 : 1) 
			);
		}
		
		if ( @aResources ) {
			return $self->children->{$loc}->child(@aResources);
		} else {
			return $self->children->{$loc};
		}
	} else {
		return undef;
	}
}

1;