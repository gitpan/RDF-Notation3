use strict;
use warnings;

package RDF::Notation3::ReaderFile;

require 5.005_62;
use RDF::Notation3::Template::TReader;

############################################################

@RDF::Notation3::ReaderFile::ISA = qw(RDF::Notation3::Template::TReader);

sub new {
    my ($class, $fh) = @_;

    my $self = {
		FILE => $fh,
		tokens => [],
		ln => 0,
	       };

    bless $self, $class;
    return $self;
}

sub _new_line {
    my ($self) = @_;

    my $fh = $self->{FILE};
    my $line = '';

    until ($line) {
	$line = <$fh>;
	$self->{ln}++;

	$line =~ s/^\s*(.*)$/$1/;
	$line =~ s/^(#.*)$//;

	if ($line) {
	    push @{$self->{tokens}}, split /\s+/, $line;
	    push @{$self->{tokens}}, ' EOL ';
	}
	if (eof) {
	    push @{$self->{tokens}}, ' EOF ';
	    return;
	}
    }
}


1;

__END__
# Below is a documentation.

=head1 NAME

RDF::Notation3::ReaderFile - RDF Notation3 file reader

=head1 LICENSING

Copyright (c) 2001 Ginger Alliance. All rights reserved. This program is free 
software; you can redistribute it and/or modify it under the same terms as 
Perl itself. 

=head1 AUTHOR

Petr Cimprich, petr@gingerall.cz

=head1 SEE ALSO

perl(1), RDF::Notation3.

=cut

