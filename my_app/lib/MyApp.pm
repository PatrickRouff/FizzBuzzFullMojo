package MyApp;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/fb')->to('example#fizzbuzz');
  $r->get('/fblancher')->to('example#fblancher');
  $r->get('/sg')->to('single#game');
  $r->get('/menu')->to('menu#menu');
  $r->get('/mg')->to('multi#game');
  $r->get('/guide')->to('menu#guide');
  $r->get('/modes')->to('multi#modes');
  $r->get('/hhh')->to('multi#hhh');
}

1;
