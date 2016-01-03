use strict;
use warnings;
use Test::Clustericious::Cluster;
use Test::More tests => 2;
use Math::Client;

my $cluster = Test::Clustericious::Cluster->new;
$cluster->create_cluster_ok('Math');

my $client = Math::Client->new;

is $client->fib(6), 8, 'fib(6) = 8';

__DATA__

@@ etc/Math.conf
---
url: <%= cluster->url %>

@@ lib/Math.pm
use strict;
use warnings;

package Math {

  use base qw( Clustericious::App );
  use Clustericious::RouteBuilder;
  
  get '/fib/6' => sub {
    my($c) = @_;
    $c->render(autodata => [ 8 ]);
  };
  
}

1;
