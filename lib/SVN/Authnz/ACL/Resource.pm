package SVN::Authnz::ACL::Resource;

use Moo;

has section => ( 
	is => 'lazy',
	default => sub {		
		($_[0]->repository ? $_[0]->repository . ':' : '') . $_[0]->location; 
	}
);

has location => (
	is => "ro",
	required => 1
);

has repository => (
	is => "ro"
);

has rules => ( is => 'ro', );

around BUILDARGS => sub {
	my $orig = shift;
	my $self = shift;
	
	#use original BUILDARGS first
	my $rhArguments = $orig->($self, @_);
	
	if ( exists $rhArguments->{section} ) {
		if ( $rhArguments->{section} =~ /(\/.*)$/) {
			$rhArguments->{location} 	= $1;
		}
		if ( $rhArguments->{section} =~ /^(\S+)\:/) {
			$rhArguments->{repository} 	= $1;
		}
	}
	
	return $rhArguments;
};

sub equals {
	my ( $self, $oRes ) = @_;

	if ( $self->location eq $oRes->location	and $self->repository eq $oRes->repository ) {
		return 1;
	}
	else {
		return 0;
	}
}

1;
