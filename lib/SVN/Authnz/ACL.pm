package SVN::Authnz::ACL;

use Moo;

with 'SVN::Authnz::ACL::Role::Groups';
with 'SVN::Authnz::ACL::Role::Aliases';
with 'SVN::Authnz::ACL::Role::Resources';


=head1 NAME

SVN::Authnz::ACL - The great new SVN::Authnz::ACL!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use SVN::Authnz::ACL;

    my $foo = SVN::Authnz::ACL->new();
    ...

=cut

has acl => (
	is			=> 'ro',
	required	=> 1

);

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub load {
	my ($self) = @_;
	
	my $i = 0;
	my $sCurrentResourceName;
	my $sCurrentObject;
	if (open(my $hACL, "<", $self->acl)) {
		while (my $line = <$hACL>) {
			
			if (++$i % 1000 == 1) {
				print $i . "\n";
			}
			
			chomp $line;
			next if !$line or $line =~ /^\s*#/; #skip empty lines or comments
			
			# check if this will be resource group or alias definition block
			if ($line =~ /^\[\s*(.+?)\s*\]$/) {
	            
				# case of aliases block
				if ( lc $1 eq 'aliases' ) {
					$sCurrentResourceName = 'alias';
				}
				# case of groups block
				elsif ( lc $1 eq 'groups' ) {
					$sCurrentResourceName = 'group';
				}				
				# case resource
				else {
					$sCurrentResourceName = 'resource';
					$sCurrentObject = $self->addResource($1);
				}
	        }
	        
	        # rest there are members / attributes of resoureces
	        else {
	        	my ($k, $v) = $line =~ /^(.+?)\s*=\s*(.*?)$/;	        	
	        	
	        	if ( $sCurrentResourceName eq 'group' ) {
	        		$self->addGroup($k);
	        	} elsif ( $sCurrentResourceName eq 'resource' ) {
	        		$k =~ s/^\@//;
	        		if (my $oGroup = $self->existsGroup($k)) {
	        			$sCurrentObject->authorize( $oGroup => $v );
	        		}
	        	}
	        }
		}
		close $hACL;
	}
}


=head1 AUTHOR

'bebus', C<< <'pawel.szymczak1 at gmail.com'> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-svn-authnz-acl at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SVN-Authnz-ACL>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SVN::Authnz::ACL


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SVN-Authnz-ACL>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SVN-Authnz-ACL>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SVN-Authnz-ACL>

=item * Search CPAN

L<http://search.cpan.org/dist/SVN-Authnz-ACL/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 'bebus'.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of SVN::Authnz::ACL
