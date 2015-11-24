package Data::Query;
use 5.008001;
use strict;
use warnings;
use parent qw(Hash::MultiValue);
use List::MoreUtils qw(all);

our $VERSION = "0.01";

sub parse {
    my ($class, $space_separated_inputs) = @_;
    my $self = $class->new;
    for my $expr (split /\s+/, $space_separated_inputs) {
        my ($key, $value) = split '=', $expr;
        next unless defined $value;
        $self->add($key, sub { $_[0] eq $value });
    }
    return $self;
}

sub matches {
    my ($self, $target) = @_;
    my $matched = 1;
    my $multi = $self->multi;
    for my $k (keys %$self) {
        my $matchers = $multi->{$k};
        my $v = $target->{$k};
        unless (all { $_->($v) } @$matchers) {
            $matched = 0;
            last;
        }
    }
    return $matched;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Query - It's new $module

=head1 SYNOPSIS

    use Data::Query;

=head1 DESCRIPTION

Data::Query is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

