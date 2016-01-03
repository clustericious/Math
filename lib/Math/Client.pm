use strict;
use warnings;
use experimental qw( signatures );

package Math::Client {

  use Mojo::URL;
  use base qw( Clustericious::Client );

  sub fib ($self, $n)
  {
    my $url = Mojo::URL->new($self->config->url);
    $url->path("/fib/@{[ $n ]}");
    $self->ua->get($url)->res->json->[0];
  }

}

1;
