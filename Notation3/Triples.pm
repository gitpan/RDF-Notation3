use strict;
use warnings;

package RDF::Notation3::Triples;

require 5.005_62;
use RDF::Notation3;
use RDF::Notation3::Template::TTriples;

############################################################

@RDF::Notation3::Triples::ISA = 
  qw(RDF::Notation3 RDF::Notation3::Template::TTriples);


sub _process_statement {
    my ($self, $subject, $properties) = @_;
    $subject = $self->_expand_prefix($subject);

    foreach (@$properties) {
	$_->[0] = $self->_expand_prefix($_->[0]);

	for (my $i = 1; $i < scalar @$_; $i++ ) {
	    $_->[$i] = $self->_expand_prefix($_->[$i]);

	    push @{$self->{triples}}, 
	      [$subject, $_->[0], $_->[$i], $self->{context}];
	}
    }
}


sub _expand_prefix {
    my ($self, $qname) = @_;

    foreach (keys %{$self->{ns}->{$self->{context}}}) {
	$qname =~ s/^$_:(.*)$/<$self->{ns}->{$self->{context}}->{$_}$1>/;
    }

    if ($qname =~ /^([_a-zA-Z]\w*)*:[a-zA-Z]\w*$/) {
	$self->_do_error(6, $qname);
    }

    return $qname;
}


1;


__END__
# Below is a documentation.

=head1 NAME

RDF::Notation3::Triples - RDF/N3 triple generator

=head1 LICENSING

Copyright (c) 2001 Ginger Alliance. All rights reserved. This program is free 
software; you can redistribute it and/or modify it under the same terms as 
Perl itself. 

=head1 AUTHOR

Petr Cimprich, petr@gingerall.cz

=head1 SEE ALSO

perl(1), RDF::Notation3.

=cut
