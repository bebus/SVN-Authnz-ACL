package SVN::Authnz::ACL::Role::AuthRules;

use Moo::Role;

has rules => (
	is => 'ro',
	init_arg 	=> undef,
	default => sub { {
		'rw'	=> [],
		'r'		=> [],
		''		=> []
	} }
);

has _storable => (
	is => "rw",
	default => sub { 0; }
);

sub authorize {
	my $self = shift;
	if ( @_ % 2 != 0) {
		
	}
	
	push @{$self->rules->{$_[1]}}, $_[0]; 
}

1;