package SVN::Authnz::ACL::Role::Groups;

use Moo::Role;
use SVN::Authnz::ACL::Group;

has _mapGroups => (
	is 			=> 'ro',
	init_arg 	=> undef,
	default		=> sub { {} }
);

sub groups {
	my ($self) = @_;
	
	return [$self->_mapGroups];
}

sub addGroup{
	my ($self, $group) = @_;
	
	my $oGroup;
	# check if we deal with object reference, or just string
	if ( ref $group eq 'SVN::Authnz::ACL::Group' ) {
		# check if we already have such object
		if (exists $self->_mapGroups->{$group->name} ) {
			$oGroup = $self->_mapGroups->{$group->name};
		} 
		# and if not, add it
		else {
			$oGroup = $group;
			$self->_mapGroups->{$oGroup->name} = $oGroup;
		}
	} 
	# same scenario for string
	else {
		if (exists $self->_mapGroups->{$group} ) {
			$oGroup = $self->_mapGroups->{$group};
		} else {
			$oGroup = SVN::Authnz::ACL::Group->new( name => $group );
			$self->_mapGroups->{$oGroup->name} = $oGroup;
		}
	}
	
	return $oGroup;
}

1;