package SVN::Authnz::ACL::Resource;

use Moo;

has section => ( 
	is => 'lazy',
	default => sub {		
		($_[0]->repository ? $_[0]->repository . ':' : '') . $_[0]->location; 
	}
);

has resource => (
	is => "ro",
	required => 1
);

has repository => (
	is => "ro",
);

has parent => (
	is => "rw",
	default => sub { undef }
);

has child => (
	is => "rw"
);

has rules => ( is => 'ro', );

has _storable => (
	is => "rw",
	default => sub { 1; }
);

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

around repository => sub {
    my $orig = shift;
    my $self = shift;
    
    if ( !defined $self->parent ) {
    	return $self->parent->repository(@_);
    } else {
    	return $orig->($self, @_);
    }
};

sub isTouched {
	my $self = shift;
	
	1;
}

1;
