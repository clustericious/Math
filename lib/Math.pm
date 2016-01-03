use strict;
use warnings;

package Math {

  use base qw( Clustericious::App);
  use Clustericious::RouteBuilder;

  get '/add/:a/:b' => sub {
    my($c) = @_;
    $c->render(autodata => [$c->param('a') + $c->param('b')]);
  };

  get '/fib/:n' => sub {
    my($c) = @_;
    my $n = $c->param('n');
    my $client = $c->client;
    return $c->reply->not_found if $n < 0;
    return $c->render(autodata => [ 1 ]) if $n < 3;
    $c->render(autodata => [ $client->fib($n-1) + $client->fib($n-2) ]);
  };

}

1;
