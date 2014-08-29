package SVN::Authnz::ACL::Role::Groups;

use Moo::Role;
use SVN::Authnz::ACL::Group;

has _mapGroups => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { { '*' => SVN::Authnz::ACL::Group->new( name => '*' )} }
);

sub groups {
	my ($self) = @_;
	
	return [$self->_mapGroups];
}

sub existsGroup {
	my ($self, $group) = @_;
	
	if (exists $self->_mapGroups->{$group} ) {
		return $self->_mapGroups->{$group};
	} else {
		return undef;
	}	
}

sub addGroup{
	my ($self, $group) = @_;
	
	my $oGroup;

	if ( $oGroup = $self->existsGroup($group) ) {
#		$oGroup = $self->_mapGroups->{$group};
	} else {
		$oGroup = SVN::Authnz::ACL::Group->new( name => $group );
		$self->_mapGroups->{$oGroup->name} = $oGroup;
	}

	
	return $oGroup;
}

1;